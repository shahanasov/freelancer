import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/db/model/userdetails.dart';

class PostWithUserDetailsModel {
  PostModel postModel;
  UserDetailsModel userDetailsModel;

  PostWithUserDetailsModel(
      {required this.postModel, required this.userDetailsModel});
}
