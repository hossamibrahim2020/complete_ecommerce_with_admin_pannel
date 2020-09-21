import 'package:flutter/material.dart';

class CustomMessageSenderField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final Icon icon;
  final Color textFieldColor;
  final TextInputType textInputType;
  const CustomMessageSenderField(
      {this.hint,
      this.controller,
      this.icon,
      this.textFieldColor,
      this.textInputType});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          filled: true,
          fillColor: textFieldColor,
        ),
        controller: controller,
        keyboardType: textInputType,
        validator: (String val) {
          return val.isEmpty ? '$hint can\'t be empty' : null;
        },
      ),
    );
  }
}
