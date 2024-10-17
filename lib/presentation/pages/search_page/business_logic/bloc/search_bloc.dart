import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/db/model/user_and_post_model.dart';
import 'package:freelance/db/services/firebase_database_usersaving_functions.dart';
import 'package:freelance/db/model/user_details.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchingEvent>(search);
  }

  FutureOr<void> search(SearchingEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    try {
      // Check if the query is empty
      if (event.query.isEmpty) {
        emit(SearchEmptyState());
        return;
      }

      // Fetch user details based on search query
      List<UserDetailsModel>? users = await UserDatabaseFunctions()
          .getSearchResult(querySearch: event.query);

      List<PostWithUserDetailsModel> postsWithUserDetails = [];
      if (users != null && users.isNotEmpty) {
        // Fetch user details for each post
        for (var user in users) {
          QuerySnapshot<Map<String, dynamic>> postSnapshot = await FirebaseFirestore.instance
              .collection('Posts')
              .where('userId', isEqualTo: user.id) // Adjust as needed
              // .limit(10) // Add limit to reduce the amount of data fetched
              .get();

          // Combine post and user data into the PostWithUserDetailsModel
          for (var postDoc in postSnapshot.docs) {
            var postData = PostModel.fromSnapshot(postDoc);
            postsWithUserDetails.add(PostWithUserDetailsModel(
              postModel: postData,
              userDetailsModel: user,
            ));
          }
        }
      }

      // Emit the appropriate state based on results
      if (postsWithUserDetails.isEmpty) {
        emit(SearchEmptyState());
      } else {
        emit(SearchingState(
          user: users,
          postsWithUser: postsWithUserDetails,
          hasReachedLimit: postsWithUserDetails.length < 10,
        ));
      }
    } catch (e) {
      emit(SearchErrorState(error: e.toString()));
      print("Error occurred while searching: $e"); 
    }
  }
}