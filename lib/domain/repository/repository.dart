import 'package:alot/core/categories.dart';
import 'package:alot/domain/url.dart';
import 'package:dio/dio.dart';

import '../failures/MainFailure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/products_list/product.dart';

class Repository {
  Repository._internal();
  static Repository instance = Repository._internal();
  factory() {
    return instance;
  }

  final dio = Dio();
  final url = URL();

  Repository() {
    dio.options = BaseOptions(
      baseUrl: url.baseUrl,
      responseType: ResponseType.json,
    );
  }

  Future<Either<MainFailure, List<Product>>> getProductsList() async {
    try {
      final response = await dio.get(
        url.baseUrl + url.products,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Product> products = List.from(response.data['products']
            .map((productJson) => Product.fromJson(productJson)));

        return Right(products);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return Left(MainFailure.clientFailure());
    }
  }

  Future<Either<MainFailure, List<Product>>> searchProduct(String query) async {
    try {
      final response = await dio
          .get(url.baseUrl + url.productSearch, queryParameters: {'q': query});
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Product> products = List.from(response.data['products']
            .map((productJson) => Product.fromJson(productJson)));

        return Right(products);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return Left(MainFailure.clientFailure());
    }
  }

  Future<Either<MainFailure, List<Category>>> categories() async {
    try {
      final response = await dio.get(
        url.baseUrl + url.categories,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Category> data = [];
        response.data.forEach(
          (element) {
            data.add(Category.fromJson(element));
          },
        );

        // List<Category> categories = response.data.map((category) {
        //   return Category.fromJson([category]);
        // }).toList();

        // print(data);
        return Right(data);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      print(e);
      return Left(MainFailure.clientFailure());
    }
  }
}
