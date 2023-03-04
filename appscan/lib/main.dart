import 'package:appscan/src/pages/auth/Login.dart';
import 'package:appscan/src/utils/App.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  return runApp(const App());
}
