// ignore_for_file: prefer_const_constructors
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flash/flash.dart';
import 'package:kotakpostoit/models/models.dart';
import 'package:kotakpostoit/pages/spashpage.dart';
import 'package:http/http.dart' as http;


void main() {

  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, _) {
        var child = _!;
        final navigatorKey = child.key as GlobalKey<NavigatorState>;
        child = Toast(child: child, navigatorKey: navigatorKey);
        child = FlashTheme(
          child: child,
          flashDialogTheme: const FlashDialogThemeData(),
        );
        return child;
      },
      home: SplashPage(),
    );
  }
}


