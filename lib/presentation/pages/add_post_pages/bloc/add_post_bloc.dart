import 'package:bloc/bloc.dart';


part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc() : super(AddPostInitial()) {
    on<AddPostEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
