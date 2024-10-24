import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freelance/db/model/user_details.dart';
import 'package:freelance/db/services/firebase_database_usersaving_functions.dart';

part 'suggestions_widget_event.dart';
part 'suggestions_widget_state.dart';

class SuggestionsWidgetBloc
    extends Bloc<SuggestionsWidgetEvent, SuggestionsWidgetState> {
  SuggestionsWidgetBloc() : super(SuggestionsWidgetInitial()) {
    on<SuggestionsWidgetEvent>((event, emit) {});
    on<ShowAllUsers>(allUsersDataFetch);
  }

  FutureOr<void> allUsersDataFetch(
      ShowAllUsers event, Emitter<SuggestionsWidgetState> emit) async {
    try {
      emit(UserDetailsLoading());
     List<UserDetailsModel?> users=await UserDatabaseFunctions().getAllUsers();
     if(users.isEmpty){
      emit(UsersEmptyState());
     }else{
      emit(AllUsersDataLoaded(users: users));
     }
    } catch (e) {
      log(e.toString());
    }
  }
}
