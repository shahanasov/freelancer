import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chatlist_event.dart';
part 'chatlist_state.dart';

class ChatlistBloc extends Bloc<ChatlistEvent, ChatlistState> {
  ChatlistBloc() : super(ChatlistInitial()) {
    on<ChatlistEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
