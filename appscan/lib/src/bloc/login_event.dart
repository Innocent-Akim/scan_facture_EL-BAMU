// ignore_for_file: prefer_typing_uninitialized_variables

part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginSign extends LoginEvent {
  final username;
  final password;
  LoginSign({this.username, this.password});
  
}
