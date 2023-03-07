// ignore_for_file: prefer_typing_uninitialized_variables

part of 'scan_bloc.dart';

@immutable
abstract class ScanEvent {}
class ScanSend extends ScanEvent {
  final id;
  ScanSend({this.id});
}
