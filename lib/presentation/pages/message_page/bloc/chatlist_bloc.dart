import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freelance/db/model/user_details.dart';
import 'package:freelance/db/services/chat_functions.dart';
import 'package:freelance/db/services/firebase_database_usersaving_functions.dart';

part 'chatlist_event.dart';
part 'chatlist_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  ChatListBloc() : super(ChatListInitial()) {
    on<ChatListEvent>((event, emit) {});
    on<GetChatList>(getChatList);
  }

  FutureOr<void> getChatList(
      GetChatList event, Emitter<ChatListState> emit) async {
    try {
      emit(ChatListLoading());

      // Fetch chat users
      final chatList = await ChatServices()
          .getMessagedUsers(FirebaseAuth.instance.currentUser!.uid);
      final time = await ChatServices()
          .lastMessaged(FirebaseAuth.instance.currentUser!.uid);
      List<UserDetailsModel> userList = [];

      for (String userId in chatList) {
        final userDetails = await UserDatabaseFunctions().userDetails(userId);
        if (userDetails != null) {
          userList.add(userDetails);
        }
      }

      emit(ChatListed(user: userList, time: time));
    } catch (e) {
      emit(ChatListError(error: e.toString()));
    }
  }
}
