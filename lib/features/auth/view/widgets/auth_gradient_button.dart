import 'package:client_side/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String titleText;
  final VoidCallback onPressed;
  const AuthGradientButton(
      {super.key, required this.titleText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          gradient: const LinearGradient(
            colors: [
              Pallete.gradient1,
              Pallete.gradient2,
            ],
          )),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Pallete.transparentColor,
          shadowColor: Pallete.transparentColor,
          fixedSize: const Size(395, 55),
        ),
        onPressed: onPressed,
        child: Text(
          titleText,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
