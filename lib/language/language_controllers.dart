
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends GetxController {
  String locale = 'en';
  bool isSwitched = false;

  late SharedPreferences prefs;

  @override
  void onInit() {
    super.onInit();
    initPrefs();  // Initialize SharedPreferences and load the saved settings
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    getLocale();  // Load the saved locale and set the switch state
  }

  void getLocale() {
    String? lang = prefs.getString('language');
    if (lang == null) {
      lang = 'en';
      prefs.setString('language', lang);
    }

    // Set the switch state based on the saved language
    isSwitched = (lang == 'bn');  // Assuming 'bn' is the code for Bengali
    locale = lang;

    Locale l = Locale(lang);
    Get.updateLocale(l);
    update(["0"]);  // Update the UI
  }

  void updateLocale(String lang) async {
    locale = lang;
    await prefs.setString('language', lang);
    Locale l = Locale(lang);
    Get.updateLocale(l);
    update(["0"]);  // Update the UI
  }

  void toggleSwitch(bool value) {
    isSwitched = value;
    String lang = value ? 'bn' : 'en';  // Update the language based on the switch
    updateLocale(lang);
    prefs.setBool('isSwitched', value);
  }

}

