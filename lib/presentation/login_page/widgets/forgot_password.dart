import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<FormState> formkey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        title: const Text('Reset you password'),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter your email id we will send you mail to reset your password',
              style: TextStyle(color: white),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              style: TextStyle(color: black),
              controller: emailController,
              decoration: InputDecoration(
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: white)),
                  focusColor: white,
                  filled: true,
                  fillColor: white,
                  hintText: 'Email id',
                  hintStyle: TextStyle(color: black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                style: ButtonStyle(
                    minimumSize: const WidgetStatePropertyAll(Size(192, 50)),
                    backgroundColor: WidgetStatePropertyAll(white),
                    foregroundColor: WidgetStatePropertyAll(black)),
                onPressed: () {
                  passwordReset(emailController.text.trim(), context);
                },
                child: const Text('Submit')),
          ],
        ),
      ),
    );
  }

  Future passwordReset(email, context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              contentPadding: EdgeInsets.all(25),
              content:
                  Text('Password reset link has sent please check your email'),
            );
          });
    } on FirebaseException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(25),
              content: Text(e.message.toString()),
            );
          });
    }
  }
}
