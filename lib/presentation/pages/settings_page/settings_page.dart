import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance/db/services/firebase_database_usersaving_functions.dart';
import 'package:freelance/presentation/login_page/login_page.dart';
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
            Card(
              child: ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title:
                              const Text('Do you want to delete your account'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel')),
                            TextButton(
                                onPressed: () async {
                                  UserDatabaseFunctions().deleteUser();

                                  // ProgressIndicatorTheme(data: , child: child)
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                    );
                                  });
                                },
                                child: const Text('Delete account'))
                          ],
                        );
                      });
                },
                title: Text('Delete Profile'),
              ),
            ),
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
