import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'my_textfield.dart';
import 'my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.onTap});
  final Function()? onTap;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final matricNumberController = TextEditingController();
  final departmentController = TextEditingController();

  //Sign User Up
  void signUserUp() async {
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
    // try sign up

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        // add user details
        addUserDetails(
          int.parse(phoneNumberController.text),
          matricNumberController.text,
          departmentController.text,
        );
      } else {
        showErrorMessage("Passwords don't match!");
      }
      // pop the loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void addUserDetails(
    int phoneNumber,
    String matricNumber,
    String department,
  ) async {
    await FirebaseFirestore.instance.collection('jerry').add({
      'phone number': phoneNumber,
      'matric number': matricNumber,
      'department': department,
    });
  }

  // wrong email popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
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
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 40,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Enter your details correctly",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        decoration: TextDecoration.none,
                        color: Colors.black54),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            MyTextField(
              controller: emailController,
              hintText: 'Email address',
              obscureText: false,
            ),
            const SizedBox(height: 10),
            MyTextField(
                controller: passwordController,
                obscureText: true,
                hintText: 'Password'),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
                controller: confirmPasswordController,
                obscureText: true,
                hintText: 'Confirm Password'),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
                controller: phoneNumberController,
                obscureText: false,
                hintText: 'Phone Number'),
            const SizedBox(height: 10),
            MyTextField(
                controller: matricNumberController,
                obscureText: false,
                hintText: 'Mat.No/Staff ID'),
            const SizedBox(height: 10),
            MyTextField(
                controller: departmentController,
                obscureText: false,
                hintText: 'Department'),
            const SizedBox(height: 30),
            MyButton(
              text: 'Sign Up',
              onTap: signUserUp,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: widget.onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Have an account? Login",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
