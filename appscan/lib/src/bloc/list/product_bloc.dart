import 'dart:convert';

import 'package:appscan/src/api/Api.dart';
import 'package:appscan/src/models/ListFacture.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  // static List<ListFacture> payload=[];
  ProductBloc() : super(ProductInitial()) {
    on<ProductFind>(_find);
  }
  Future<void> _find(ProductFind event, Emitter<ProductState> emit) async {
    try {
     
      emit(ProductInitial());
      var response = await Api.dataGet(endPoint: 'sortie/svalidation');
      // print(response!.body);
      var resultat = listFactureFromJson(response!.body);
      emit(ProductLoading());
      if (resultat.data!.isNotEmpty) {
        emit(ProductLoaded(resultat.data));
      } else {
        emit(ProductEmpty());
      }
    } catch (e) {
      print(e.toString());
      emit(ProductError());
    }
  }
}
