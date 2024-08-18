part of 'toggle_bloc.dart';

class ToggleState {
  // final bool? obscureText;
  // final IconData? icon;

  // ToggleState({this.obscureText, this.icon});

  // ToggleState copyWith({bool? obscureText, IconData? icon}) {
  //   return ToggleState(
  //     obscureText: obscureText ?? this.obscureText,
  //     icon: icon ?? this.icon,
  //   );
  // }
}

class LoginState extends ToggleState {}

class SignUpState extends ToggleState {}

class LoginSubmittedState extends ToggleState {}

class SignupSubmittedState extends ToggleState {}

class ErrorsignIn extends ToggleState {}

class SignOutState extends ToggleState {}
