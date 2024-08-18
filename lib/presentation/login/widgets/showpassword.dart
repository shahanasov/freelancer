import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

class ShowPassword extends StatefulWidget {
  TextEditingController passwordController;
  ShowPassword({super.key, required this.passwordController});

  @override
  State<ShowPassword> createState() => _ShowPasswordState();
}

class _ShowPasswordState extends State<ShowPassword> {
  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    passwordController = widget.passwordController;
  }

  bool showpassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      style: TextStyle(color: black),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter password';
        }
        return null;
      },
      obscureText: showpassword,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showpassword = !showpassword;
              });
            },
            icon: !showpassword
                ? const Icon(Icons.visibility_off)
                : const Icon(
                    Icons.visibility,
                    size: Checkbox.width,
                  ),
          ),
          hintText: 'Password',
          hintStyle: TextStyle(color: black),
          border: const UnderlineInputBorder()),
    );
  }
}
