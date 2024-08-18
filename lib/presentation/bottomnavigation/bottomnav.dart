import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/bottomnavigation/bloc/bloc/bottomnavigation_bloc.dart';
import 'package:freelance/presentation/pages/Home/homepage.dart';
import 'package:freelance/presentation/pages/profilepage/profile.dart';
import 'package:freelance/theme/color.dart';

List<BottomNavigationBarItem> bottomNav = <BottomNavigationBarItem>[
  const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
  const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.add_box_outlined), label: 'Add'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.notifications_none), label: 'Notifications'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline_sharp), label: 'Profile')
];

List<Widget> pages = <Widget>[
  const HomePage(),
  const Center(child: Text('one')),
  const Center(child: Text('two')),
  const Center(child: Text('theee')),
   const ProfilePage()
];

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark =Theme.of(context).colorScheme.brightness==Brightness.dark;
    return BlocConsumer<BottomNavigationBloc, BottomNavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: pages.elementAt(state.tabIndex),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 1,
            items: bottomNav,
          selectedItemColor: isDark? white: black,
          showSelectedLabels: true,
          unselectedItemColor: isDark? white: black,
          currentIndex: state.tabIndex,
          onTap: (index){
            BlocProvider.of<BottomNavigationBloc>(context).add(TabChange(tabIndex: index));
          },
          ),
        );
      },
    );
  }
}
