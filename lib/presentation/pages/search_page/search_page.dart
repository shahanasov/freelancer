import 'package:flutter/material.dart';
import 'package:freelance/presentation/pages/search_page/widgets/search_page_appbar.dart';

import 'widgets/search_page_body.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 150), child: SearchPageAppbar()),
      body: SearchResultWidget(),
    );
  }
}
