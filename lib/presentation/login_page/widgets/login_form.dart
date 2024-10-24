import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/bottom_navigation_main/bottom_nav.dart';
import 'package:freelance/presentation/login_page/widgets/bloc/toggle_bloc.dart';
import 'package:freelance/presentation/login_page/widgets/forgot_password.dart';
import 'package:freelance/presentation/login_page/widgets/show_password.dart';
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
                      minimumSize: const WidgetStatePropertyAll(Size(192, 50)),
                      backgroundColor: WidgetStatePropertyAll(black),
                      foregroundColor: WidgetStatePropertyAll(white)),
                  onPressed: () {
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
                    // Material(
                    //     elevation: 4,
                    //     shape: const CircleBorder(),
                    //     child: CircleAvatar(
                    //       radius: 30,
                    //       backgroundColor: white,
                    //       child: Image.asset(
                    //         "assets/images/facelogo.png",
                    //         fit: BoxFit.fill,
                    //       ),
                    //     )),
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
     final navigatorContext = Navigator.of(context);
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (formkey.currentState!.validate()) {
      try {
        // final credential =
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        navigatorContext
            .push(MaterialPageRoute(builder: (context) => const BottomNav()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('No user found for that email'),
                    content: const Text('No user found for that email'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK'),
                      ),
                    ],
                  ));
        } else if (e.code == 'wrong-password') {
          showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Wrong password provided for that user.'),
                    content:
                        const Text('Wrong password provided for that user.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK'),
                      ),
                    ],
                  ));
        }
      }
    }
  }
}
