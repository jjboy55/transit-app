import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 350,
        height: 55,
        color: const Color(0xff323232),
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: 'Poppins'),
          ),
        ),
      ),
    );
  }
}
