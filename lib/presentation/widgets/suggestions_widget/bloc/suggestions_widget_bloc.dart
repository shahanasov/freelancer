import 'package:bloc/bloc.dart';

part 'suggestions_widget_event.dart';
part 'suggestions_widget_state.dart';

class SuggestionsWidgetBloc
    extends Bloc<SuggestionsWidgetEvent, SuggestionsWidgetState> {
  SuggestionsWidgetBloc() : super(SuggestionsWidgetInitial()) {
    on<SuggestionsWidgetEvent>((event, emit) {});
  }
}
