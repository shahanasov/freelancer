part of 'toggle_bloc.dart';

 class ToggleEvent {}

 class ToggleLogin extends ToggleEvent{}
 class ToggleSignUP extends ToggleEvent{}
class LoginSubmitted extends ToggleEvent{
  final String email;
  final String password;
  LoginSubmitted( {required this.password,required this.email});
}
class SignInSubmitted extends ToggleEvent{
  final String email;
  final String password;
  SignInSubmitted({required this.password, required this.email});
}
class SignOut extends ToggleEvent{}
// class ShowPasswordEvent extends ToggleEvent{}


