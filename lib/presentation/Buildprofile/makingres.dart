import 'package:flutter/material.dart';
import 'package:freelance/presentation/Buildprofile/buildprofile.dart';
import 'package:freelance/theme/color.dart';

class ResposiveBuildProfile extends StatelessWidget {
  const ResposiveBuildProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder:(context,constaints){
      if(constaints.maxWidth<600){
        return const BuildProfile();
      }
      return Container(color: black,
        child: const Padding(
          padding: EdgeInsets.fromLTRB(400, 0, 400, 0),
          child: BuildProfile(),
        ),
      );
    }
     );
  }
}