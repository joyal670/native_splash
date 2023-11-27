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
}
