part of 'scan_bloc.dart';

@immutable
abstract class ScanState {}

class ScanInitial extends ScanState {}

class ScanLoading extends ScanState {}

class ScanLoaded extends ScanState {}

class ScanSucces extends ScanState {}
class ScanInvalid extends ScanState {}


class ScanFailed extends ScanState {}

class ScanError extends ScanState {}

class ScanProgress extends ScanState {}
