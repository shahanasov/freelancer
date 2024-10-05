part of 'notification_bloc.dart';

 class NotificationState {}

final class NotificationInitial extends NotificationState {}
class NotificationPermissionGranted extends NotificationState{}
class NotificationPermissionDenied extends NotificationState{}
class TokenSavedSuccess extends NotificationState{}
class TokenSavedFailure extends NotificationState{}
class NotificationSentSuccess extends NotificationState{}
class NotificationSentFailure extends NotificationState{}
