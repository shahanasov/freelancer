import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freelance/db/model/notification_model.dart';
import 'package:freelance/db/model/user_details.dart';

class NotificationFunctions {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  // Function to send a follow request
  followRequest(FollowRequest request) {
    final requests = FirebaseFirestore.instance.collection("Notifications");

    final newfollow = FollowRequest(
      followerId: request.followerId,
      userId: request.userId,
      fromUserName: request.fromUserName,
      timestamp: request.timestamp,
    ).tojson();

    // Store follow request under the followerId and current userId
    requests
        .doc(request.followerId)
        .collection('followRequests')
        .doc(userId) // Current user's ID as doc ID
        .set(newfollow);
  }

  // Function to fetch all follow requests for the current user
  Future<List<UserDetailsModel?>> getAllFollow() async {
    // print(userId);
    // Get all follow requests for the current user (userId)
    final notificationsSnapshot = await FirebaseFirestore.instance
        .collection("Notifications")
        .doc(userId) // Current user's ID
        .collection('followRequests')
        // .orderBy('timestamp', descending: true)
        .get();

    List<UserDetailsModel?> users = [];
    // print("${notificationsSnapshot.docs} doc");

    for (var follow in notificationsSnapshot.docs) {
      // print("$follow....");
      final not = FollowRequest.fromDocument(follow);
      // print("${not.userId}.....");
      // Fetch the user details of the follower
      if (not.followerId != userId) {
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await FirebaseFirestore.instance
                .collection('UsersDetails')
                .doc(not.userId)
                .get();
        // print("$userSnapshot usersnapshot");
        if (userSnapshot.exists) {
          // print(userSnapshot);
          UserDetailsModel userData =
              UserDetailsModel.fromSnapshot(userSnapshot);
          // print(userData);
          // Add the user data to the list

          users.add(userData);
        } else {
          // Handle the case if the user does not exist
          // users.add(null);  // Add null or handle the missing user data
        }
      }
    }

    return users;
  }

  requstedService(FollowRequest request) {
    final requests = FirebaseFirestore.instance.collection("Notifications");
    final docId =
        FirebaseFirestore.instance.collection("Notifications").doc().id;

    final newfollow = FollowRequest(
      followerId: request.followerId,
      userId: request.userId,
      fromUserName: request.fromUserName,
      timestamp: request.timestamp,
    ).tojson();

    // Store  request  and current userId
    requests
        .doc(request.followerId)
        .collection('ServiceRequests')
        .doc(docId) // Current user's ID as doc ID
        .set(newfollow);
  }
}
