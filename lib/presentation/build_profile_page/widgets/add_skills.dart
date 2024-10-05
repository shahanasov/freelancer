import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

class SkillAdding extends StatelessWidget {
  final String hintText;
  final ValueNotifier<List<String>> skillsNotifier;
  final ValueNotifier<List<String>> servicesNotifier;
  final TextEditingController _itemController = TextEditingController();

  SkillAdding({
    super.key,
    required this.hintText,
    required this.skillsNotifier,
    required this.servicesNotifier,
  });

  void _addItem() {
    String item = _itemController.text.trim();
    if (item.isNotEmpty) {
      if (hintText.contains('Skill')) {
        if (!skillsNotifier.value.contains(item)) {
          skillsNotifier.value = [...skillsNotifier.value, item];
        }
      } else if (hintText.contains('Service')) {
        if (!servicesNotifier.value.contains(item)) {
          servicesNotifier.value = [...servicesNotifier.value, item];
        }
      }
    }
    _itemController.clear();
  }

  void _removeItem(String item) {
    if (hintText.contains('Skill')) {
      skillsNotifier.value = skillsNotifier.value.where((i) => i != item).toList();
    } else if (hintText.contains('Service')) {
      servicesNotifier.value = servicesNotifier.value.where((i) => i != item).toList();
    }
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
              hintText: hintText,
              hintStyle: TextStyle(color: hintcolor),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          controller: _itemController,
          onSubmitted: (_) => _addItem(),
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<List<String>>(
          valueListenable: hintText.contains('Skill')
              ? skillsNotifier
              : servicesNotifier,
          builder: (context, items, _) {
            return Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: items.map((item) {
                return Chip(
                  label: Text(item),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () => _removeItem(item),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
