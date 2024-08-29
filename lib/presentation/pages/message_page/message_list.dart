import 'package:flutter/material.dart';

class ListMessagePage extends StatelessWidget {
  const ListMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemCount: 10,
        itemBuilder: (context, index) {
        return const ListTile(
          leading: CircleAvatar(),
          title: Text('parson'),
          subtitle: Text('message'),
        );
      }),
    );
  }
}
