// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:freelance/db/services/chat_functions.dart';
// import 'package:freelance/db/services/notification_functions.dart';

// part 'notification_event.dart';
// part 'notification_state.dart';

// class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
//   NotificationBloc() : super(NotificationInitial()) {
//     on<NotificationEvent>((event, emit) {});
//     on<RequestNotificationPermission>(_onRequestNotificationPermission);
//     on<SaveTokenToFirestore>(_onSaveTokenToFirestore);
//     on<SendMessageNotification>(_onSendMessageNotification);
//     on<SendFollowNotification>(_onSendFollowNotification);
//   }
//   final FirebaseMessaging _messaging =FirebaseMessaging.instance;
//   FutureOr<void> _onRequestNotificationPermission(
//       RequestNotificationPermission event, Emitter<NotificationState> emit) async{
//         try{
//           NotificationSettings settings = await _messaging.requestPermission(
//             alert: true,
//             badge: true,
//             sound: true
//           );
//           if(settings.authorizationStatus== AuthorizationStatus.authorized){
//             emit(NotificationPermissionGranted());
//           }else{
//             emit(NotificationPermissionDenied());
//           }
//         }catch(e){
//           emit(NotificationPermissionDenied());
//         }
//       }

//   FutureOr<void> _onSaveTokenToFirestore(
//       SaveTokenToFirestore event, Emitter<NotificationState> emit) async{
//         try{
//           String? token = await _messaging.getToken();
//           if(token !=null){
//             await FirebaseFirestore.instance.collection('userDetails').doc(event.userId).update({
//               'token':token
//             });
//             emit(TokenSavedSuccess());
//           }else{
//             emit(TokenSavedFailure());
//           }
//         }catch(e){
//           emit(TokenSavedFailure());
//         }
//       }

//   FutureOr<void> _onSendMessageNotification(
//       SendMessageNotification event, Emitter<NotificationState> emit) async{
//         await ChatServices().sendMessage(event.senderId, event.messageText);
        
//          try {
//       await FirebaseFirestore.instance.collection('chats').add({
//         'senderId': event.senderId,
//         'recipientId': event.recipientId,
//         'message': event.messageText,
//         'timestamp': DateTime.now(),
//       });
//        DocumentSnapshot recipientSnapshot =
//           await FirebaseFirestore.instance.collection('users').doc(event.recipientId).get();
//       String? recipientToken = recipientSnapshot['fcmToken'];

//       if (recipientToken != null) {
//         // await NotificationService().sendChatNotification(
//           // recipientToken: recipientToken,
//           // senderId: event.senderId,
//           // messageText: event.messageText,
//         // );
//         emit(NotificationSentSuccess());
//       } else {
//         emit(NotificationSentFailure());
//       }
//     } catch (e) {
//       emit(NotificationSentFailure());
//     }
//       }

//   FutureOr<void> _onSendFollowNotification(
//       SendFollowNotification event, Emitter<NotificationState> emit) async{
//         try {
//       await FirebaseFirestore.instance
//           .collection('followers')
//           .doc(event.followerId)
//           .collection('userFollowers')
//           .doc(event.followerId)
//           .set({
//         'followerId': event.followerId,
//         'timestamp': DateTime.now(),
//       });

//       DocumentSnapshot followedUserSnapshot =
//           // await FirebaseFirestore.instance.collection('users').doc(event.followerId).get();
//       // String? followedUserToken = followedUserSnapshot['fcmToken'];

//       // if (followedUserToken != null) {
//         // await NotificationService().sendFollowNotification(
//         //   recipientToken: followedUserToken,
//         //   followerId: event.followerId,
//         // );
//         emit(NotificationSentSuccess());
//       } else {
//         emit(NotificationSentFailure());
//       }
//     } catch (e) {
//       emit(NotificationSentFailure());
//     }
  
//       }
// }
