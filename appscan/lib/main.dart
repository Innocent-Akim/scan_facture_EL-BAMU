import 'package:appscan/src/pages/auth/Login.dart';
import 'package:flutter/material.dart';

void main()=>runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
return const MaterialApp(
  debugShowCheckedModeBanner: false,
  themeMode: ThemeMode.system,
  title: '',
  home: Login(),
);
  }
}