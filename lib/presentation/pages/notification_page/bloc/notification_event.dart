part of 'notification_bloc.dart';


 class NotificationEvent {}
 class RequestNotificationPermission extends NotificationEvent{}
 class SaveTokenToFirestore extends NotificationEvent{
  final String userId;

  SaveTokenToFirestore({required this.userId});
 }

class SendMessageNotification extends NotificationEvent{
  final String senderId;
  final String recipientId;
  final String messageText;

  SendMessageNotification({required this.senderId, required this.recipientId, required this.messageText});
}

class SendFollowNotification extends NotificationEvent{
  final String followerId;
  final String userId;

  SendFollowNotification({required this.followerId, required this.userId});
}