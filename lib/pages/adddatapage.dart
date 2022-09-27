// ignore_for_file: prefer_const_constructors, unnecessary_new


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kotakpostoit/models/models.dart';
import 'package:kotakpostoit/pages/mainpage.dart';

class AddDataPage extends StatefulWidget {
  const AddDataPage({Key? key}) : super(key: key);

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  @override
  Widget build(BuildContext context) {

    var namaController = TextEditingController();
    var resiController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Paket "),
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              TextField(
                controller: namaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  label: Text('Judul'),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: resiController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  label: Text('Resi'),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        if (namaController.text.isEmpty &&
                            resiController.text.isEmpty) {
                          // print("silahkan masukan data");
                        } else {
                          AddItems.add(namaController.text, resiController.text)
                              .then(
                            (value) {
                              setState(() {
                                Get.to(() => MainPage());
                              });
                            },
                          );
                        }
                      },
                      child: Text("+ Tambah"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
