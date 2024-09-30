import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freelance/db/services/firebase_auth.dart';

part 'toggle_event.dart';
part 'toggle_state.dart';

class ToggleBloc extends Bloc<ToggleEvent, ToggleState> {
  final Authentication auth;
  ToggleBloc({required this.auth}) : super(LoginState()) {
    on<ToggleEvent>((event, emit) {
      if (event is ToggleLogin) {
        emit(LoginState());
      } else if (event is ToggleSignUP) {
        emit(SignUpState());
      }else{
        emit(LoginState());
      }
    });
    on<LoginSubmitted>(login);
    on<SignInSubmitted>(signin);
    on<SignOut>(signout);
    on<GoogleSignIn>(googleSignin);
  }

  FutureOr<void> login(LoginSubmitted event, Emitter<ToggleState> emit) async {
    try {
      await  auth.loginWithEmailAndPassword( email:event.email, password: event.password, );
      emit(LoginSubmittedState());
    } catch (e) {
      emit(ErrorsignIn());
    }
  }

  FutureOr<void> signin(
      SignInSubmitted event, Emitter<ToggleState> emit) async {
    try {
      await auth.addUsersWithEmail(event.email, event.password);
      emit(SignupSubmittedState());
    } catch (e) {
      emit(ErrorsignIn());
    }
  }

  FutureOr<void> signout(SignOut event, Emitter<ToggleState> emit) async {
    await auth.signOut();
    emit(SignOutState());
  }

  FutureOr<void> googleSignin(GoogleSignIn event, Emitter<ToggleState> emit) async{
    try{
      print(await auth.signInWithGoogle());
    }catch(e){
      emit(ErrorsignIn());
    }
  }
}
