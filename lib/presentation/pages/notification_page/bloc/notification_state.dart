part of 'notification_bloc.dart';

 class NotificationState {}

final class NotificationInitial extends NotificationState {}
final class NotificationLoading extends NotificationState{}
final class NotificationLoaded extends NotificationState{
 final List<UserDetailsModel?> user;

  NotificationLoaded({required this.user});
}
