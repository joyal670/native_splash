import 'package:alot/core/categories.dart';
import 'package:alot/core/login_response.dart';
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
        data.add(Category(items: "All"));
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
      return Left(MainFailure.clientFailure());
    }
  }

  Future<Either<MainFailure, List<Product>>> categoryProduct(
      String query) async {
    try {
      final response = await dio.get(
        "${url.baseUrl}${url.category}/$query",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Product> products = List.from(response.data['products']
            .map((productJson) => Product.fromJson(productJson)));

        return Right(products);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      print(e);
      return Left(MainFailure.clientFailure());
    }
  }

  Future<Either<MainFailure, LoginResponse>> login(
      String username, String password) async {
    final formData = FormData.fromMap({
      'username': username,
      'password': password,
    });

    try {
      final response = await dio.post(url.baseUrl + url.login, data: formData);
      print(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(LoginResponse.fromJson(response.data));
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          final response = LoginResponse.fromJson(e.response!.data);
          return Left(MainFailure.clientFailure(response.message.toString()));
        } else {
          return Left(MainFailure.clientFailure());
        }
      } else {
        return Left(MainFailure.clientFailure());
      }
    }
  }
}
