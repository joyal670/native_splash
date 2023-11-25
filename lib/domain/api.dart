import 'dart:convert';

import 'package:alot/core/product_details.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gson/gson.dart';

import '../core/products_list/product.dart';
import '../core/products_list/products_list.dart';
import 'url.dart';

class ApiClass {
  ApiClass._internal();
  static ApiClass instance = ApiClass._internal();
  factory() {
    return instance;
  }

  final dio = Dio();
  final url = URL();

  ApiClass() {
    dio.options = BaseOptions(
      baseUrl: url.baseUrl,
      responseType: ResponseType.json,
    );
  }

  Future<List<Product>> getProducts() async {
    final result = await dio.get(
      url.baseUrl + url.products,
    );

    List<Product> products = List.from(result.data['products']
        .map((productJson) => Product.fromJson(productJson)));
    return products;
  }

  Future<ProductDetails> getProductDetails(String id) async {
    final result = await dio.get(
      url.baseUrl + url.products + "/" + id,
    );

    ProductDetails productDetails = ProductDetails.fromJson(result.data);
    return productDetails;
  }
}
