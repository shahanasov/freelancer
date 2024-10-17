import 'package:flutter/material.dart';
import 'package:freelance/db/model/user_and_post_model.dart';
import 'package:freelance/db/model/user_details.dart';

class SuggestionsWidget extends StatelessWidget {
  final List<UserDetailsModel> user;
  final List<PostWithUserDetailsModel> posts;
  const SuggestionsWidget({super.key, required this.user, required this.posts});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Name'),
                      Text('Job')
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
