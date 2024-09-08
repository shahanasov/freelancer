import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/search_page/business_logic/bloc/search_bloc.dart';
import '../../../../theme/color.dart';

class SearchPageAppbar extends StatelessWidget {
  const SearchPageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 80),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            controller: searchController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              if (searchController.text.isNotEmpty) {
                context.read<SearchBloc>().add(SearchingEvent(query: value));
              }
            },
            style: TextStyle(color: black),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: white,
              hintText: 'Search',
              hintStyle: TextStyle(color: black),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ),
      ),
      toolbarOpacity: 1,
      title: const Text('SkillVerse'),
      actions: [
        IconButton(
          icon: const Icon(Icons.message),
          onPressed: () {},
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
