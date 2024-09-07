import 'package:bloc/bloc.dart';
import 'package:freelance/db/model/post_model.dart';

import '../../../../../db/services/post_functions.dart';

part 'tabs_event.dart';
part 'tabs_state.dart';

class TabsBloc extends Bloc<TabsEvent, TabsState> {
  TabsBloc() : super(TabsInitial()) {
    on<TabsEvent>((event, emit) async {
      if (event is PostTabEvent) {
        emit(PostLoadingState());
        try {
          final posts = await PostFunctions().getCurrentUserPosts();
          emit(PostTabState(posts: posts,));
        } catch (e) {
          print(e.toString());
          emit(PostErrorState(e.toString()));
        }
      } else if (event is WorksTabEvent) {
        emit(WorkTabState());
      } else if (event is ResumeTabEvent) {
        emit(ResumeTabState());
      } else {
        emit(ResumeTabState());
      }
    });
  }
}
