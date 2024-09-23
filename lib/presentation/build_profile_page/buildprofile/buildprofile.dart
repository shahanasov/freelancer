
import 'package:flutter/material.dart';
import 'package:freelance/db/services/firebase_auth.dart';
import 'package:freelance/db/services/firebase_database.dart';
import 'package:freelance/db/model/user_details.dart';
import 'package:freelance/presentation/bottom_navigation_main/bottom_nav.dart';
import 'package:freelance/presentation/build_profile_page/widgets/profile_photo_add.dart';
import 'package:freelance/theme/color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../widgets/add_skills.dart';
import '../widgets/select_city.dart';
import '../widgets/dob.dart';
import '../widgets/gender_drop_down.dart';

class BuildProfile extends StatelessWidget {
  BuildProfile({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController jobtitleController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // TextEditingController servicesController = TextEditingController();
  List<String> skills = [];
  List<String> services = [];
  XFile? imagetoPost;
  Authentication auth = Authentication();
  UserDatabaseFunctions storage = UserDatabaseFunctions();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    ProfilePhoto(
                      imagetoPost: imagetoPost,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      style: TextStyle(color: black),
                      controller: firstNameController,
                      decoration: InputDecoration(
                          // focusedBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(color: white)),
                          focusColor: white,
                          filled: true,
                          fillColor: white,
                          hintText: 'First Name', //reached
                          hintStyle: TextStyle(color: black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: TextStyle(color: black),
                      controller: secondNameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: white,
                          hintText: 'Last Name', //reached
                          hintStyle: TextStyle(color: black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: TextStyle(color: black),
                      controller: jobtitleController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: white,
                          hintText: 'Job Title', //reached
                          hintStyle: TextStyle(color: black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      minLines: 1,
                      maxLines: 5,
                      style: TextStyle(color: black),
                      controller: descriptionController,
                      decoration: InputDecoration(
                          focusColor: white,
                          filled: true,
                          fillColor: white,
                          hintText:
                              'Write a short description about you', //reached
                          hintStyle: TextStyle(color: black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    IntlPhoneField(
                      style: TextStyle(color: black),

                      controller: phoneNumberController,
                      initialCountryCode: 'IN',
                      // languageCode: 'IN',
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: white,
                          hintText: 'Phone Number', //reached
                          hintStyle: TextStyle(color: black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DOBWidget(
                      dob: dobController,
                    ), //reached
                    const SizedBox(
                      height: 10,
                    ),
                    GenderDropdown(
                      genderController: genderController,
                    ), //reached
                    const SizedBox(
                      height: 10,
                    ),
                    CitySelect(
                      countryController: countryController,
                      cityController: cityController,
                      stateController: stateController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SkillAdding(
                      onUpdateSkills: (updatedSkills) {
                        services=updatedSkills;
                      },
                      services: const [],
                      skills: skills,
                      hintText: 'Enter a Skill',
                      onUpdateServices: (_) {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SkillAdding(
                      hintText: 'Enter Your Services',
                      skills: const [],
                      services: services,
                      onUpdateSkills: (_) {},
                      onUpdateServices: (updateServices) {
                        services=updateServices;
                      },
                      
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(192, 50)),
                            backgroundColor: MaterialStateProperty.all(white),
                            foregroundColor: MaterialStatePropertyAll(black)),
                        onPressed: () {
                          submitUserDetails(context);
                        },
                        child: const Text('Submit')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future submitUserDetails(context) async {
    final firstName = firstNameController.text.trim();
    final secondName = secondNameController.text.trim();
    final jobTitle = jobtitleController.text.trim();
    final phone = int.parse(phoneNumberController.text.trim());
    final gender = genderController.text.trim();
    final country = countryController.text.trim();
    final state = stateController.text.trim();
    final city = cityController.text.trim();
    final dob = dobController.text.trim();
    final description = descriptionController.text.trim();
    // PostFunctions().convertUint8ListToFile(imagetoPost);
    // storage.uploadProfilePhotoToFirebase(File(imagetoPost!.path));

    final userDetails = UserDetailsModel(
        // profilePhoto: imagetoPo,
        firstName: firstName,
        lastName: secondName,
        phone: phone,
        gender: gender,
        country: country,
        state: state,
        city: city,
        dob: dob,
        skills: skills,
        services: services,
        description: description,
        jobTitle: jobTitle);
    storage.buildProflieSaving(userdetailsmodel: userDetails);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const BottomNav()));
  }
}
