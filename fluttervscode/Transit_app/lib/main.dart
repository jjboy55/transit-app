import 'package:flutter/material.dart';
import 'my_textfield.dart';
import 'my_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'forgot_password.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.onTap});
  final Function()? onTap;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //Sign User In
  void signUserIn() async {
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
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
                    "Sign in",
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
                    "Welcome back you've been missed !",
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
            Padding(
              padding: const EdgeInsets.only(
                right: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ForgotPassword();
                            },
                          ),
                        );
                      },
                      child: const Text('Forgot Password?')),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            MyButton(
              onTap: signUserIn,
              text: 'Sign In',
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.6,
                      color: Colors.grey[800],
                    ),
                  ),
                  const Text(
                    "  or continue with  ",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.6,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xffC2C2C2),
                          width: 1,
                          style: BorderStyle.solid)),
                  child: Image.asset(
                    'pictures/google.png',
                    height: 40,
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xffC2C2C2),
                          width: 1,
                          style: BorderStyle.solid)),
                  child: Image.asset(
                    'pictures/twitter.png',
                    height: 40,
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xffC2C2C2),
                          width: 1,
                          style: BorderStyle.solid)),
                  child: Image.asset(
                    'pictures/facebook-logo-2019.png',
                    height: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: widget.onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Don't have an account? Sign Up",
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
