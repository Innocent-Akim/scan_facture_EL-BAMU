import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../pages/auth/Login.dart';
import '../pages/home/Home.dart';
import 'UtilsColot.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: custom_white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return GetMaterialApp(
      // theme:AppFont. _lightTheme,
      darkTheme: AppFont.darkTheme,
      initialRoute: '/',
      defaultTransition: Transition.native,

      getPages: [
        GetPage(name: '/', page: () => const Login()),
        GetPage(name: '/home', page: () => const Home()),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        dividerTheme: const DividerThemeData(space: 0),
        fontFamily: AppFont.primaryFont,
      ).copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      home: const Login(),
    );
  }
}
