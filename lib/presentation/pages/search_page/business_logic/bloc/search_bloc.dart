import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freelance/db/services/firebase_database.dart';
import 'package:freelance/db/model/userdetails.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchingEvent>(search);
  }

  FutureOr<void> search(SearchingEvent event, Emitter<SearchState> emit) async {
    try{
       List<UserDetailsModel>? users = await UserDatabaseFunctions()
          .getSearchResult(querySearch: event.query);
           if (users==null|| users.isEmpty) {
        emit(SearchingState(users: [],hasReachedLimit: false));
      } else {
        emit(SearchingState(
          users: users,
          hasReachedLimit: users.length<10,
        ));
      }
    }catch(e){
    (e);
    }
   
  }
}
