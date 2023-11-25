import 'package:alot/core/product_details.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'cartmodel.g.dart';

@HiveType(typeId: 2)
class CartModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  ProductDetails productDetails;

  @HiveField(2)
  int qty;

  CartModel(this.id, this.productDetails, this.qty);

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      json['id'] as int,
      ProductDetails.fromJson(json['productDetails']),
      json['qty'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productDetails': productDetails.toJson(),
      'qty': qty,
    };
  }
}
