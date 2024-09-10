import 'package:flutter/material.dart';
class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final int maxLines;
  const CustomTextForm({super.key, required this.controller, required this.labelText, this.maxLines=1,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
                labelText: labelText,
                prefixIcon: Icon(Icons.edit),
                
                border: OutlineInputBorder()
              ),
    );
  }
}