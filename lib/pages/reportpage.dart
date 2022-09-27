import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kotakpostoit/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kotakpostoit/pages/spashpage.dart';

class report_page extends StatefulWidget {
  report_page({Key? key}) : super(key: key);

  @override
  State<report_page> createState() => _report_pageState();
}

class _report_pageState extends State<report_page> {
  late Map data;
  late List userdata = [];

  Future getReport() async {
    Uri url = Uri.parse(server + "/report.php?username="+finalnama!);
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    print(url);
    if (this.mounted) {
      setState(() {
        setState(() {
          userdata = data["data"];
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer.periodic(Duration(milliseconds: 2000), (timer) {
      getReport();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laporan"),
      ),
      body: ListView.builder(
        itemCount: userdata == null ? 0 : userdata.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.task, color: Colors.black),
              title: Text("${userdata[index]["resi"]}"),
              subtitle: Text("${userdata[index]["waktu"]}"),
            ),
          );
        },
      ),
    );
  }
}
