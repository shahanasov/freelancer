import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? postId;
  String? postDescription;
  String? imagepathofPost;
  final String? userId;
  DateTime time;
  PostModel(
      {required this.postDescription,
      this.userId,
      this.postId,
      required this.imagepathofPost,
      required this.time});

  Map<String, dynamic> tojson() {
    return {
      'userId': userId,
      'postId': postId,
      'postDescription': postDescription,
      'imagePathofPost': imagepathofPost,
      'time': time
    };
  }

  static PostModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
         Timestamp timestamp = snapshot.get('time') as Timestamp;
    return PostModel(
     userId : snapshot.get('userId') as String,
      postId: snapshot.get('postId') as String,
      postDescription: snapshot.get('postDescription') as String,
      imagepathofPost: snapshot.get('imagePathofPost') as String,
      time: timestamp.toDate(),
    );
  }
}
