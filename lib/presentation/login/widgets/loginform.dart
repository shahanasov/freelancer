import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/bottomnavigation/bottomnav.dart';
import 'package:freelance/presentation/login/widgets/bloc/toggle_bloc.dart';
import 'package:freelance/presentation/login/widgets/forgotpassword.dart';
import 'package:freelance/presentation/login/widgets/showpassword.dart';
import 'package:freelance/theme/color.dart';

import '../../pages/profile_page/businesslogin/bloc/profile_page_bloc.dart';

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
                    hintText: 'Enter email',
                    hintStyle: TextStyle(color: black),
                    border: const UnderlineInputBorder()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter email';
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
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    // login(context);
                    if (formkey.currentState!.validate()) {
                      context.read<ToggleBloc>().add(
                          LoginSubmitted(password: password, email: email));
                    }
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
                    InkWell(
                      onTap: () {
                        context.read<ToggleBloc>().add(GoogleSignIn());
                        // print("${FirebaseAuth.instance.currentUser?.uid}....login");
                      },
                      child: Material(
                          elevation: 4,
                          shape: const CircleBorder(),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: white,
                            child: Image.asset("assets/images/googlelogo.png"),
                          )),
                    ),
                    // Material(
                    //     elevation: 4,
                    //     shape: const CircleBorder(),
                    //     child: CircleAvatar(
                    //       radius: 30,
                    //       backgroundColor: white,
                    //       child: Image.asset("assets/images/metalogo.png"),
                    //     )),
                  ],
                ),
              )
            ],
          )),
    );
  }

  Future login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    String message = 'login failed';
    if (formkey.currentState!.validate()) {
      // context.read<ToggleBloc>().add(LoginSubmitted(password: password, email: email));
      //     print("${FirebaseAuth.instance.currentUser?.uid}....login");
      //Validate username and password
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNav()));
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
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(message),
                  content: Text(message),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ));
      }
        // ignore: use_build_context_synchronously
        context.read<ProfilePageBloc>().add(ProfileLoadEvent());
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const BottomNav()));
    }
  }
}
