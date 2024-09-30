
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: false,
        title: const Text('SkillVerse'),),
      body: ListView.builder(itemCount: 5,
        itemBuilder: (context,index){
        return const ListTile(
          leading: Icon(Icons.message),
          title: Text('Notifications'),
        );
      }),
    );
  }
}