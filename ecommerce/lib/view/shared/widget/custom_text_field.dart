import '../theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool onbscure;
  const CustomTextField(
    this.label,
    this.icon,
    this.controller,
    this.keyboardType,
    this.onbscure,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          filled: true,
          fillColor: textFieldColor,
        ),
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        obscureText: onbscure,
      ),
    );
  }
}
