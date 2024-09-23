import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

class WorksWidget extends StatelessWidget {
  const WorksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark =Theme.of(context).colorScheme.brightness==Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(top: 10,right: 5,left: 5),
      child: SizedBox(
        height: 310,
        child: ListView.builder(itemCount: 10,
          itemBuilder: (context ,index){
        return  Card(color: isDark ?white:black,
            child: ListTile(
            title: Text('work',style: TextStyle(color: isDark?black:white),),
            subtitle: const Text('details'),
          ),);
        }),
      ),
    );
  }
}