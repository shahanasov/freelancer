// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class NotificationService {
//   final String _serverKey = "f0qKaFm1T52bSae-9lBFel:APA91bH2Ur_8M2q0TcB2YXFx9cnorAzx83nTcZNkGfpPywEeLvuV88Zg84MzqEGsdHlGN3fWuE5tcSLEucK68lqHajxkn7HBoa3ncVaPJFeC7PgBaE24XIqU7JZkzQfB7HL2LVhLUvJI"; // Replace with your FCM server key"
//   final String _fcmUrl = 'https://fcm.googleapis.com/fcm/send';

//   Future<void> sendMessageNotification({
//     required String recipientToken,
//     required String title,
//     required String body,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse(_fcmUrl),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization': 'key=$_serverKey',
//         },
//         body: jsonEncode({
//           'to': recipientToken,
//           'notification': {
//             'title': title,
//             'body': body,
//             'sound': 'default',
//           },
//           'data': {
//             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//           },
//         }),
//       );

//       if (response.statusCode == 200) {
//         print('Notification sent successfully');
//       } else {
//         print('Failed to send notification. Error: ${response.body}');
//       }
//     } catch (e) {
//       print('Error sending notification: $e');
//     }
//   }

//   Future<void> sendFollowNotification({
//     required String recipientToken,
//     required String followerId,
//   }) async {
//     await sendMessageNotification(
//       recipientToken: recipientToken,
//       title: 'New Follower',
//       body: '$followerId started following you',
//     );
//   }

//   Future<void> sendChatNotification({
//     required String recipientToken,
//     required String senderId,
//     required String messageText,
//   }) async {
//     await sendMessageNotification(
//       recipientToken: recipientToken,
//       title: 'New Message',
//       body: 'You received a message from $senderId: $messageText',
//     );
//   }
// }
