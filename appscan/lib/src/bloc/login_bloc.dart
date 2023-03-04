// ignore_for_file: unrelated_type_equality_checks

import 'package:appscan/src/controller/Controller.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Controller controller = Get.put(Controller());
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      on<LoginSign>(_login);
    });
  }
  Future<void> _login(LoginSign event, Emitter<LoginState> emit) async {
    try {
      emit(LoginInitial());
      controller.login(
          body: {'username': event.password, 'password': event.username});
      emit(LoginLoading());
      if (controller.isConnected == 200) {
        emit(LoginSucces());
      }
    } catch (e) {
      emit(LoginFailed(msg: e.toString()));
    }
  }
}
