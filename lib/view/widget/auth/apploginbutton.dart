import 'package:flutter/material.dart';

class AppSignUpAndLoginButton extends StatelessWidget {
  AppSignUpAndLoginButton(
      {required this.text, required this.onPressed, Key? key});

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(18),
      ),
      margin: const EdgeInsets.only(top: 10, left: 22, right: 22),
      child: MaterialButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Cairo', color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
