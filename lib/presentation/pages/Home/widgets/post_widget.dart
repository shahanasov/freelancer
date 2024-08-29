import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

List<Widget> postWidget = [
  const SizedBox(
    height: 10,
  ),
  const Row(
    children: [
      CircleAvatar(
        radius: 20,
      ),
      SizedBox(
        width: 25,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('name'), Text('Position')],
      ),
    ],
  ),
  const Padding(
    padding: EdgeInsets.all(5.0),
    child: Text(
        'Despite the fact that they can save characters, acronyms and abbreviations frequently make code harder to comprehend, especially for new engineers entering the project.'),
  ),
  const SizedBox(
    height: 10,
  ),
  Container(
    height: 200,
    width: double.infinity,
    color: black,
  ),
  const SizedBox(
    height: 10,
  ),
  const Row(
    children: [
      Icon(Icons.favorite),
      SizedBox(
        width: 10,
      ),
      Icon(Icons.share),
      SizedBox(
        width: 10,
      ),
      Icon(Icons.add) // request that survice
    ],
  )
];
