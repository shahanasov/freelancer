import 'package:flutter/material.dart';
import 'package:freelance/presentation/Buildprofile/upload/uploadcv.dart';
import 'package:freelance/theme/color.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
          child: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter email or username',
                hintStyle: TextStyle(color: black),
                border: const UnderlineInputBorder()),
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.remove_red_eye_sharp,
                  size: Checkbox.width,
                ),
                hintText: 'Password',
                hintStyle: TextStyle(color: black),
                border: const UnderlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          const Align(
              alignment: Alignment.bottomRight,
              child: Text('Forgot Password?')),
          const SizedBox(
            height: 55,
          ),
          TextButton(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(192, 50)),
                  backgroundColor: MaterialStateProperty.all(black),
                  foregroundColor: MaterialStatePropertyAll(white)),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const UploadCv()));
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
}
