import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObsecure;
  const CustomField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isObsecure = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) {
        if (val!.trim().isEmpty) return "$hintText is missing";
        return null;
      },
      obscureText: isObsecure,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
