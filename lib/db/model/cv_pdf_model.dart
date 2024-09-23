import 'package:cloud_firestore/cloud_firestore.dart';

class ResumeModel {
  final String? resumeName;
  final String? resumePath;
  final String? resumeUrl;
  final String? userId;

  ResumeModel({this.resumeName, this.resumePath, this.resumeUrl, this.userId});
  Map<String, dynamic> tojson() {
    return {
      'userId': userId,
      'resumeName': resumeName,
      'postDescription': resumePath,
      'imagePathofPost': resumeUrl,
    };
  }

  static ResumeModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return ResumeModel(
      userId: snapshot.get('userId') as String,
      resumeUrl: snapshot.get('postId') as String,
      resumeName: snapshot.get('postDescription') as String,
      resumePath: snapshot.get('imagePathofPost') as String?,
    );
  }
}
