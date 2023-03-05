// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:appscan/src/api/Api.dart';
import 'package:appscan/src/controller/Controller.dart';
import 'package:appscan/src/models/ModelAuthentific.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Controller controller = Get.put(Controller());
  var box = GetStorage();
  LoginBloc() : super(LoginInitial()) {
    on<LoginSign>(_login);
  }

  Future<void> _login(LoginSign event, Emitter<LoginState> emit) async {
    try {
      emit(LoginInitial());
      final response = await Api.dataPost(
          body: {'username': event.username, 'password': event.password},
          endPoint: 'login');
      var data = authentificationFromJson(response!.body);
      emit(LoginLoading());
      print(data);
      if (response.statusCode == 200) {
        box.write("token", data.token);
        emit(LoginSucces(data: data));
      } else {
        emit(LoginFailed(data: data));
      }
    } catch (e) {
      print("object");
      emit(LoginERROR());
    }
  }
}
