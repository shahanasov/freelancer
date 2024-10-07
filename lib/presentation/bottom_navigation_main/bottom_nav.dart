import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/bottom_navigation_main/bloc/bloc/bottomnavigation_bloc.dart';
import 'package:freelance/presentation/pages/Home/home_page.dart';
import 'package:freelance/presentation/pages/notification_page/notification_page.dart';
import 'package:freelance/presentation/pages/profile_page/profile.dart';
import 'package:freelance/theme/color.dart';

import '../pages/search_page/search_page.dart';

List<BottomNavigationBarItem> bottomNav = <BottomNavigationBarItem>[
  const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined), label: 'Home', tooltip: 'Home'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.search), label: 'Search', tooltip: 'Search'),
  // const BottomNavigationBarItem(
  //     icon: Icon(Icons.add_box_outlined), label: 'Add'),
  const BottomNavigationBarItem(
      tooltip: 'Notifications',
      icon: Icon(Icons.notifications_none),
      label: 'Notifications'),
  const BottomNavigationBarItem(
      tooltip: 'Profile',
      icon: Icon(Icons.person_outline_sharp),
      label: 'Profile')
];


String id = FirebaseAuth.instance.currentUser!.uid;
List<Widget> pages = <Widget>[
  const HomePage(),
  const SearchPage(),
  // Container(),
  const NotificationsPage(),
  ProfilePage(
    id: id,
  )
];

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
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
