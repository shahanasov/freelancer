import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/message_page/message_list.dart';
import 'package:freelance/presentation/pages/profile_page/widgets/pofilepageappbar.dart';
import 'package:freelance/theme/color.dart';

import 'bloc/home_page_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomePageBloc>().add(UsersPostFetchEvent());
    return Scaffold(
        appBar: AppBar(
          toolbarOpacity: 1,
          title: const Text('SkillVerse'),
          actions: [
            IconButton(
              icon: const Icon(Icons.message),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ListMessagePage()));
              },
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            // print(state.toString());
            if (state is HomePageLoaded) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      return Column(children: [
                        const SizedBox(
                          height: 30,
                        ),
                        ListTile(
                          onTap: () {
                             Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfilePageAppBar(userDetailsModel: state.posts[index].userDetailsModel,)));
                          },
                          leading: const CircleAvatar(
                            radius: 20,
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state
                                  .posts[index].userDetailsModel.firstName),
                              Text(state.posts[index].userDetailsModel.jobTitle)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                              state.posts[index].postModel.postDescription ??
                                  ''),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        state.posts[index].postModel.imagepathofPost != null
                            ? Image.network(
                                state.posts[index].postModel.imagepathofPost!,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          children: [
                            Icon(Icons.favorite),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.share),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.add) // request that survice
                          ],
                        ),
                      ]);
                    }),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container();
                      // Column(children: postWidget);
                    }),
              );
            }
          },
        ));
  }
}
