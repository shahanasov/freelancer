import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/login/widgets/bloc/toggle_bloc.dart';
import 'package:freelance/theme/color.dart';
import '../../Buildprofilepage/upload/uploadcv.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                style: TextStyle(color: black),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter email',
                    hintStyle: TextStyle(color: black),
                    border: const UnderlineInputBorder()),
              ),
              TextFormField(
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: TextStyle(color: black),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter password';
                  }
                  return null;
                },
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: black),
                    border: const UnderlineInputBorder()),
              ),
              TextFormField(
                obscureText: true,
                style: TextStyle(color: black),
                controller: confirmPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty ||
                      passwordController.text.trim() !=
                          confirmPassword.text.trim()) {
                    return 'password incorrect';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(color: black),
                    border: const UnderlineInputBorder()),
              ),
              const SizedBox(
                height: 35,
              ),
              TextButton(
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(192, 50)),
                      // maximumSize: MaterialStateProperty.all(const Size(500, 50)),
                      backgroundColor: MaterialStateProperty.all(black),
                      foregroundColor: MaterialStatePropertyAll(white)),
                  onPressed: () async {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    final confirm = confirmPassword.text.trim();
                    if (password == confirm) {
                      if (formkey.currentState!.validate()) {
                        context.read<ToggleBloc>().add(
                            SignInSubmitted(password: password, email: email));

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const UploadCv()));
                      }
                    }
                  },
                  child: const Text('Sign Up')),
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
                      onTap: () async {
                        context.read<ToggleBloc>().add(GoogleSignIn());
                        // FirebaseAuth.instance
                        //     .authStateChanges()
                        //     .listen((User? user) {
                        //   if (user != null) {
                        //     Navigator.of(context).pushReplacement(
                        //         MaterialPageRoute(
                        //             builder: (context) => const UploadCv()));
                        //   }
                        // });
                        //  await FirebaseAuth.instance.currentUser?.uid;
                      },
                      child: Material(
                          elevation: 4,
                          shape: const CircleBorder(),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: white,
                            child: Image.asset(
                              "assets/images/googlelogo.png",
                              fit: BoxFit.fill,
                            ),
                          )),
                    ),
                    // Material(
                    //     elevation: 4,
                    //     shape: const CircleBorder(),
                    //     child: CircleAvatar(
                    //       radius: 30,
                    //       backgroundColor: white,
                    //       child: Image.asset(
                    //         "assets/images/metalogo.png",
                    //         fit: BoxFit.fill,
                    //       ),
                    //     )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
