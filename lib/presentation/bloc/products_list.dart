import 'package:alot/core/categories.dart';
import 'package:alot/domain/api.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/products_list/product.dart';
import '../../domain/failures/MainFailure.dart';
import '../../domain/repository/repository.dart';

/* --------------------------------------------------------------------------------------  */
// state
class ProductsListBlocState {
  bool isLoading;
  List<Product> data;
  bool isError;

  List<Category> categoryData; // Filtered data

  ProductsListBlocState({
    required this.isLoading,
    required this.data,
    required this.isError,
    required this.categoryData,
  });

  factory ProductsListBlocState.initial() => ProductsListBlocState(
      data: [], isError: false, isLoading: true, categoryData: []);
}

/* --------------------------------------------------------------------------------------  */
// events
@immutable
abstract class ProductsListBlocEvent {}

class GetProductsList extends ProductsListBlocEvent {}

class SearchItem extends ProductsListBlocEvent {
  final String title;

  SearchItem({required this.title});
}

class GetCategoryList extends ProductsListBlocEvent {}

class OnClickCategoryItem extends ProductsListBlocEvent {
  final String name;

  OnClickCategoryItem({required this.name});
}

/* --------------------------------------------------------------------------------------  */
// bloc
class ProductsListBloc
    extends Bloc<ProductsListBlocEvent, ProductsListBlocState> {
  ProductsListBloc() : super(ProductsListBlocState.initial()) {
    on<GetProductsList>((event, emit) async {
      // loading
      emit(ProductsListBlocState(
          isLoading: true, data: [], isError: false, categoryData: []));

      // api call
      final productsListFuture = Repository.instance.getProductsList();
      final categoryListFuture = Repository.instance.categories();

      // wait for both futures to complete
      final results =
          await Future.wait([productsListFuture, categoryListFuture]);

      // handle results
      final productsRepo = results[0] as Either<MainFailure, List<Product>>;
      final categoriesRepo = results[1] as Either<MainFailure, List<Category>>;

      emit(ProductsListBlocState(
        isLoading: false,
        data: productsRepo.fold((_) => [], (success) => success),
        isError: productsRepo.isLeft(),
        categoryData: categoriesRepo.fold((_) => [], (success) => success),
      ));

      // emit(dRepo.fold(
      //     (failure) => ProductsListBlocState(
      //         isLoading: false,
      //         data: [],
      //         isError: true,
      //         filteredData: [],
      //         categoryData: []),
      //     (success) => ProductsListBlocState(
      //         isLoading: false,
      //         data: success,
      //         isError: false,
      //         filteredData: success,
      //         categoryData: state.categoryData)));
    });

    on<SearchItem>((event, emit) async {
      // var filteredCartList = state.data
      //     .where((cartItem) =>
      //         cartItem.title!.toLowerCase().contains(event.title.toLowerCase()))
      //     .toList();

      // api call
      final dRepo = await Repository.instance.searchProduct(event.title);

      emit(dRepo.fold(
          (failure) => ProductsListBlocState(
              isLoading: false, data: [], isError: true, categoryData: []),
          (success) => ProductsListBlocState(
              isLoading: false,
              data: success,
              isError: false,
              categoryData: state.categoryData)));

      // emit(ProductsListBlocState(
      //     isLoading: false,
      //     data: state.data,
      //     isError: false,
      //     filteredData: filteredCartList));
    });

    // on<GetCategoryList>((event, emit) async {
    //   // api call
    //   final dRepo = await Repository.instance.categories();

    //   emit(dRepo.fold(
    //       (failure) => ProductsListBlocState(
    //           isLoading: false,
    //           data: [],
    //           isError: true,
    //           filteredData: [],
    //           categoryData: []),
    //       (success) => ProductsListBlocState(
    //           isLoading: false,
    //           data: state.data,
    //           isError: false,
    //           filteredData: state.filteredData,
    //           categoryData: success)));
    // });

    on<OnClickCategoryItem>((event, emit) async {
      // var filteredCartList = state.data
      //     .where((cartItem) =>
      //         cartItem.title!.toLowerCase().contains(event.title.toLowerCase()))
      //     .toList();

      // api call
      final dRepo = await Repository.instance.categoryProduct(event.name);

      emit(dRepo.fold(
          (failure) => ProductsListBlocState(
              isLoading: false, data: [], isError: true, categoryData: []),
          (success) => ProductsListBlocState(
              isLoading: false,
              data: success,
              isError: false,
              categoryData: state.categoryData)));

      // emit(ProductsListBlocState(
      //     isLoading: false,
      //     data: state.data,
      //     isError: false,
      //     filteredData: filteredCartList));
    });
  }
}
