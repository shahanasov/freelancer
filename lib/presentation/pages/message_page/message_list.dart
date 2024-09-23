import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance/db/services/chat_functions.dart';
import 'package:freelance/presentation/pages/message_page/chat/personal_chat.dart';

class ListMessageScreen extends StatelessWidget {
  const ListMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: StreamBuilder(
          stream: ChatServices().getChatRooms(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No chats available.'));
            }
            return ListView.builder(itemBuilder: (context, index) {
              var chatData =
                  snapshot.data![index].data(); // Use the data() method
              String otherUserId = chatData['senderId'] == userId
                  ? chatData['recieverId']
                  : chatData['senderId'];
              return Card(
                child: ListTile(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => ChatPage(
                    //         recieverEmail: chatData['recieverId'],
                    //         recieverId: chatData['recieverId'],
                    //         user: 
                    //         )));
                  },
                  title: Text(otherUserId),
                ),
              );
            });
          }),
    );
  }
}
