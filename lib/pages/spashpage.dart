import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kotakpostoit/pages/loginpage.dart';
import 'package:kotakpostoit/pages/mainpage.dart';

import 'package:shared_preferences/shared_preferences.dart';

String? finalnama;

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState() {
    getValidation().whenComplete(() {
      Timer(Duration(seconds: 2),
          () => Get.offAll(() => finalnama == null ? LoginPage() : MainPage()));
    });
  }

  getValidation() async {
    final SharedPreferences sharedpreference =
        await SharedPreferences.getInstance();
    var obtainnama = sharedpreference.getString('nama');
    setState(() {
      finalnama = obtainnama;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg-splash.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
