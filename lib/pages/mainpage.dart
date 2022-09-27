// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:kotakpostoit/models/models.dart';
import 'package:kotakpostoit/pages/adddatapage.dart';
import 'package:kotakpostoit/pages/controlpage.dart';
import 'package:kotakpostoit/pages/loginpage.dart';
import 'package:kotakpostoit/pages/reportpage.dart';
import 'package:kotakpostoit/pages/spashpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Map data;
  late List userdata = [];
  late String Respon;
  String statusKotak = "";

  Future getData() async {
    Uri url = Uri.parse(server + "/list.php?username=" + finalnama!);
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    if (this.mounted) {
      setState(() {
        userdata = data["data"];
      });
    }
  }

  Future DelData(String resi) async {
    print(resi);
    Uri url = Uri.parse(server + "/hapus.php?resi=" + resi);
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    // print(data);
    getData();
  }

  Future getStatus() async {
    Uri url = Uri.parse(server + "/getStatus.php");
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    print(url);
    // print(data);
    setState(() {
      statusKotak = data["data"][0]["status"] == "1" ? "Terbuka" : "Tertutup";
      if (data["data"][0]["notif"] == "1") {
        _showNotification();
      }
    });
  }

  late FlutterLocalNotificationsPlugin localNotification;

  @override
  void initState() {
    super.initState();
    var androidInitialize =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iosInitialize);
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);
    new Timer.periodic(Duration(milliseconds: 2000), (timer) {
      getData();
      getStatus();
    });
  }

  void _showNotification() async {
    print("notif");
    var androidDetails = new AndroidNotificationDetails(
      "0",
      "channelName",
      // "channelDescription",
      importance: Importance.high,
    );
    var iosDetail = new IOSNotificationDetails();
    var generalNotificationDetails = new NotificationDetails(
      android: androidDetails,
      iOS: iosDetail,
    );
    await localNotification.show(
      0,
      "POS BOX",
      "PAKET TELAH SAMPAI",
      generalNotificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade400,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Pos IoT"),
            ],
          ),
        ),
        drawer: menuNav(),
        body: Column(
          children: <Widget>[
            listTitle(),
            Expanded(
              child: listData(),
            )
          ],
        ),
        floatingActionButton: btnAdd());
  }

  Padding listTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          cardStatus(),
          SizedBox(height: 10),
          Text(
            'Daftar paket',
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }

  Padding cardStatus() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff334192), Color(0xff3be9ff)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Status Kotak ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "${statusKotak}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView listData() {
    return ListView.builder(
      itemCount: userdata == null ? 0 : userdata.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: userdata[index]["akses"] == '1'
                    ? Colors.green
                    : Colors.blueGrey,
                elevation: 16,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Wrap(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      margin: EdgeInsets.only(left: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text("Resi : ${userdata[index]["resi"]}",
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.start),
                                      SizedBox(height: 5),
                                      Text(
                                          "Paket :  ${userdata[index]["nama"]}",
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.start),
                                      SizedBox(height: 10),
                                      Text(
                                          "Status Paket :  ${userdata[index]["status_paket"] != "" ? "${userdata[index]["status_paket"]} " : "Dalam Perjalanan"}",
                                          style: TextStyle(fontSize: 14),
                                          textAlign: TextAlign.start),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 200,
                                          color: Colors.black87,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  'Anda yakin Ingin menghapus ${userdata[index]["nama"]} ?',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                ElevatedButton(
                                                  child: const Text('Hapus'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    DelData(
                                                        "${userdata[index]["resi"]}");
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(Icons.delete, size: 25),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class btnAdd extends StatelessWidget {
  const btnAdd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.to(() => AddDataPage());
      },
      backgroundColor: Colors.indigo.shade600,
      child: Text("+"),
    );
  }
}

class menuNav extends StatelessWidget {
  const menuNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.blue.shade700,
              ],
            )),
            accountName: Text("Hai ${finalnama}"),
            accountEmail: Text(""),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.teal,
              child: Text(
                "I",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: Text("Menu Utama"),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => MainPage());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.adjust,
              color: Colors.blue,
            ),
            title: Text("Control"),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => controlPage());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.report,
              color: Colors.blue,
            ),
            title: Text("log Report"),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => report_page());
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.blue,
            ),
            title: Text("Log Out"),
            onTap: () async {
              Navigator.pop(context);
              final SharedPreferences sharedpreference =
                  await SharedPreferences.getInstance();
              sharedpreference.remove('nama');
              Duration(seconds: 5);
              Get.offAll(() => LoginPage());
            },
          ),
        ],
      ),
    );
  }
}
