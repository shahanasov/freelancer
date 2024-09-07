import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

import 'buildprofile/buildprofile.dart';

class ResposiveBuildProfile extends StatelessWidget {
  const ResposiveBuildProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder:(context,constaints){
      if(constaints.maxWidth<600){
        return  BuildProfile();
      }
      return Container(color: black,
        child:  Padding(
          padding: const EdgeInsets.fromLTRB(400, 0, 400, 0),
          child: BuildProfile(),
        ),
      );
    }
     );
  }
}