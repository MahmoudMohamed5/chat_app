import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});
  static const route = 'Sign Up';

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool obscureText = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
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
            const CustomTextField(
              hintText: 'Enter your email',
              icon: Icons.email,
              onPressed: null,
            ),
            const SizedBox(height: 20),
            //2. Custom Text Form Field for Password
            CustomTextField(
              hintText: 'Enter your password',
              onPressed: () => setState(() => obscureText = !obscureText),
              obscureText: obscureText,
              icon: obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            const SizedBox(height: 20),
            //3. Custom Button for Login
            CustomButton(
              title: SignUpView.route,
              onPressed: () {},
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
                  child: const Text('Sign Up'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
