import 'dart:convert';

import 'package:appscan/src/models/ModelAuthentific.dart';
import 'package:appscan/src/pages/auth/Login.dart';
import 'package:appscan/src/pages/home/Home.dart';
import 'package:get/get.dart';

import '../api/Api.dart';

class Controller extends GetxController {
  var isloadings = true.obs;
  var listUser = [].obs;
 static var tokenUser="".obs;
  Future<void> fetch() async {
    try {
      isloadings(true);
      var data = await Api.dataGet(endPoint: 'sortie/svalidatiion');
    }finally {
        isloadings(false);
    }
  }
var isLogged = false.obs;

@override
onInit() async {
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

Future<void> login({body}) async {
    try {
      isloadings(true);
      print(isloadings);
      final response = await Api.dataPost(body: body, endPoint: 'login');
      if (response!.statusCode == 200) {
        var resultat = modelAuthentificFromJson(response.body).data;
        // Rx(listUser.value = resultat.identification);
       
      }
    } finally {
      isloadings(false);
        print(isloadings);
    }
  }
}
