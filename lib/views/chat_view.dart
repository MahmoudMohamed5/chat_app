import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/widgets/chat_bubble_for_friend.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});
  static const route = 'chat_view';

  @override
  Widget build(BuildContext context) {
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
                (ModalRoute.of(context)!.settings.arguments as String)
                    .substring(0, 2)
                    .toUpperCase(),
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
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ChatBubbleForFriend(
                    message: 'Hello, how are you?',
                  );
                },
              ),
            ),
            TextField(
              style: const TextStyle(color: AppColors.primaryColor),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {},
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
  }
}
