import 'dart:convert';

import 'package:appscan/src/models/ModelAuthentific.dart';
import 'package:appscan/src/pages/auth/Login.dart';
import 'package:appscan/src/pages/home/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api/Api.dart';

class Controller extends GetxController {
  
  var box = GetStorage();
  var username = Rx(TextEditingController());
  var password = TextEditingController().obs;
  var bloc;
  var isloadings = false.obs;
  var isConnected = 0.obs;
  var listUser = [].obs;
  static var tokenUser = "".obs;
  Future<void> fetch() async {
    try {
      isloadings(true);
      var response = await Api.dataGet(endPoint: 'sortie/svalidation');
      var result = await jsonDecode(response!.body);
      print(result);
    } finally {
      isloadings(false);
    }
  }

  var isLogged = false.obs;

  @override
  onInit() async {
    fetch();
    super.onInit();
    ever(isLogged, fireRoute);
    // isLogged.value = await Preferences.hasToken();
  }

  fireRoute(logged) {
    if (logged) {
      Get.off(const Home());
    } else {
      Get.off(const Login());
    }
  }

  Future<bool?> login({body}) async {
    try {
      isloadings(true);
      final response = await Api.dataPost(body: body, endPoint: 'login');
      if (response!.statusCode == 200) {
        var resultat = authentificationFromJson(response.body);
        box.write("token", resultat.token);

        isConnected(response.statusCode);
        isloadings(false);
        return true;
        // Rx(listUser.value = resultat.identification);
      }
    } finally {
      isloadings(false);
      print(isloadings);
    }
    return null;
  }
}
