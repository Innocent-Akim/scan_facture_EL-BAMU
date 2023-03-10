// ignore_for_file: unused_local_variable, avoid_single_cascade_in_expression_statements, prefer_const_constructors

import 'package:another_flushbar/flushbar.dart';
import 'package:appscan/src/controller/Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_icons/line_icons.dart';
import '../../bloc/login_bloc.dart';
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
  Controller controller = Get.put(Controller());

  bool status = true;
  bool inProgress = false;
  bool setSession = false;
  bool getStatu = false;
  LoginBloc? bloc;
  var username = TextEditingController();
  var password = TextEditingController();
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<LoginBloc>(context);
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
                    Color.fromARGB(86, 28, 150, 215),
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
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginInitial) {
                  focus.requestFocus(FocusNode());
                  setState(() {
                    inProgress = true;
                  });
                }
                if (state is LoginLoading) {
                  setState(() {
                    inProgress = true;
                  });
                }
                if (state is LoginERROR) {
                  setState(() {
                    inProgress = false;
                    // EasyLoading.dismiss(animation: true);
                    Controller.errorMessage(context,
                        message:
                            "Mot depasse ou le nom d'utilisateur est incorrect");});
                }
                if (state is LoginFailed) {
                  setState(() {
                    inProgress = false;
                    Controller.errorMessage(context, message: state.data.msg);
                  });
                }
                if (state is LoginSucces) {
                  setState(() {
                     inProgress = false;
                  });
                  Get.offAndToNamed("/home");
                }
              },
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
                                      child: Image.asset(
                                          "assets/img/elbamu.png",
                                          width: size.width * .7),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                            : const Icon(LineIcons.eye,
                                                size: 20),
                                      ),
                                      controller: password,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
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
                                        isprogross: inProgress,
                                        onPressed: () {
                                          setState(() {
                                            bloc?.add(LoginSign(
                                              password: password.text.trim(),
                                              username: username.text.trim(),
                                            ));
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
          ),
        ],
      ),
    );
  }

  buildButton(
      {VoidCallback? onPressed, var text, Color? color, isprogross = false}) {
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
          child: !isprogross
              ? Text(
                  "$text",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                )
              : const SpinKitCircle(
                  size: 30,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
