import 'package:flutter/material.dart';
import 'package:freelance/db/model/user_details.dart';
import 'package:freelance/presentation/pages/message_page/chat/personal_chat.dart';
import 'package:freelance/theme/color.dart';

class ResumePage extends StatelessWidget {
  final String userId;
  final UserDetailsModel userDetails;
  const ResumePage({super.key, required this.userDetails,required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(userDetails.firstName),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ChatPage(recieverEmail: userId, recieverId: userId, user: userDetails,)));
          }, icon: const Icon(Icons.message))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Informations',
              style: TextStyle(
                  color: white,
                  decoration: TextDecoration.underline,
                  fontSize: 25),
            ),
            Text(' ${userDetails.phone}', style: const TextStyle(fontSize: 18)),
            Text(' ${userDetails.dob}',
                style: const TextStyle(
                  fontSize: 18,
                )),
            Text(' ${userDetails.gender}',
                style: const TextStyle(fontSize: 18)),
            Text(
                ' ${userDetails.city}\n ${userDetails.state}\n${userDetails.country}',
                style: const TextStyle(
                  fontSize: 18,
                )),
                const SizedBox(height: 10,),
            Text(
              'About',
              style: TextStyle(
                  color: white,
                  decoration: TextDecoration.underline,
                  fontSize: 25),
            ),
            Text(userDetails.description,
                style: const TextStyle(
                  fontSize: 18,
                )),
                const SizedBox(height: 10,),
            const Text(
              'Skills',
              style:
                  TextStyle(decoration: TextDecoration.underline, fontSize: 20),
            ),
            Text(
              userDetails.skills.join('\n *'),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 10,),
            const Text(
              'Services',
              style:
                  TextStyle(decoration: TextDecoration.underline, fontSize: 25),
            ),
            Text(userDetails.services.join('\n *'))
          ],
        ),
      ),
    );
  }
}
