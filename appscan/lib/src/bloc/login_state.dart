// ignore_for_file: prefer_typing_uninitialized_variables

part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSucces extends LoginState {
  final data;

  LoginSucces({this.data});
}

class LoginFailed extends LoginState {
  final data;
  LoginFailed({this.data});
}



class LoginERROR extends LoginState {}