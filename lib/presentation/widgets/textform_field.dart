import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String hintText,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (value!.isEmpty) {
        return ' Name  is required';
      }
      return null;
    },
    style: TextStyle(color: black),
    controller: controller,
    decoration: InputDecoration(
        // focusedBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: white)),
        focusColor: white,
        filled: true,
        fillColor: white,
        hintText: 'First Name', //reached
        hintStyle: TextStyle(color: hintcolor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
  );
}
