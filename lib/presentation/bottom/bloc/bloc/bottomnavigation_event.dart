part of 'bottomnavigation_bloc.dart';

 class BottomNavigationEvent {}
 class TabChange extends BottomNavigationEvent{
  final int tabIndex;

  TabChange({required this.tabIndex});
  
 }
