import 'package:bloc/bloc.dart';

part 'profile_tabs_event.dart';
part 'profile_tabs_state.dart';

class ProfileTabsBloc extends Bloc<ProfileTabsEvent, ProfileTabsState> {
  ProfileTabsBloc() : super(ProfileTabsInitial()) {
    on<ProfileTabsEvent>((event, emit)async {
      if (event is PostTabEvent) {
        emit(PostTab());
      } else if (event is WorksTabEvent) {
        emit(WorksTab());
      } else if (event is ResumeTabEvent) {
        emit(ResumeTab());
      } else {
        emit(ResumeTab());
      }
    });
  }
}
