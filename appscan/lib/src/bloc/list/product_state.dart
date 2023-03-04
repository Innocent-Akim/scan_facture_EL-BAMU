// ignore_for_file: prefer_typing_uninitialized_variables

part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class ProductLoaded extends ProductState {
  final data;
  ProductLoaded(this.data);
}
class ProductError extends ProductState {}
class ProductEmpty extends ProductState {}
