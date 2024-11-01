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
      body: LayoutBuilder(builder: (context, constaints) {
        return BlocBuilder<SuggestionsWidgetBloc, SuggestionsWidgetState>(
          builder: (context, state) {
            if (state is AllUsersDataLoaded) {
              if (constaints.maxWidth > 1000) {
                return Padding(
                  padding: const EdgeInsets.only(left: 300, right: 300),
                  child: showallUsersWidget(state, constaints.maxWidth < 600),
                );
              }
              return showallUsersWidget(state, constaints.maxWidth < 600);
            } else {
              return Container();
            }
          },
        );
      }),
    );
  }
}
