import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

class CitySelect extends StatefulWidget {
  final TextEditingController countryController;
  final TextEditingController stateController;
  final TextEditingController cityController;
  const CitySelect({super.key, required this.countryController, required this.stateController, required this.cityController});

  @override
  State<CitySelect> createState() => _CitySelectState();
}

class _CitySelectState extends State<CitySelect> {
  String countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String? address = "";
  late TextEditingController countryController;
  late TextEditingController stateController;
  late TextEditingController cityController;
  @override
  void initState() {
    countryController=widget.countryController;
    cityController=widget.cityController;
    stateController=widget.stateController;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return CSCPicker(
      selectedItemStyle:  TextStyle(color: black),
      // style: TextStyle(color: black),
      showCities: true,
      showStates: true,

      // flagState: CountryFlag.DISABLE,
      dropdownDecoration: BoxDecoration(
        
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: white,
          border: Border.all(color: white, width: 6)),
      countrySearchPlaceholder: "Search Country",
      stateSearchPlaceholder: "Search State",
      citySearchPlaceholder: "Search City",

      disabledDropdownDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color:white,
          //  Colors.grey.shade300,
          border: Border.all(color: white, width: 6)),

      ///labels for dropdown
      countryDropdownLabel: "Country",
      stateDropdownLabel: "State",
      cityDropdownLabel: "City",

      onCountryChanged: (value) {
        setState(() {
          countryController.text=value;
          countryValue = value;
        });
      },
      onStateChanged: (value) {
        setState(() {
          stateValue = value ?? '';
          stateController.text=value??'';
        });
      },
      onCityChanged: (value) {
        setState(() {
          cityValue = value ?? '';
          cityController.text=value?? '';
        });
      },
    );
  }
}
