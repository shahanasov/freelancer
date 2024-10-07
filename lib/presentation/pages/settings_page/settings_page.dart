import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
            const Card(
              child: ListTile(
                title: Text('Delete Profile'),
              ),
            ),
            const Card(
              child: ListTile(
                title: Text('App info'),
              ),
            ),
            const Card(
              child: ListTile(
                title: Text('Privacy Policy'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
