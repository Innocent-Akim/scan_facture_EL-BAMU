// ignore_for_file: unused_local_variable

import 'package:appscan/src/controller/Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import '../../custom/Field.dart';
import '../../utils/UtilsColot.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StateBody();
  }
}

class _StateBody extends State<Login> {
  Controller controller=Get.put(Controller());
  bool status = true;
  bool setSession = false;
  bool getStatu = false;
  var username = TextEditingController();
  var password = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var focus = FocusScope.of(context);
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: <Widget>[
          Positioned(
            child: Container(
              height: size.height,
              foregroundDecoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(87, 15, 134, 198),
                    Colors.transparent
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.100, .3],
                  tileMode: TileMode.repeated,
                ),
              ),
            ),
          ),
          Positioned(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Container(
                      width: size.width,
                      height: size.height / 1.5,
                      decoration: const BoxDecoration(
                        // color: custom_blue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: SizedBox(
                          width: double.infinity,
                          // height: size.height,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: Image.asset("assets/img/elbamu.png",
                                        width: size.width * .7),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      SizedBox(height: 14),
                                      // Text(
                                      //   "Authentification",
                                      //   style: TextStyle(
                                      //     fontSize: 25,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  buildTextField(
                                      lineIcons: const Icon(LineIcons.user),
                                      name: "Nom d'utilisateur",
                                      controller: username),
                                  buildTextField(
                                    lineIcons: const Icon(LineIcons.lock),
                                    obscureText: status,
                                    ispassword: true,
                                    name: "Mot de passe",
                                    status: status,
                                    iconButton: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          status = !status;
                                        });
                                      },
                                      icon: status
                                          ? const Icon(LineIcons.eyeSlash,
                                              size: 20)
                                          : const Icon(LineIcons.eye, size: 20),
                                    ),
                                    controller: password,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                              activeColor: AppFont.blueColor,
                                              value: setSession,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  setSession = value!;
                                                });
                                              }),
                                          const Text(
                                              "Gardez votre session ouverte",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ))
                                        ]),
                                  ),
                                  const SizedBox(height: 10),
                                  buildButton(
                                      color: AppFont.blueColor,
                                      text: "Connexion",
                                      onPressed: () {
                                        setState(() {

                                          controller.login(body:{
                                            'username':'Akim',
                                            'password':'3619'
                                          });
                                          Get.toNamed('/home');
                                        });
                                      }),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildButton({VoidCallback? onPressed, var text, Color? color}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Center(
          child: Text(
            "$text",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
