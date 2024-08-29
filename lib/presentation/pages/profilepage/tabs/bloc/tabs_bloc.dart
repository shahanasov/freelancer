import 'package:bloc/bloc.dart';


part 'tabs_event.dart';
part 'tabs_state.dart';

class TabsBloc extends Bloc<TabsEvent, TabsState> {
  TabsBloc() : super(TabsInitial()) {
   on<TabsEvent>((event, emit) {
      if (event is PostTabEvent) {
        emit(PostTabState());
      } else if (event is WorksTabEvent) {
        emit(WorkTabState());
      } else if (event is ResumeTabEvent) {
        emit(ResumeTabState());
      } else {
        emit(PostTabState());
      }
    });
  }
}
