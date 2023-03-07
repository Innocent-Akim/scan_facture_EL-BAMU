import 'dart:async';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class Api {
  static var box = GetStorage();
  static var apiUrl = "https://api.farida.tech/elbamu/api/";
  
  static Future<http.Response?> dataPost({body, endPoint}) async {
    try {
      final response = await http.post(Uri.parse('${apiUrl}${endPoint}'),
          body: body,
          headers: {'Authorization': 'Bearer ${box.read("token")}'});
      return response;
    } catch (ex) {
      print(ex.toString());
    }
    return null;
  }

   static Future<http.Response?> dataPut({body, endPoint}) async {
    try {
      final response = await http.put(Uri.parse('${apiUrl}${endPoint}'),
          body: body,
          headers: {'Authorization': 'Bearer ${box.read("token")}'});
      return response;
    } catch (ex) {
      print(ex.toString());
    }
    return null;
  }
     static Future<http.Response?> dataDelete({body, endPoint}) async {
    try {

      final response = await http.delete(Uri.parse('${apiUrl}${endPoint}'),
          body: body,
          headers: {'Authorization': 'Bearer ${box.read("token")}'});
      return response;
    } catch (ex) {
      print(ex.toString());
    }
    return null;
  }
  static Future<http.Response?> dataGet({endPoint}) async {
    try {
      var response = await http.get(Uri.parse('${apiUrl}${endPoint}'),
          headers: {'Authorization': 'Bearer ${box.read("token")}'});
      return response;
    } catch (ex) {
      print(ex.toString());
    }
    return null;
  }
}
