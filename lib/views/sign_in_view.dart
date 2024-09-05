import 'dart:developer';

import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/sign_up_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});
  static const route = 'Sign In';

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  bool obscureText = false;
  String? email, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
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
                    SignInView.route,
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
                  title: SignInView.route,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => isLoading = true);

                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email!,
                          password: password!,
                        );
                        if (!context.mounted) return;
                        Navigator.pushNamed(context, ChatView.route,arguments: email);
                      } on FirebaseAuthException catch (e) {
                        log(e.toString());
                        switch (e.code) {
                          case 'invalid-email':
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Please enter a valid email address.'),
                              ),
                            );
                            break;
                          case 'wrong-password':
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Incorrect password. Please try again.'),
                              ),
                            );
                            break;
                          case 'user-not-found':
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('User not found. Please sign up.'),
                              ),
                            );
                            break;
                          case 'user-disabled':
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'User disabled. Please contact support.'),
                              ),
                            );
                            break;
                          default:
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'An error occurred. Please try again.'),
                              ),
                            );
                            break;
                        }
                      } catch (e) {
                        log(e.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Something went wrong.'),
                          ),
                        );
                      }
                      setState(() => isLoading = false);

                      FocusScope.of(context).unfocus();
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
                        Navigator.pushNamed(context, SignUpView.route);
                      },
                      child: const Text(SignUpView.route),
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
