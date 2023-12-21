import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class MobileController extends ChangeNotifier {
    final TextEditingController numbercontroller = TextEditingController();
  Country SelectedCountry = Country(
      phoneCode: '91',
      countryCode: 'IN',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "india",
      example: "india",
      displayName: "india",
      displayNameNoCountryCode: "IN",
      e164Key: '');

  selectChanges(value) {
    SelectedCountry = value;
    notifyListeners();
  }
}
