import 'package:flutter/material.dart';
import 'package:freelance/presentation/build_profile_page/upload/uploadcv.dart';
import 'package:freelance/theme/color.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: black,
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Welcome to SkillVerse, where connections spark opportunities. Share, inspire, and grow your journey with us—one post at a time.",
                  style:GoogleFonts.playfairDisplay(fontSize: 20),
                ),
                TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const UploadCv()));
                }, child: const Text("Next"))
              ],
            ),
          ),
        ));
  }
}
