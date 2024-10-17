import 'package:cloud_firestore/cloud_firestore.dart';

class ResumeModel {
  final String? resumeName;
  final String? resumePath;
  final String? resumeUrl;
  final String? userId;

  ResumeModel({
    this.resumeName,
    this.resumePath,
    this.resumeUrl,
    this.userId,
  });
  
  Map<String, dynamic> tojson() {
    return {
      'userId': userId,
      'resumeName': resumeName,
      'resumePath': resumePath,
      'resumeUrl': resumeUrl,
    };
  }

  static ResumeModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return ResumeModel(
      userId: snapshot.get('userId') as String,
      resumeUrl: snapshot.get('resumeUrl') as String,
      resumeName: snapshot.get('resumeName') as String,
      resumePath: snapshot.get('resumePath') as String?,
    );
  }
}
