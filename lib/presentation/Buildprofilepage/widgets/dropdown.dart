import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

class GenderDropdown extends StatefulWidget {
  const GenderDropdown({super.key});

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
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
          DropdownMenuItem(value: 'one', child: Text('Female')),
          DropdownMenuItem(value: 'two', child: Text('Male')),
          DropdownMenuItem(value: 'three', child: Text('Others'))
        ],
        onChanged: (String? newValue) {
          setState(() {
            dropdownitem = newValue;
          });
        });
  }
}
