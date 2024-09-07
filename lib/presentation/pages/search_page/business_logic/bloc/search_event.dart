part of 'search_bloc.dart';

 class SearchEvent {}
 class SearchingEvent extends SearchEvent{
  final String query;

  SearchingEvent({required this.query});
  @override
  String toString()=>'SearchingEvent {query: $query}';
 }