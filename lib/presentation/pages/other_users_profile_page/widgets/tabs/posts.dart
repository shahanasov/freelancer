import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/presentation/pages/profile_page/businesslogin/bloc/profile_page_bloc.dart';
import 'package:freelance/theme/color.dart';

class PostsWidget extends StatelessWidget {
  final List<PostModel> postModelList;
  const PostsWidget({super.key, required this.postModelList});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        if(state is PostLoadedState){
        return SingleChildScrollView(
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 1,
                  color: black,
                );
              },
              padding: const EdgeInsets.all(15),
              itemCount: postModelList.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(postModelList[index].postDescription ?? ''),
                      // trailing: IconButton(
                      //     onPressed: () {
                      //       showBottomSheet(
                      //           context: context,
                      //           builder: (context) {
                      //             return Column(
                      //               children: [
                      //                 ListTile(
                      //                   onTap: () {},
                      //                   leading: const Icon(Icons.edit),
                      //                   title: const Text('Share Post'),
                      //                 ),
                      //                 const ListTile(
                      //                   leading: Icon(Icons.delete),
                      //                   title:
                      //                       Text('Request this Service'),
                      //                 )
                      //               ],
                      //             );
                      //           });
                      //     },
                      //     icon: const Icon(Icons.more_vert))
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        child: postModelList[index].imagepathofPost != null
                            ? Image.network(
                                postModelList[index].imagepathofPost!,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox()),
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
                        Icon(Icons.add)
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${postModelList[index].likes.length} likes"),
                  ],
                );
              }),
        );}else {
         return Container();
        }
      },
    );
  }
}
