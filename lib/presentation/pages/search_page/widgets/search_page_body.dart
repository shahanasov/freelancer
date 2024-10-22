import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/business_logic/bloc/post_related_bloc.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/others_profile_page.dart';
import 'package:freelance/presentation/pages/search_page/business_logic/bloc/search_bloc.dart';
import 'package:freelance/presentation/widgets/suggestions_widget/sugessions_widget.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        log(state.runtimeType.toString());
        if (state is SearchingState) {
          final postsWithUser = state.postsWithUser;
          log((state.user?.length ?? 0).toString());
          if (postsWithUser != null &&
              postsWithUser.isNotEmpty &&
              state.user != null) {
            return ListView.builder(
              itemCount: state.user!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      context.read<PostRelatedBloc>().add(AllPostsFetchEvent(
                          userId:
                              state.postsWithUser![index].postModel.userId!));
                      if (userId !=
                          state.postsWithUser![index].postModel.userId!) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OthersProfilePage(
                                  userModel: postsWithUser[index],
                                )));
                      }
                    },
                    title: Text(state.user![index].firstName),
                    subtitle: Text(state.user![index].jobTitle),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        } else if (state is SearchLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchErrorState) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is SearchEmptyState) {
          return const Center(
            child: Text('No users available'),
          );
        } else {
          //  here write codes for starting an ui
          return const SuggestionsWidget();
        }
      },
    );
  }
}
