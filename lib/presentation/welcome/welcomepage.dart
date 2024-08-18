import 'package:flutter/material.dart';
import 'package:freelance/presentation/Buildprofilepage/makingres.dart';
import 'package:freelance/presentation/Buildprofilepage/upload/uploadcv.dart';
import 'package:freelance/theme/color.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(automaticallyImplyLeading: false,backgroundColor: Colors.transparent,),
      // inbuildgradle 10th line app gradle buildgradle classpath "com.google.gms.google-services4.4.2"
      backgroundColor: black,
      body: Center(
        child: Column(
          children: [
             Text('Welcome',style: TextStyle(color: white,fontSize: 50),),
            const SizedBox(height: 10,),
             Text('Username',style: TextStyle(color: white,fontSize: 30),),
             Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text("oufhdapiushdfiuabvaleluwifiugfd;sadjbvlabvvlagleuprqwyepfahfjbdfbhfbdsasdfsbhhbdfhdfasdsllofwhwpieiiuwhfjsbs",style: TextStyle(color: white)),
            ),
            TextButton(
              style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(192, 50)),
                    backgroundColor: MaterialStateProperty.all(white),
                    foregroundColor: MaterialStatePropertyAll(black)),
              onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const UploadCv()));
            }, child: const Text('Upload cv')),
             const SizedBox(height: 10,),
             Text('or',style: TextStyle(color: white)),
             const SizedBox(height: 10,),
            TextButton(
              style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(192, 50)),
                    backgroundColor: MaterialStateProperty.all(white),
                    foregroundColor: MaterialStatePropertyAll(black)),
              onPressed: (){
         Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ResposiveBuildProfile()));
            }, child: const Text('Build a cv')),
          ],
        ),
      ),
    );
  }
}