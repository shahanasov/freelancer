import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

class SkillAdding extends StatefulWidget {
  final String hintText;
  List<String> services;
  List<String> skills;
  final Function(List<String>) onUpdateSkills; // Callback for skills
  final Function(List<String>) onUpdateServices;

  SkillAdding({
    super.key,
    required this.hintText,
    required this.skills,
    required this.services,
    required this.onUpdateSkills,
    required this.onUpdateServices,
  });

  @override
  State<SkillAdding> createState() => _SkillAddingState();
}

class _SkillAddingState extends State<SkillAdding> {
  final TextEditingController _itemController = TextEditingController();

  late List<String> _skills;
  late List<String> _services;

  late String hint;
  @override
  void initState() {
    hint = widget.hintText;
    _skills = List<String>.from(widget.skills);
    _services = List<String>.from(widget.services);
    super.initState();
  }

  void _addItem() {
    String item = _itemController.text.trim();
    if (item.isNotEmpty) {
      setState(() {
        if (widget.hintText.contains('Skill')) {
          if (!_skills.contains(item)) _skills.add(item); // Add to skills list
          widget.onUpdateSkills(_skills);
        } else if (widget.hintText.contains('Service')) {
          if (!_services.contains(item)) {
            _services.add(item); // Add to services list
          }
            widget.onUpdateServices(_services);
        }
      });
    }
    _itemController.clear();
  }

  void _removeItem(String item) {
    setState(() {
      if (widget.hintText.contains('Skill')) {
        _skills.remove(item);
        widget.onUpdateSkills(_skills);
      } else if (widget.hintText.contains('Service')) {
        _services.remove(item);
        widget.onUpdateServices(_services);
      }
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
                onPressed: _addItem,
              ),
              filled: true,
              fillColor: white,
              hintText: hint,
              hintStyle: TextStyle(color: black),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          controller: _itemController,
          onSubmitted: (_) => _addItem(),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: (hint.contains('Skill') ? _skills : _services).map((item) {
            return Chip(
              label: Text(item),
              deleteIcon: const Icon(Icons.close),
              onDeleted: () => _removeItem(item),
            );
          }).toList(),
        ),
      ],
    );
  }
}
