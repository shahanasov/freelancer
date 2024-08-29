
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context,index){
        return const ListTile(
          leading: Icon(Icons.message),
          title: Text('hshhshshhshhsh'),
        );
      }),
    );
  }
}