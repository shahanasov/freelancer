import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsModel {
  final String id;
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String description;
  final int phone;
  final String gender;
  final String country;
  final String state;
  final String city;
  final String dob;
  final List<String> skills;
  final List<String> services;
  List<String> follow;
  List<String> posts;
  String? profilePhoto;

  UserDetailsModel(
      {required this.id,
      required this.profilePhoto,
      required this.description,
      required this.firstName,
      required this.jobTitle,
      required this.lastName,
      required this.phone,
      required this.gender,
      required this.country,
      required this.state,
      required this.city,
      required this.dob,
      required this.skills,
      required this.services,
      required this.follow,
      required this.posts});

  static UserDetailsModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserDetailsModel(
      id: snapshot.id,
      follow: List<String>.from(snapshot.get('follow') as List<dynamic>),
      posts: List<String>.from(snapshot.get('posts') as List<dynamic>),
      profilePhoto: snapshot.get('profilePhoto') as String?,
      firstName: snapshot.get('firstName') as String,
      lastName: snapshot.get('lastName') as String,
      jobTitle: snapshot.get('jobTitle') as String,
      description: snapshot.get('description') as String,
      phone: snapshot.get('phoneNumber') as int,
      gender: snapshot.get('gender') as String,
      country: snapshot.get('country') as String,
      state: snapshot.get('state') as String,
      city: snapshot.get('city') as String,
      dob: snapshot.get('dOB') as String,
      skills: List<String>.from(snapshot.get('skills')),
      services: List<String>.from(snapshot.get('services')),
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'posts': posts,
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'profilePhoto': profilePhoto,
      'jobTitle': jobTitle,
      'description': description,
      'phoneNumber': phone,
      'gender': gender,
      'country': country,
      'state': state,
      'city': city,
      'dOB': dob,
      'skills': skills,
      'services': services,
      'follow': follow
    };
  }
}
