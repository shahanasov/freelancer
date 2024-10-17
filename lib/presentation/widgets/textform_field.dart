import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String hintText,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: validator,
    style: TextStyle(color: black),
    controller: controller,
    keyboardType: TextInputType.name,
    textCapitalization: TextCapitalization.words,
    decoration: InputDecoration(
        // focusedBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: white)),
        focusColor: white,
        filled: true,
        fillColor: white,
        hintText: hintText, //reached
        hintStyle: TextStyle(color: hintcolor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
  );
}

Widget buildDescriptionFeild({
  required TextEditingController controller,
}) {
  return TextFormField(
    minLines: 1,
    maxLines: 5,
    style: TextStyle(color: black),
    controller: controller,
    decoration: InputDecoration(
        focusColor: white,
        filled: true,
        fillColor: white,
        hintText: 'Write a short description about you', //reached
        hintStyle: TextStyle(color: hintcolor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
  );
}

Widget buildPhoneNumberField({
  required TextEditingController controller,
}) {
  return IntlPhoneField(
    style: TextStyle(color: black),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (value == null) {
        return 'Phone number is required';
      }
      return null;
    },
    controller: controller,
    initialCountryCode: 'IN',
    // languageCode: 'IN',
    keyboardType: TextInputType.phone,
    decoration: InputDecoration(
        filled: true,
        fillColor: white,
        hintText: 'Phone Number', //reached
        hintStyle: TextStyle(color: hintcolor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
  );
}
