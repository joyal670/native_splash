import 'package:alot/domain/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/products_list/product.dart';
import '../../domain/repository/repository.dart';

/* --------------------------------------------------------------------------------------  */
// state
class ProductsListBlocState {
  bool isLoading;
  List<Product> data;
  bool isError;

  ProductsListBlocState({
    required this.isLoading,
    required this.data,
    required this.isError,
  });

  factory ProductsListBlocState.initial() =>
      ProductsListBlocState(data: [], isError: false, isLoading: true);
}

/* --------------------------------------------------------------------------------------  */
// events
@immutable
abstract class ProductsListBlocEvent {}

class GetProductsList extends ProductsListBlocEvent {}

class OnClickItem extends ProductsListBlocEvent {
  final int index;

  OnClickItem({required this.index});
}

/* --------------------------------------------------------------------------------------  */
// bloc
class ProductsListBloc
    extends Bloc<ProductsListBlocEvent, ProductsListBlocState> {
  ProductsListBloc() : super(ProductsListBlocState.initial()) {
    on<GetProductsList>((event, emit) async {
      // loading
      emit(ProductsListBlocState(isLoading: true, data: [], isError: false));

      // api call
      final dRepo = await Repository.instance.getProductsList();
      emit(dRepo.fold(
          (failure) =>
              ProductsListBlocState(isLoading: false, data: [], isError: true),
          (success) => ProductsListBlocState(
              isLoading: false, data: success, isError: false)));
    });

    // on<OnClickNotification>((event, emit) async {
    //   state.data[event.index].isRead = true;

    //   // result
    //   emit(ProductsListBlocState(
    //       isLoading: false, data: state.data, isError: false));
    // });
  }
}
