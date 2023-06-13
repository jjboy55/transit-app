import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transit_app/auth_page.dart';
import 'my_button.dart';
import 'my_textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  void passwordReset() async {
    // show loading screen
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xffC2C2C2),
          ),
        );
      },
    );
    // try sign in

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);

      // pop the loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  // wrong email popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(
                  fontFamily: 'Poppins', color: Colors.black, fontSize: 15),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const AuthPage();
                        },
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Back',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              'Enter the email associated with your account and we,ll send an email with instructions to reset your password. ',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  decoration: TextDecoration.none,
                  height: 1.2,
                  color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          MyTextField(
            controller: emailController,
            hintText: 'Email address',
            obscureText: false,
          ),
          const SizedBox(
            height: 40,
          ),
          MyButton(
            onTap: passwordReset,
            text: 'Send Instructions',
          ),
        ],
      ),
    );
  }
}
