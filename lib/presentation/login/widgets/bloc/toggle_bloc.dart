import 'package:bloc/bloc.dart';



part 'toggle_event.dart';
part 'toggle_state.dart';

class ToggleBloc extends Bloc<ToggleEvent, ToggleState> {
  ToggleBloc() : super(LoginState()) {
    on<ToggleEvent>((event, emit) {
     if(event is ToggleLogin){
      emit(LoginState());
     }else if(event is ToggleSignUP){
      emit(SignUpState());
     }
    });
  }
}
