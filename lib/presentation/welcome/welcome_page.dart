import 'package:flutter/material.dart';
import 'package:freelance/presentation/build_profile_page/makingres.dart';
import 'package:freelance/presentation/build_profile_page/upload/uploadcv.dart';
import 'package:freelance/theme/color.dart';

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
      body: Center(
        child: Column(
          children: [
            Text(
              'Welcome',
              style: TextStyle(color: white, fontSize: 50),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Username',
              style: TextStyle(color: white, fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text(
                  "oufhdapiushdfiuabvaleluwifiugfd;sadjbvlabvvlagleuprqwyepfahfjbdfbhfbdsasdfsbhhbdfhdfasdsllofwhwpieiiuwhfjsbs",
                  style: TextStyle(color: white)),
            ),
            TextButton(
                style: ButtonStyle(
                    minimumSize: const WidgetStatePropertyAll(Size(192, 50)),
                    backgroundColor: WidgetStatePropertyAll(white),
                    foregroundColor: WidgetStatePropertyAll(black)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UploadCv()));
                },
                child: const Text('Upload cv')),
            const SizedBox(
              height: 10,
            ),
            Text('or', style: TextStyle(color: white)),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                style: ButtonStyle(
                    minimumSize: const WidgetStatePropertyAll(Size(192, 50)),
                    backgroundColor: WidgetStatePropertyAll(white),
                    foregroundColor: WidgetStatePropertyAll(black)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ResposiveBuildProfile()));
                },
                child: const Text('Build a cv')),
          ],
        ),
      ),
    );
  }
}
