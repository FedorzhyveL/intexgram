import 'package:flutter/material.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  final String? Function(String?)? validation;

  const FormTextField({
    super.key,
    required this.label,
    required this.controller,
    this.maxLines = 1,
    required this.validation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        cursorColor: Palette.textColor,
        controller: controller,
        minLines: 1,
        maxLines: maxLines,
        keyboardType:
            maxLines == 1 ? TextInputType.text : TextInputType.multiline,
        validator: validation,
        decoration: InputDecoration(
          hintText: controller.text,
          label: Text(
            label,
            style: TextStyles.text,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Palette.borderSideColor,
              width: 2,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Palette.borderSideColor,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.grey[300],
        ),
      ),
    );
  }
}
