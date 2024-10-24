import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

Widget postEmpty(BuildContext context) {
  bool isDark = Theme.of(context).colorScheme.brightness == Brightness.dark;
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [ Image.asset(
          "assets/images/box.png",
          color: isDark ? white : black,
          height: 150,
          width: 150,
          alignment: Alignment.center,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'No Posts',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
        ),
        
       
      ],
    ),
  );
}
