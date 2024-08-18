import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance/presentation/bottomnavigation/bottomnav.dart';
import 'package:freelance/presentation/login/widgets/bloc/toggle_bloc.dart';
import 'package:freelance/presentation/login/widgets/forgotpassword.dart';
import 'package:freelance/presentation/login/widgets/showpassword.dart';
import 'package:freelance/theme/color.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
          key: formkey,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                style: TextStyle(color: black),
                controller: emailController,
                decoration: InputDecoration(
                    hintText: 'Enter email or username',
                    hintStyle: TextStyle(color: black),
                    border: const UnderlineInputBorder()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter email or username';
                  }
                  return null;
                },
              ),
              ShowPassword(passwordController: passwordController),
              const SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage()));
                      },
                      child: const Text('Forgot Password?'))),
              const SizedBox(
                height: 55,
              ),
              TextButton(
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(192, 50)),
                      backgroundColor: MaterialStateProperty.all(black),
                      foregroundColor: MaterialStatePropertyAll(white)),
                  onPressed: () async {
                    login(context);
                  },
                  child: const Text('Login')),
              const SizedBox(
                height: 35,
              ),
              const Text('OR'),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Material(
                        elevation: 4,
                        shape: const CircleBorder(),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: white,
                          child: Image.asset(
                            "assets/images/facelogo.png",
                            fit: BoxFit.fill,
                          ),
                        )),
                    Material(
                        elevation: 4,
                        shape: const CircleBorder(),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: white,
                          child: Image.asset("assets/images/googlelogo.png"),
                        )),
                    Material(
                        elevation: 4,
                        shape: const CircleBorder(),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: white,
                          child: Image.asset("assets/images/metalogo.png"),
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }

  Future login(context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // // Check if user is already signed in
    // User? user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   Navigator.pushReplacementNamed(context, '/home');
    //   return;
    // }

    String message = 'login failed';
    //Validate username and password
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const BottomNav()));
    } on FirebaseAuthException catch (e) {
      // print('$e ..........is the error');
      if (e.code == 'invalid-credential]') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else if (e.code == 'mail address is badly formatted.') {
        message = 'Incorrect mail id.';
      } else {
        message = 'Please check your email and password .';
      }
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Login failed'),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ));
    if (formkey.currentState!.validate()) {
      context
          .read<ToggleBloc>()
          .add(LoginSubmitted(password: password, email: email));

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const BottomNav()));
    }
  }
}
