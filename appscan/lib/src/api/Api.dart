import 'dart:async';
import 'dart:convert';
import 'package:appscan/src/controller/Controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Api {
  static var apiUrl = "https://api.farida.tech/elbamu/api/";
  static Future<http.Response?> dataPost({body, endPoint}) async {
    try {
     final response =
          await http.post(Uri.parse('${apiUrl}${endPoint}'), body: body,headers:{
            'Authorization':'Bearer ${token}'
          });
      return response;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<http.Response?> dataGet({endPoint}) async {
    try {
      var response = await http.get(Uri.parse('${apiUrl}${endPoint}'),headers: {
        'Authorization':'Bearer ${token}'
      });
    return response;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
