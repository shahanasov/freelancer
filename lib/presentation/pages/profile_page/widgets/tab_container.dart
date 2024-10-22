import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

class TabContainer extends StatelessWidget {
  final String tabtext;
  const TabContainer({super.key, required this.tabtext});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        color: black,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Center(
          child: Text(
        tabtext,
        style: TextStyle(fontSize: 18, color: white),
      )),
    );
  }
}
