import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance/db/services/firebase_auth.dart';
import 'package:freelance/db/services/firebase_database_usersaving_functions.dart';
import 'package:freelance/db/model/user_details.dart';
import 'package:freelance/presentation/bottom_navigation_main/bottom_nav.dart';
import 'package:freelance/presentation/build_profile_page/widgets/profile_photo_add.dart';
import 'package:freelance/presentation/widgets/textform_field.dart';
import 'package:freelance/theme/color.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/add_skills.dart';
import '../widgets/select_city.dart';
import '../widgets/dob.dart';
import '../widgets/gender_drop_down.dart';

// ignore: must_be_immutable
class BuildProfile extends StatelessWidget {
  final UserDetailsModel? userDetailsModel;
  BuildProfile({super.key, this.userDetailsModel});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

// controllers
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

  // valueNotifiers
  ValueNotifier<List<String>> skillsNotifier = ValueNotifier([]);
  ValueNotifier<List<String>> servicesNotifier = ValueNotifier([]);

  // Image
  XFile? imagetoPost;

  //services
  Authentication auth = Authentication();
  UserDatabaseFunctions storage = UserDatabaseFunctions();

  @override
  Widget build(BuildContext context) {
    if (userDetailsModel != null) {
      firstNameController =
          TextEditingController(text: userDetailsModel!.firstName);
      secondNameController =
          TextEditingController(text: userDetailsModel!.lastName);
      jobtitleController =
          TextEditingController(text: userDetailsModel!.jobTitle);
      phoneNumberController =
          TextEditingController(text: '${userDetailsModel!.phone}');
      genderController = TextEditingController(text: userDetailsModel!.gender);
      countryController =
          TextEditingController(text: userDetailsModel!.country);
      stateController = TextEditingController(text: userDetailsModel!.state);
      cityController = TextEditingController(text: userDetailsModel!.city);
      dobController = TextEditingController(text: userDetailsModel!.dob);
      descriptionController =
          TextEditingController(text: userDetailsModel!.description);
      skillsNotifier.value = List.from(userDetailsModel!.skills);
      servicesNotifier.value = List.from(userDetailsModel!.services);
    }

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
                      onImageSelected: (XFile? selectedImage) {
                        imagetoPost =
                            selectedImage; // Update the imagetoPost variable when an image is selected
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    buildTextField(
                      controller: firstNameController,
                      hintText: 'First Name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' Name  is required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    buildTextField(
                        controller: secondNameController,
                        hintText: 'Last Name',
                        validator: null),

                    const SizedBox(
                      height: 10,
                    ),
                    buildTextField(
                      controller: jobtitleController,
                      hintText: 'Job Title',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' Job title is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildDescriptionFeild(controller: descriptionController),
                    const SizedBox(
                      height: 10,
                    ),
                    buildPhoneNumberField(controller: phoneNumberController),
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
                      hintText: 'Enter a Skill',
                      skillsNotifier: skillsNotifier,
                      servicesNotifier: servicesNotifier,
                    ),
                    const SizedBox(height: 10),
                    SkillAdding(
                      hintText: 'Enter Your Services',
                      skillsNotifier: skillsNotifier,
                      servicesNotifier: servicesNotifier,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        style: ButtonStyle(
                            minimumSize:
                                const WidgetStatePropertyAll(Size(192, 50)),
                            backgroundColor: WidgetStatePropertyAll(white),
                            foregroundColor: WidgetStatePropertyAll(black)),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (userDetailsModel != null) {
                              editProfile(context);
                            } else {
                              submitUserDetails(context);
                            }
                          }
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
    String? profilePic;
    File? image;

    if (imagetoPost != null) {
      image = File(imagetoPost!.path);

      profilePic =
          await UserDatabaseFunctions().uploadProfilePhotoToFirebase(image);
    }
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
    final skills = skillsNotifier.value;
    final services = servicesNotifier.value;

    final userDetails = UserDetailsModel(
        profilePhoto: profilePic,
        id: FirebaseAuth.instance.currentUser!.uid,
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
        follow: [],
        posts: [],
        description: description,
        jobTitle: jobTitle);
    storage.buildProflieSaving(userdetailsmodel: userDetails);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const BottomNav()));
  }

  editProfile(context) {
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
    final skills = skillsNotifier.value;
    final services = servicesNotifier.value;

    final userDetails = UserDetailsModel(
        profilePhoto: userDetailsModel!.profilePhoto,
        id: FirebaseAuth.instance.currentUser!.uid,
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
        follow: userDetailsModel!.follow,
        posts: userDetailsModel!.posts,
        description: description,
        jobTitle: jobTitle);
    storage.editDetailsOfTheUser(userdetailsmodel: userDetails);
    Navigator.of(context).pop();
  }
}
