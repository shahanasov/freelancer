import 'package:flutter/material.dart';
import 'package:freelance/presentation/Buildprofilepage/makingres.dart';
import 'package:freelance/theme/color.dart';

class UploadCv extends StatelessWidget {
  const UploadCv({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: black,
      appBar: AppBar(automaticallyImplyLeading: false, backgroundColor: Colors.transparent,),
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              Text("Please upload your resume. We will use to find the right opportunities for you.",style: TextStyle(color: white,fontSize: 18,fontWeight: FontWeight.w300)),
              Image.asset('assets/images/download.png'),
              TextButton(
                style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(192, 50)),
                      backgroundColor: MaterialStateProperty.all(white),
                      foregroundColor: MaterialStatePropertyAll(black)),
                onPressed: (){

              }, child: const Text('Upload Your Resume')),
              const SizedBox(height: 20,),
               Text('or',style: TextStyle(color: white),),
              const SizedBox(height: 20,),
               TextButton(
                style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(192, 50)),
                      backgroundColor: MaterialStateProperty.all(white),
                      foregroundColor: MaterialStatePropertyAll(black)),
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ResposiveBuildProfile()));
              }, child: const Text('Build a Resume')),
            ],
          ),
        ),
      ),
    );
  }
}