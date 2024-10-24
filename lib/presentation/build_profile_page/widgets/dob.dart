import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

// ignore: must_be_immutable
class DOBWidget extends StatefulWidget {
   TextEditingController dob;
   DOBWidget({super.key,required this.dob});

  @override
  State<DOBWidget> createState() => _DOBWidgetState();
}

class _DOBWidgetState extends State<DOBWidget> {
  late TextEditingController dob;
  @override
  void initState() {
    dob=widget.dob;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return TextField(
      style: TextStyle(color: black),
      controller: dob,
      keyboardType: TextInputType.none,
      decoration: InputDecoration(
          filled: true,
          fillColor: white,
          hintText: 'Date Of Birth',
          hintStyle: TextStyle(color: hintcolor),
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
