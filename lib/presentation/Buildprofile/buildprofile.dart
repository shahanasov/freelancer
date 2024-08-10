import 'package:flutter/material.dart';
import 'package:freelance/presentation/Buildprofile/widgets/addskills.dart';
import 'package:freelance/presentation/Buildprofile/widgets/citypick.dart';
import 'package:freelance/presentation/Buildprofile/widgets/dob.dart';
import 'package:freelance/presentation/Buildprofile/widgets/dropdown.dart';
import 'package:freelance/presentation/bottom/bottomnav.dart';
import 'package:freelance/theme/color.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class BuildProfile extends StatelessWidget {
  const BuildProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
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
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: white)),
                        focusColor: white,
                        filled: true,
                        fillColor: white,
                        hintText: 'First Name',
                        hintStyle: TextStyle(color: black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        hintText: 'Last Name',
                        hintStyle: TextStyle(color: black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  IntlPhoneField(
                    initialCountryCode: 'IN',
                    // languageCode: 'IN',
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(color: black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //  DOBWidget()
                  const GenderDropdown(),
                  const SizedBox(
                    height: 10,
                  ),
                  const CitySelect(),
                  const SizedBox(
                    height: 10,
                  ),

                  const DOBWidget(),
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const BottomNav()));
                      },
                      child: const Text('Submit')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
