import 'package:flutter/material.dart';

class SuggestionsWidget extends StatelessWidget {
  const SuggestionsWidget({super.key});

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
