// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flash/src/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kotakpostoit/models/models.dart';
import 'package:kotakpostoit/pages/registerpage.dart';


class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Login dataRespons = Login();

  @override
  Widget build(BuildContext context) {
    var userController = TextEditingController();
    var passController = TextEditingController();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade300,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "POS BOX",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    controller: userController,
                    decoration: InputDecoration(
                      icon: new Icon(Icons.person, color: Color(0xff224597)),
                      hintText: 'Username',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passController,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: new Icon(Icons.lock, color: Color(0xff224597)),
                      hintText: 'Password',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              padding: EdgeInsets.all(2)),
                          onPressed: () {
                            if (userController.text.isEmpty &&
                                passController.text.isEmpty) {
                              context.showToast(
                                  'username dan password tidak boleh kosong');
                            } else {
                              Login.connect(
                                  userController.text, passController.text);
                            }
                          },
                          child: Text("MASUK"),
                        ),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.to(() => RegisterPage());
                          },
                          child: Text("Belum Punya Akun? Register ",
                              style: TextStyle(color: Colors.white)),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              width: 0,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
