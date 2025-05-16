import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool isObsecure;
  final bool readOnly;
  final VoidCallback? onTap;
  const CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObsecure = false,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
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
