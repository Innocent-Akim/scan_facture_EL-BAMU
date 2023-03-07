import 'package:appscan/src/api/Api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  ScanBloc() : super(ScanInitial()) {
    on<ScanSend>(_scan);
  }
  Future<void> _scan(ScanSend event, Emitter<ScanState> emit) async {
    try {
      emit(ScanInitial());
      var response =
          await Api.dataPost(body: {'id': event.id}, endPoint: 'sortie/scan');
      emit(ScanLoading());
      if (response!.statusCode == 200) {
        emit(ScanSucces());
      } else {
        emit(ScanInvalid());
      }
    } catch (e) {
      emit(ScanError());
    }
  }
}
