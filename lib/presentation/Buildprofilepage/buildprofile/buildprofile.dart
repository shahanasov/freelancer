import 'package:flutter/material.dart';
import 'package:freelance/db/functions/firebaseauth.dart';
import 'package:freelance/db/model/userdetails.dart';
import 'package:freelance/presentation/Buildprofilepage/widgets/addskills.dart';
import 'package:freelance/presentation/Buildprofilepage/widgets/citypick.dart';
import 'package:freelance/presentation/Buildprofilepage/widgets/dob.dart';
import 'package:freelance/presentation/Buildprofilepage/widgets/dropdown.dart';
import 'package:freelance/presentation/bottomnavigation/bottomnav.dart';
import 'package:freelance/theme/color.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class BuildProfile extends StatelessWidget {
  BuildProfile({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController skillController = TextEditingController();
  TextEditingController servicesController = TextEditingController();
  Authentication auth = Authentication();

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
                    InkWell(
                      onTap: () {},
                      child: Stack(alignment: Alignment.bottomRight, children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CircleAvatar(
                            radius: 50,
                            child: Image.asset(
                              "assets/images/profilenew.jpg",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.add_a_photo_outlined,
                          color: white,
                        )
                      ]),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      style: TextStyle(color: black),
                      controller: firstNameController,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: white)),
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
                     DOBWidget(dob: dobController,),
                    const SizedBox(
                      height: 10,
                    ),
                    const GenderDropdown(),
                    const SizedBox(
                      height: 10,
                    ),
                    const CitySelect(),
                    const SizedBox(
                      height: 10,
                    ),
                    const SkillAdding(
                      hintText: 'Enter a skill',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SkillAdding(
                      hintText: 'Enter Your Services',
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
    final phone = int.parse(phoneNumberController.text.trim());
    final gender = genderController.text.trim();
    final country = countryController.text.trim();
    final state = stateController.text.trim();
    final city = cityController.text.trim();
    final dob = dobController.text.trim();
    final skills = skillController.text.trim();
    final services = servicesController.text.trim();

    final userDetails = UserDetailsModel(
      // id:'',
        firstName: firstName,
        lastName: secondName,
        phone: phone,
        gender: gender,
        country: country,
        state: state,
        city: city,
        dob: dob,
        skills: [skills],
        services: [services]);
    auth.buildProflieSaving( userdetailsmodel: userDetails);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const BottomNav()));
  }
}
