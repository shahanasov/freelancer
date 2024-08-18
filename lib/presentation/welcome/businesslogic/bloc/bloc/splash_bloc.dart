import 'package:bloc/bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>((event, emit) async {
      if (event is SplashLoading) {
        // emit(SplashLoading());
        await Future.delayed(const Duration(seconds: 3));
        emit(SplashLoaded());
      }
    });
  }
}
