import 'dart:convert';

import 'package:appscan/src/api/Api.dart';
import 'package:appscan/src/models/ListFacture.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductFind>(_find);
  }
  Future<void> _find(ProductEvent event, Emitter<ProductState> emit) async {
    try {
      emit(ProductInitial());
      var response = await Api.dataGet(endPoint: 'sortie/svalidation');
      Welcome data = welcomeFromJson(response!.body);
      emit(ProductLoading());
      if (data.data!.isNotEmpty) {
        emit(ProductLoaded(data.data));
      } else {
        emit(ProductEmpty());
      }
    } catch (e) {
      emit(ProductError());
    }
  }
}
