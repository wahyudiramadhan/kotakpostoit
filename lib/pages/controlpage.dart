import 'package:flutter/material.dart';
import 'package:kotakpostoit/pages/mainpage.dart';

class controlPage extends StatefulWidget {
  const controlPage({Key? key}) : super(key: key);

  @override
  State<controlPage> createState() => _controlPageState();
}

class _controlPageState extends State<controlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Pos Iot"),
          ],
        ),
      ),
      drawer: menuNav(),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Scan untuk buka",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black54,
                    fontFamily: "Helvetica",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          NetworkImage('http://kotakposiot.online/qrcode.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
