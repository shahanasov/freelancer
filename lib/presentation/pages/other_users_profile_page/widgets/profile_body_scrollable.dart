import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/model/user_and_post_model.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/business_logic/bloc/post_related_bloc.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/widgets/tabs/posts.dart';
import 'package:freelance/presentation/pages/resume_page/bloc/resume_pdf_bloc.dart';
import 'package:freelance/presentation/pages/resume_page/resume_detailed_page.dart';
import 'package:freelance/presentation/widgets/empty_post.dart';

class ScrollableAppBar extends StatelessWidget {
  final PostWithUserDetailsModel userModel;

  const ScrollableAppBar({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
   
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          thickness: 3,
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          isThreeLine: true,
          title: const Text('Resume',
              style: TextStyle(
                  decoration: TextDecoration.underline, fontSize: 25)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${userModel.userDetailsModel.firstName} ${userModel.userDetailsModel.lastName}'),
              Row(
                children: [
                  Text('${userModel.userDetailsModel.gender} '),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                         context.read<ResumePdfBloc>().add(ResumePdfFetch(userId: userModel.userDetailsModel.id));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ResumePage(
                                  userDetails: userModel.userDetailsModel,
                                  userId: userModel.userDetailsModel.id,
                                )));
                      },
                      child: const Text(
                        'read more....',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 3,
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text('Posts',
              style: TextStyle(
                  decoration: TextDecoration.underline, fontSize: 25)),
        ),
        BlocBuilder<PostRelatedBloc, PostRelatedState>(
          builder: (context, state) {
            if(state is PostLoadingState){
              return const Center(child: CircularProgressIndicator());
            }else if(state is PostLoadedState){
              return  PostsWidget(
                userDetailsModel: userModel.userDetailsModel,
              postModelList: state.posts,
            );
            }else if(state is PostEmptyState){
             return  postEmpty(context);
            }
            else{
              return Container();
            }
            
          },
        )
      ],
    );
  }
}

