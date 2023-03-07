import 'package:appscan/src/bloc/list/product_bloc.dart';
import 'package:appscan/src/bloc/login_bloc.dart';
import 'package:appscan/src/bloc/scan/scan_bloc.dart';
import 'package:appscan/src/pages/data/ListData.dart';
import 'package:appscan/src/pages/scan/Scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<ProductBloc>(create: (context) => ProductBloc()),
        BlocProvider<ScanBloc>(create: (context) => ScanBloc()),
      ],
      child: GetMaterialApp(
        // theme:AppFont. _lightTheme,
        darkTheme: AppFont.darkTheme,
        // builder: EasyLoading.init(),
        initialRoute: '/',
        // defaultTransition: Transition.native,

        getPages: [
          GetPage(name: '/', page: () => const Login()),
          GetPage(name: '/home', page: () => const ListData()),
          GetPage(name: '/scan', page: () => const Scan()),
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
      ),
    );
  }
}
