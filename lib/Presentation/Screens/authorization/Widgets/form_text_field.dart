import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const FormTextField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        decoration: InputDecoration(
          label: Text(
            label,
            style: const TextStyle(color: Colors.black),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey[300],
        ),
        autovalidateMode: AutovalidateMode.always,
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label incorrect';
          }
          return null;
        },
      ),
    );
  }
}
