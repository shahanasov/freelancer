import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance/db/model/user_details.dart';
import 'package:freelance/db/services/chat_functions.dart';
import 'package:freelance/db/services/firebase_auth.dart';
import 'package:freelance/theme/color.dart';

class ChatPage extends StatelessWidget {
  final UserDetailsModel user;
  final String recieverEmail;
  final String recieverId;
  ChatPage(
      {super.key,
      required this.recieverEmail,
      required this.recieverId,
      required this.user});

  final TextEditingController messageController = TextEditingController();
  final ChatServices chatServices = ChatServices();
  final Authentication auth = Authentication();

  //send message
  void sendMessage() async {
// if there is something inside the textfield
    if (messageController.text.isNotEmpty) {
      // send the message
      await chatServices.sendMessage(recieverId, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.firstName),
      ),
      body: Column(
        children: [
          //display all messages
          Expanded(child: _buildMessageList()),
          buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
        stream: chatServices.getMessages(senderId, recieverId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading..');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user align to right is the current user,otherwise left
    bool isCurrentUser =
        data['senderId'] == FirebaseAuth.instance.currentUser!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                  color: isCurrentUser ? Colors.blueGrey : Colors.grey),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Text(data["message"]),
            ),
          ],
        ));
  }

  Widget buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left: 10, right: 10),
      child: Row(
        children: [
          // textfield should take up most of the space
          Expanded(
              child: TextFormField(
            autocorrect: true,
            // scrollPadding: EdgeInsets.all(10),
            style: TextStyle(color: black),
            decoration: InputDecoration(
                focusColor: white,
                filled: true,
                fillColor: white,
                hintText: 'message....',
                hintStyle: TextStyle(color: hintcolor),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
            controller: messageController,
            obscureText: false,
          )),
          const SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(color: white, shape: BoxShape.circle),
            child: IconButton(
                onPressed: () {
                  sendMessage();
                },
                icon: Icon(
                  Icons.arrow_upward,
                  color: black,
                )),
          )
        ],
      ),
    );
  }
}
