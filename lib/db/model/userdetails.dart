import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsModel {
  final String? id;
  final String firstName;
  final String lastName;
  final String description;
  final int phone;
  final String gender;
  final String country;
  final String state;
  final String city;
  final String dob;
  final List<String> skills;
  final List<String> services;
  // FilesModel? filesModel;

  UserDetailsModel(
      {this.id,
      required this.description,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.gender,
      required this.country,
      required this.state,
      required this.city,
      required this.dob,
      required this.skills,
      required this.services});

  static UserDetailsModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserDetailsModel(
      // id: snapshot.get('id'),
      firstName: snapshot.get('First Name') as String,
      lastName: snapshot.get('Last Name') as String,
      description: snapshot.get('Description')as String,
      phone: snapshot.get('Phone Number') as int,
      gender: snapshot.get('Gender') as String,
      country: snapshot.get('Country') as String,
      state: snapshot.get('State') as String,
      city: snapshot.get('City') as String,
      dob: snapshot.get('DOB') as String,
      skills: List<String>.from(snapshot.get('Skills')),
      services: List<String>.from(snapshot.get('Services')),
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'First Name': firstName,
      'Last Name': lastName,
      'Description' : description,
      'Phone Number': phone,
      'Gender': gender,
      'Country': country,
      'State': state,
      'City': city,
      'DOB': dob,
      'Skills': skills,
      'Services': services
    };
  }
}
