// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  border: OutlineInputBorder(),
                  hintText: 'name',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  border: OutlineInputBorder(),
                  hintText: 'resi',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  border: OutlineInputBorder(),
                  hintText: 'status',
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("UPDATE"),
                  ),
                  SizedBox(width: 25),
                  ElevatedButton(onPressed: () {}, child: Text("DELETE")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
