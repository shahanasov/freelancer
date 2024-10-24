import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/notification_page/bloc/notification_bloc.dart';
import 'package:freelance/presentation/widgets/custom_appbar.dart';
import 'package:freelance/presentation/widgets/custom_notification_widget.dart';
import 'package:freelance/theme/color.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NotificationBloc>().add(NotificationFetch());
    return Scaffold(
      appBar: customAppBar(context),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          bool isDark =
              Theme.of(context).colorScheme.brightness == Brightness.dark;
          if (state is NotificationLoaded) {
            if (state.user.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/remove.png",
                      height: 100,
                      width: 100,
                      color: isDark ? white : black,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('No Notifications',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w100),),
                  ],
                ),
              );
            }
            return notificationWidget(state);
          } else if (state is NotificationLoading) {
            // Center the loading spinner
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Default state when there's no data or an error occurred
            return Container(
              color: const Color.fromARGB(255, 54, 53, 53),
            );
          }
        },
      ),
    );
  }
}
