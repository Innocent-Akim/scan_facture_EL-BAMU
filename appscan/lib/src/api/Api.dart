import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class Api extends GetxController{
static var apiUrl="https://api.farida.tech/elbamu/api/";

 static Future<http.Response?> dataPost({body,endPoint})async{
  try{
    http.Response response = await http.post(Uri.parse('${apiUrl}${endPoint}'),body: body);
    return response;
  }catch(e){}
  return null;
}

static Future<http.Response?> dataGet({endPoint})async{
  try{
    var response = await http.get(Uri.parse('${apiUrl}${endPoint}'));
    return response;
  }catch(e){}
  return null;
}
}