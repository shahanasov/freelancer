import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/db/model/user_details.dart';

class PostWithUserDetailsModel {
  PostModel postModel;
  UserDetailsModel userDetailsModel;

  PostWithUserDetailsModel(
      {required this.postModel, required this.userDetailsModel});
}
