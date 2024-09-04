import 'package:chat_app/views/sign_in_view.dart';
import 'package:chat_app/views/sign_up_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ScholarApp());
}

class ScholarApp extends StatelessWidget {
  const ScholarApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scholar App',
      theme: ThemeData(brightness: Brightness.dark),
      routes: {
        SignInView.route: (context) => const SignInView(),
        SignUpView.route: (context) => const SignUpView(),
      },
      initialRoute: SignInView.route,
    );
  }
}
