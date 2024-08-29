import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

class GenderDropdown extends StatefulWidget {
  final TextEditingController genderController;
  const GenderDropdown({super.key, required this.genderController});

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
late TextEditingController genderController;
@override
  void initState() {
    genderController =widget.genderController;
    super.initState();
  }
  String? dropdownitem;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
        style: TextStyle(color: black),
        decoration: InputDecoration(
            filled: true,
            fillColor: white,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        hint: Text(
          'Gender',
          style: TextStyle(color: black),
        ),
        
        dropdownColor: white,
        icon: const Icon(Icons.arrow_drop_down_rounded),
        value: dropdownitem,
        items: const [
          DropdownMenuItem(value: 'Female', child: Text('Female')),
          DropdownMenuItem(value: 'Male', child: Text('Male')),
          DropdownMenuItem(value: 'Others', child: Text('Others'))
        ],
        onChanged: (String? newValue) {
          setState(() {
            dropdownitem = newValue;
            genderController.text=newValue!;
          });
        });
  }
}
