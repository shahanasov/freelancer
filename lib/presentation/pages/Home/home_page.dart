import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/business_logic/bloc/post_related_bloc.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/others_profile_page.dart';
import 'package:freelance/presentation/widgets/custom_appbar.dart';
import 'package:freelance/presentation/widgets/post_icons.dart';
import 'package:freelance/theme/color.dart';

import 'bloc/home_page_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context),
        body: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            // print(state.toString());
            if (state is HomePageLoaded) {
              return customPostList(context, state);
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

Widget customPostList(
  BuildContext context,
  HomePageLoaded state,
) {
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: ListView.separated(
      itemCount: state.userandPost.length,
      itemBuilder: (context, index) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {
              context.read<PostRelatedBloc>().add(AllPostsFetchEvent(
                  userId: state.userandPost[index].postModel.userId!));
              if (userId != state.userandPost[index].postModel.userId) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OthersProfilePage(
                          userModel: state.userandPost[index],
                        )));
              }
            },
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CircleAvatar(
                  backgroundColor: white,
                  radius: 20,
                  backgroundImage:
                      state.userandPost[index].userDetailsModel.profilePhoto !=
                              null
                          ? NetworkImage(state.userandPost[index]
                              .userDetailsModel.profilePhoto!)
                          : const AssetImage("assets/images/profilenew.jpg")
                              as ImageProvider,
                )),
            title: Text(
                "${state.userandPost[index].userDetailsModel.firstName} ${state.userandPost[index].userDetailsModel.lastName}"),
            subtitle: Text(state.userandPost[index].userDetailsModel.jobTitle),
          ),
          state.userandPost[index].postModel.imagepathofPost == null
              ? ListTile(
                  title: Text(
                      state.userandPost[index].postModel.postDescription ?? ''),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.userandPost[index].postModel.postDescription ??
                        ''),
                    const SizedBox(
                      height: 10,
                    ),
                    AspectRatio(
                      aspectRatio: 4 / 5,
                      child: Image.network(
                        state.userandPost[index].postModel.imagepathofPost!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
          const SizedBox(
            height: 10,
          ),
          //  here row
          PostIcons(
              userDetailsModel: state.userandPost[index].userDetailsModel,
              postModel: state.userandPost[index].postModel,
              userId: state.userandPost[index].postModel.userId!)
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
}
