import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

class CitySelect extends StatefulWidget {
  const CitySelect({super.key});

  @override
  State<CitySelect> createState() => _CitySelectState();
}

class _CitySelectState extends State<CitySelect> {
  String countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String? address = "";

  @override
  Widget build(BuildContext context) {
    return CSCPicker(
      showCities: true,
      showStates: true,
    
      // flagState: CountryFlag.DISABLE,
      dropdownDecoration: BoxDecoration(
        
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: white,
          border: Border.all(color: Colors.grey.shade300, width: 1)),
      countrySearchPlaceholder: "Country" ,
      stateSearchPlaceholder: "State",
      citySearchPlaceholder: "City",

      ///labels for dropdown
      countryDropdownLabel: "Country",
      stateDropdownLabel: "State",
      cityDropdownLabel: "City",

       
      
              onCountryChanged: (value) {
      			setState(() {
      					countryValue = value;
      				});
                  },
                  onStateChanged:(value) {
                      setState(() {
      					stateValue = value ??'';
      				});
                  },
                  onCityChanged:(value) {
                  setState(() {
                      cityValue = value ?? '';
      			});
      		},
          
    );
  }
}