import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/services/post_functions.dart';
import 'package:freelance/presentation/pages/home/widgets/like_button.dart';
import 'package:freelance/presentation/pages/message_page/message_list.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/business_logic/bloc/post_related_bloc.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/others_profile_page.dart';
import 'package:freelance/presentation/pages/profile_page/businesslogin/bloc/profile_page_bloc.dart';
import 'package:freelance/theme/color.dart';

import 'bloc/home_page_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    context.read<ProfilePageBloc>().add(ProfileLoadEvent());
    context.read<HomePageBloc>().add(UsersPostFetchEvent());

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarOpacity: 1,
          title: const Text('SkillVerse'),
          actions: [
            IconButton(
              icon: const Icon(Icons.message),
              onPressed: () {
                
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChatListPage()));
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
                child: ListView.separated(
                  itemCount: state.userandPost.length,
                  itemBuilder: (context, index) {
                    //  final likeNotif ValueNotifier(state.posts[index].postModel.likes.length);
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            onTap: () {
                              context.read<PostRelatedBloc>().add(AllPostsFetchEvent(userId: state.userandPost[index].postModel.userId!));
                              if (userId !=
                                  state.userandPost[index].postModel.userId) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => OthersProfilePage(
                                          userModel: state.userandPost[index],
                                        )));
                              }
                            },
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CircleAvatar(
                                radius: 20,
                                child: Image.asset(
                                  "assets/images/profilenew.jpg",
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            title: Text(state
                                .userandPost[index].userDetailsModel.firstName),
                            subtitle: Text(state
                                .userandPost[index].userDetailsModel.jobTitle),
                          ),
                          state.userandPost[index].postModel.imagepathofPost ==
                                  null
                              ? ListTile(
                                  title: Text(state.userandPost[index].postModel
                                          .postDescription ??
                                      ''),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.userandPost[index].postModel
                                            .postDescription ??
                                        ''),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Image.network(
                                        state.userandPost[index].postModel
                                            .imagepathofPost!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            leading: LikeButton(
                              isLiked: state.userandPost[index].postModel.likes
                                  .contains(userId),
                              postModel: state.userandPost[index].postModel,
                            ),
                            title: IconButton(
                              icon: const Icon(Icons.share),
                              onPressed: () {
                                PostFunctions().sharePost(
                                    state.userandPost[index].postModel.postId!);
                              },
                            ),
                            trailing: GestureDetector(
                                onTap: () {
                                  // NotificationFunctions().initNotifications();
                                  // PostFunctions().shareToChat(state
                                  // .posts[index].postModel.imagepathofPost!);
                                },
                                child: const Icon(Icons.question_answer)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                              "${state.userandPost[index].postModel.likes.length} Likes"),
                        ]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      thickness: 1,
                      color: black,
                    );
                  },
                ),
              );
            } else if (state is HomePageLoading) {
              return Center(
                  child: CircularProgressIndicator(
                color: white,
              ));
            } else {
              return Container();
            }
          },
        ));
  }
}
