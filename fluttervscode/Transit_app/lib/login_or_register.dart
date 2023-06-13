import 'package:flutter/material.dart';
import 'package:transit_app/main.dart';
import 'register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({Key? key}) : super(key: key);

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // initial login page
  bool showLoginPage = true;
  // toggle between login and register
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }




  @override
  Widget build(BuildContext context) {
   if(showLoginPage) {
     return MyHomePage(
       onTap:togglePages ,
     );
   }
   else {
     return RegisterPage(
       onTap: togglePages,
     );
   }
  }
}
