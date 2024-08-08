import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

class SkillAdding extends StatefulWidget {
  const SkillAdding({super.key});

  @override
  State<SkillAdding> createState() => _SkillAddingState();
}

class _SkillAddingState extends State<SkillAdding> {
  final TextEditingController _skillController = TextEditingController();
  final List<String> _skills = [];

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
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.add),
                onPressed: _addSkill,
              ),
              filled: true,
              fillColor: white,
              hintText: 'Enter a skill',
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
