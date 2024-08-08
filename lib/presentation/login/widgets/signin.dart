import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
          child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter email or username',
                hintStyle: TextStyle(color: black),
                border: const UnderlineInputBorder()),
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: black),
                border: const UnderlineInputBorder()),
          ),
          TextFormField(
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
                  minimumSize: MaterialStateProperty.all(const Size(192, 50)),
                  // maximumSize: MaterialStateProperty.all(const Size(500, 50)),
                  backgroundColor: MaterialStateProperty.all(black),
                  foregroundColor: MaterialStatePropertyAll(white)),
              onPressed: () {},
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
                      child: Image.asset(
                        "assets/images/googlelogo.png",
                        fit: BoxFit.fill,
                      ),
                    )),
                Material(
                    elevation: 4,
                    shape: const CircleBorder(),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: white,
                      child: Image.asset(
                        "assets/images/metalogo.png",
                        fit: BoxFit.fill,
                      ),
                    )),
              ],
            ),
          )
        ],
      )),
    );
  }
}
