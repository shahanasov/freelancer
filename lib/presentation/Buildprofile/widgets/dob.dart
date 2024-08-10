import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

class DOBWidget extends StatefulWidget {
  const DOBWidget({super.key});

  @override
  State<DOBWidget> createState() => _DOBWidgetState();
}

class _DOBWidgetState extends State<DOBWidget> {
  TextEditingController dob=TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return TextField(
      controller: dob,
      keyboardType: TextInputType.none,
      decoration: InputDecoration(
          filled: true,
          fillColor: white,
          hintText: 'Date Of Birth',
          hintStyle: TextStyle(color: black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      onTap: () {
        selectDate(context);
      },
    );
  }

  Future<void> selectDate(context) async {
  DateTime? picked=  await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if(picked!=null){
      setState(() {
        dob.text= picked.toString().split(" ")[0];
      });
    }
  }
}
