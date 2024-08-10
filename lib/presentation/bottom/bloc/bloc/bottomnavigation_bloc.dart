import 'package:bloc/bloc.dart';

part 'bottomnavigation_event.dart';
part 'bottomnavigation_state.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationInitial(tabIndex: 0)) {
    on<BottomNavigationEvent>((event, emit) {
      if(event is TabChange){
        emit(BottomNavigationState(tabIndex: event.tabIndex));
      }
    });
  }
}
