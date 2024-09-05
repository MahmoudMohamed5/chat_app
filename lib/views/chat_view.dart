import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/chat_bubble_for_friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});
  static const route = 'chat_view';

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments == null) {
      return Container();
    }
    final email = arguments as String;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Container();
          }

          return Scaffold(
            backgroundColor: AppColors.backgroundLightColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.primaryColor,
              title: Row(
                children: [
                  Image.asset(
                    AppImages.logo,
                    height: 50,
                  ),
                  const Text('Chat'),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(),
                      color: AppColors.backgroundLightColor,
                    ),
                    child: Text(
                      email.substring(0, 2).toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _scrollController,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final message = snapshot.data!.docs[index];
                        return message['id'] == email
                            ? ChatBubble(message: message['message'])
                            : ChatBubbleForFriend(
                                message: message['message'],
                              );
                      },
                    ),
                  ),
                  TextField(
                    controller: _controller,
                    onSubmitted: (value) {
                      try {
                        messages.add({
                          'message': value,
                          'createdAt': DateTime.now(),
                          'id': email,
                        });
                        _controller.clear();
                        _scrollController.animateTo(
                         0 ,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } on FirebaseException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.message!)),
                        );
                      }
                    },
                    style: const TextStyle(color: AppColors.primaryColor),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () { try {
                        messages.add({
                          'message': _controller.text,
                          'createdAt': DateTime.now(),
                          'id': email,
                        });
                        _controller.clear();
                        _scrollController.animateTo(
                         0 ,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } on FirebaseException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.message!)),
                        );
                      }},
                          icon: const Icon(
                            Icons.send,
                            color: AppColors.primaryColor,
                          )),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: 'Type a message...',
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
