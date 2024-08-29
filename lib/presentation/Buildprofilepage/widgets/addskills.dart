import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

class SkillAdding extends StatefulWidget {
 final String hintText;
  List<String> skills;
  List<String> services;
    SkillAdding({super.key, required this.hintText, required this.services,required this.skills});

  @override
  State<SkillAdding> createState() => _SkillAddingState();
}

class _SkillAddingState extends State<SkillAdding> {
  final TextEditingController _skillController = TextEditingController();
  
  List<String> _skills = [];
   List<String> _services= [];
  
  late String hint;
  @override
  void initState() {
    hint=widget.hintText;
  _skills=widget.skills;
  _services=widget.services;
    super.initState();
  }

  void _addSkill() {
    String skill = _skillController.text.trim();
    if (skill.isNotEmpty && !_skills.contains(skill)) {
      setState(() {
          _skills.add(skill);  
      });
    }
    _skillController.clear();
  }

  void _removeSkill(String skill) {
    setState(() {
      _skills.remove(skill);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          style: TextStyle(color: black),
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.add),
                onPressed: _addSkill,
              ),
              filled: true,
              fillColor: white,
              hintText:  hint,
              hintStyle: TextStyle(color: black),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15))),
          controller: _skillController,
          onSubmitted: (_) => _addSkill(),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: _skills.map((skill) {
            return Chip(
              label: Text(skill),
              deleteIcon: const Icon(Icons.close),
              onDeleted: () => _removeSkill(skill),
            );
          }).toList(),
        ),
      ],
    );
  }
}
