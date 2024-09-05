import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/sign_in_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});
  static const route = 'Sign Up';

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool obscureText = false;
  String? email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 100),
                Center(child: Image.asset(AppImages.logo)),
                const Text(
                  'Scholar Chat',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    SignUpView.route,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                //1. Custom Text Form Field for Email
                CustomTextFormField(
                  onChanged: (value) => setState(() => email = value),
                  hintText: 'Enter your email',
                  icon: Icons.email,
                  onPressed: null,
                ),
                const SizedBox(height: 20),
                //2. Custom Text Form Field for Password
                CustomTextFormField(
                  onChanged: (value) => setState(() => password = value),
                  hintText: 'Enter your password',
                  onPressed: () => setState(() => obscureText = !obscureText),
                  obscureText: obscureText,
                  icon: obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                const SizedBox(height: 20),
                //3. Custom Button for Login
                CustomButton(
                  title: SignUpView.route,
                  onPressed: () async {
                    // Add your login logic here
                    if (_formKey.currentState!.validate()) {
                      setState(() => isLoading = true);
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email!,
                          password: password!,
                        );

                        if (!context.mounted) return;
                        Navigator.pushNamed(context, ChatView.route,arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (!context.mounted) return;
                        if (e.code == 'weak-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('The password provided is too weak.'),
                            ),
                          );
                        } else if (e.code == 'email-already-in-use') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'The account already exists for that email.'),
                            ),
                          );
                        }
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Something went wrong.'),
                          ),
                        );
                      }
                      setState(() => isLoading = false);
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    //4. Custom Button for Sign Up
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(SignInView.route),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
