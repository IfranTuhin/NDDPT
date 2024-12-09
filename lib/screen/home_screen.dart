import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:nddpt/language/language_controllers.dart';
import 'package:nddpt/screen/appointment_screen.dart';
import 'package:nddpt/screen/login_screen.dart';
import 'package:nddpt/widget/custom_toggle.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isConnectedToInternet = false;
  StreamSubscription? _internetConnectionStreamSubscription;

  @override
  void initState() {
    super.initState();

    _internetConnectionStreamSubscription = InternetConnection().onStatusChange.listen((event) {

      log('Internet Status: $event');
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            isConnectedToInternet = true;
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            isConnectedToInternet = false;
          });
          break;
        default:
          setState(() {
            isConnectedToInternet = false;
          });
          break;
      }

    },);
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

// -------- Open Mobile Wifi Settings Start ---------
  static const platform = MethodChannel('com.example.nddpt/mobile_data');

  Future<void> _openMobileDataSettings() async {
    try {
      await platform.invokeMethod('openMobileDataSettings');
    } on PlatformException catch (e) {
      log("Failed to open mobile data settings: '${e.message}'.");
    }
  }
  // ------- Open Mobile Wifi Settings End ---------


  @override
  Widget build(BuildContext context) {

    // Screen size
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('NDDPT',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),),
        backgroundColor: Colors.orange,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GetBuilder<LocaleController>(
              id: "0",
              builder: (localeController) {
                return CustomToggle(buttontext: 'Language'.tr, initialSwitchState: localeController.isSwitched, onToggle: (bool value) {
                  localeController.toggleSwitch(value);
                }, imageFirst: 'assets/icon/en.png', imageSecond: 'assets/icon/bn.png');
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: isConnectedToInternet ? Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [



              Image.asset('assets/logo/app_logo1.png', height: 280, width: 280),

              const SizedBox(height: 150),

              // Appointment button
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AppointmentScreen(),
                      ));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange,
                  ),
                  child: Text('Appointment'.tr,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),

              // Login button
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange,
                  ),
                  child: Text('Login'.tr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
                ),
              ),


            ],
          ) : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Icon(Icons.wifi_off, size: 80, color: Colors.black54,),
                const SizedBox(height: 10),
                Text('Your Internet Connection is Off !'.tr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),

                const SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    _openMobileDataSettings();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange,
                    ),
                    child: Text('On Internet Connection'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
