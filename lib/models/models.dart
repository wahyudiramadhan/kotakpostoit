// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kotakpostoit/pages/spashpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

var server = "http://kotakposiot.online";

class Login {
  var nama, response_status;
  Login({this.response_status, this.nama});

  static Future<Login> connect(String username, String password) async {
    Uri url = Uri.parse(server + '/login.php');

    var hasilResponse = await http.post(
      url,
      body: {"username": username, "password": password},
    );
    var data = json.decode(hasilResponse.body);
    // print(data);
    if (data["response_status"] == "OK") {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("nama", data["data"]["nama"]);
      Get.offAll(() => SplashPage());
    } else {
      print("gagal");
    }
    return Login(
      response_status: "gagal",
    );
  }
}

class Register {
  var response_mesage;
  Register({this.response_mesage});
  static Future<Register> reg(
      String username, String nama, String password) async {
    Uri url = Uri.parse(server + '/regist.php');
    var hasilResponse = await http.post(
      url,
      body: {"username": username, "nama": nama, "password": password},
    );
    var data = json.decode(hasilResponse.body);
    return Register(
      response_mesage: data['response_mesage'],
    );
  }
}

class AddItems {
  var response_mesage;
  AddItems({this.response_mesage});
  static Future<AddItems> add(String nama, String resi) async {
    Uri url = Uri.parse(server + '/add_data.php');
    // print(nama);
    var hasilResponse = await http
        .post(url, body: {"nama": nama, "resi": resi, "username": finalnama});
    // print(hasilResponse.body);
    var data = json.decode(hasilResponse.body);

    return AddItems(
      response_mesage: data['response_mesage'],
    );
  }
}

// class StatusKotak {
//   var response_mesage;
//   StatusKotak({this.response_mesage});
//   static Future<AddItems> get(String nama, String resi) async {
//     Uri url = Uri.parse(server + '/getStatus.php');
//     // print(nama);
//     var hasilResponse = await http
//         .post(url, body: {"nama": nama, "resi": resi, "username": finalnama});
//     // print(hasilResponse.body);
//     var data = json.decode(hasilResponse.body);

//     return AddItems(
//       response_mesage: data['response_mesage'],
//     );
//   }
// }
