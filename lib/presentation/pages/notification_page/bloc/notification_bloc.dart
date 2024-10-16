import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freelance/db/model/user_details.dart';
import 'package:freelance/db/services/notification_functions.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) {});
    on<NotificationFetch>(notificationFetch);
  }

  FutureOr<void> notificationFetch(NotificationFetch event, Emitter<NotificationState> emit) async{
    emit(NotificationLoading());
    final List<UserDetailsModel?> users=await NotificationFunctions().getAllFollow();
    emit(NotificationLoaded(user: users));

  }
}
