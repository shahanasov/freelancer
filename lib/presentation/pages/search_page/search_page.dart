import 'package:flutter/material.dart';

import '../../../theme/color.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarOpacity: 1,
        title: const Text('SkillVerse'),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {},
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              child: Column(
                children: [
                  TextFormField(
                      style: TextStyle(color: black),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: white,
                          hintText: 'Search',
                          hintStyle: TextStyle(color: black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)))),
                ],
              ),
            ),
            const Text('Try searching for'),
            const Text('Event manager'),
            const Text('Photographer')
          ],
        ),
      ),
    );
  }
}
