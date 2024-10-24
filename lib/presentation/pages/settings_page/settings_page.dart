import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance/presentation/other_settings/appinfo_page.dart';
import 'package:freelance/presentation/other_settings/privacy_policy_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text(
                    'Email Address : ${FirebaseAuth.instance.currentUser?.email}'),
              ),
            ),
            // const Card(

            //   child: ListTile(
            //     title: Text('Delete Profile'),
            //   ),
            // ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AppInfoPage()));
                },
                title: const Text('App info'),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PrivacyPolicy()));
                },
                title: const Text('Privacy Policy'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
