import 'package:get/get.dart';

class WorldLanguage extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      "Appointment" : "Appointment",
      "Login" : "Login",
      "Your Internet Connection is Off !" : "Your Internet Connection is Off !",
      "On Internet Connection" : "On Internet Connection",
    },


    'bn_BN': {
      "Appointment" : "নিয়োগ",
      "Login" : "লগইন করুন",
      "Your Internet Connection is Off !" : "আপনার ইন্টারনেট সংযোগ বন্ধ!",
      "On Internet Connection" : "ইন্টারনেট সংযোগে",
    }
  };
}