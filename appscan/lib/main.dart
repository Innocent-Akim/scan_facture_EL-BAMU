import 'dart:io';
import 'package:appscan/src/utils/App.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'src/api/MyHttpOverrides.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  return runApp(const App());
}
