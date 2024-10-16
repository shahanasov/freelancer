
import 'package:cloud_firestore/cloud_firestore.dart';

class FollowRequest {
  final String followerId;
  final String userId;
  final String fromUserName;
  final DateTime timestamp;

  FollowRequest({
    required this.followerId,
    required this.userId,
    required this.fromUserName,
    required this.timestamp,
  });

  factory FollowRequest.fromDocument (DocumentSnapshot<Map<String, dynamic>> snapshot)  {
     Timestamp timestamp = snapshot.get('time') as Timestamp;
    return FollowRequest(
       userId: snapshot.get('userId') as String,
      followerId: snapshot.get('fromUserName') as String,
      fromUserName: snapshot.get('fromUserName') as String,
      timestamp: timestamp.toDate(),
    );
  }
  Map<String, dynamic> tojson() {
    return {
      'follower':followerId,
      'fromUserName':fromUserName,
      'userId':userId,
      'time':timestamp
    };}
}
