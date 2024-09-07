import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/profile_page/widgets/pofilepageappbar.dart';
import 'package:freelance/presentation/pages/search_page/business_logic/bloc/search_bloc.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchingState &&
            state.users != null &&
            state.users!.isNotEmpty) {
          return ListView.builder(
              itemCount: state.users!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProfilePageAppBar(userDetailsModel: state.users![index],)));
                  },
                  child: ListTile(
                    title: Text(state.users![index].firstName),
                    subtitle: Text(state.users![index].jobTitle),
                  ),
                );
              });
        } else {
          return Container();
        }
      },
    );
  }
}
