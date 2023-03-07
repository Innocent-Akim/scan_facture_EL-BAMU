// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:appscan/src/models/ModelAuthentific.dart';
import 'package:appscan/src/pages/auth/Login.dart';
import 'package:appscan/src/pages/home/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api/Api.dart';
import '../utils/UtilsColot.dart';

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

  // @override
  // onInit() async {
  //   fetch();
  //   super.onInit();
  //   ever(isLogged, fireRoute);
  //   // isLogged.value = await Preferences.hasToken();
  // }

  fireRoute(logged) {
    if (logged) {
      Get.off(const Home());
    } else {
      Get.off(const Login());
    }
  }

  static Widget errorMessage(context, {String? message}) {
    return Flushbar(
      title: "Attention",
      message: message,
      duration: const Duration(seconds: 3),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: const Color.fromARGB(255, 246, 91, 19),
      icon: const Icon(
        Icons.error_outline,
        size: 50,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.red,
      // ignore: prefer_const_literals_to_create_immutables
      boxShadows: [
        const BoxShadow(
            color: color_google_dark, offset: Offset(0.0, 2.0), blurRadius: 3.0)
      ],
      backgroundGradient: const LinearGradient(colors: [
        Color.fromARGB(0, 5, 79, 113),
        Color.fromARGB(0, 202, 84, 84)
      ]),
      isDismissible: false,
    )..show(context);
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
