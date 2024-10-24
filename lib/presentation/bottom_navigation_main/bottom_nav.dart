import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/bottom_navigation_main/bloc/bloc/bottomnavigation_bloc.dart';
import 'package:freelance/presentation/pages/Home/home_page.dart';
import 'package:freelance/presentation/pages/notification_page/notification_page.dart';
import 'package:freelance/presentation/pages/profile_page/businesslogin/bloc/profile_page_bloc.dart';
import 'package:freelance/presentation/pages/profile_page/profile.dart';
import 'package:freelance/presentation/widgets/suggestions_widget/bloc/suggestions_widget_bloc.dart';
import 'package:freelance/theme/color.dart';

import '../pages/search_page/search_page.dart';

List<BottomNavigationBarItem> bottomNav = <BottomNavigationBarItem>[
  const BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    label: 'Home',
    tooltip: 'Home',
    activeIcon: Icon(Icons.home_rounded, size: 30,),
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.search_outlined),
    label: 'Search',
    tooltip: 'Search',
    activeIcon: Icon(
      Icons.search_rounded,
      size: 30,
    ),
  ),
  const BottomNavigationBarItem(
      activeIcon: Icon(Icons.notifications, size: 30,),
      tooltip: 'Notifications',
      icon: Icon(Icons.notifications_none),
      label: 'Notifications'),
  const BottomNavigationBarItem(
      tooltip: 'Profile',
      activeIcon: Icon(Icons.person, size: 30,),
      icon: Icon(Icons.person_outline_sharp),
      label: 'Profile')
];



List<Widget> pages = <Widget>[
  const HomePage(),
  const SearchPage(),
  const NotificationPage(),
  const ProfilePage()
];

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<ProfilePageBloc>()
        .add(PostLoadEvent(id: FirebaseAuth.instance.currentUser!.uid));
    context.read<ProfilePageBloc>().add(ProfileLoadEvent());
    context.read<SuggestionsWidgetBloc>().add(ShowAllUsers());
    bool isDark = Theme.of(context).colorScheme.brightness == Brightness.dark;
    return BlocConsumer<BottomNavigationBloc, BottomNavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: pages.elementAt(state.tabIndex),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 1,
            items: bottomNav,
            selectedItemColor: isDark ? white : black,
            showSelectedLabels: false,
            unselectedItemColor: isDark ? white : black,
            currentIndex: state.tabIndex,
            onTap: (index) {
              BlocProvider.of<BottomNavigationBloc>(context)
                  .add(TabChange(tabIndex: index));
            },
          ),
        );
      },
    );
  }
}
