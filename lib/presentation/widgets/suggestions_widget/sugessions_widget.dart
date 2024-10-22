import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/home/widgets/custom_widgets.dart';
import 'package:freelance/presentation/widgets/suggestions_widget/bloc/suggestions_widget_bloc.dart';

class SuggestionsWidget extends StatelessWidget {
  const SuggestionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: BlocBuilder<SuggestionsWidgetBloc, SuggestionsWidgetState>(
        builder: (context, state) {
          if (state is AllUsersDataLoaded) {
            return showallUsersWidget(state);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
