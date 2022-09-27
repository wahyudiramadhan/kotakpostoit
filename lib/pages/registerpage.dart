// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:flash/src/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kotakpostoit/models/models.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userController = TextEditingController();
    var namaController = TextEditingController();
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "REGISTER",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "POS BOX",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54),
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    controller: userController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: namaController,
                    decoration: InputDecoration(
                      hintText: 'Nama Lengkap',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passController,
                    obscureText: true,
                    decoration: InputDecoration(
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
                                  borderRadius: BorderRadius.circular(30)),
                              padding: EdgeInsets.all(2)),
                          onPressed: () {
                            if (userController.text.isEmpty &&
                                namaController.text.isEmpty &&
                                passController.text.isEmpty) {
                              // print("data tidak boleh kosong");
                              context.showToast('Data tidak boleh kosong');
                            } else {
                              Register.reg(userController.text,
                                  namaController.text, passController.text);
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 100,
                                    color: Colors.grey,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text('Daftar Berhasil ?'),
                                          ElevatedButton(
                                              child: const Text('Kembali'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Get.back();
                                              })
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: Text("Register"),
                        ),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Sudah Punya Akun ? masuk",
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
