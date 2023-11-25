import 'dart:math';

import 'package:alot/presentation/dashboard/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<CartModel>> cartListener = ValueNotifier([]);

void addToCart(CartModel model) async {
  final table = await Hive.openBox<CartModel>('cart_db');
  //final _id = await studentTable.add(model);

  // for (final item in table.values) {
  //   if (item.id == model.id) {
  //     model.qty++;
  //   }
  // }
  //model.id = await table.add(model);

  //getAllProducts();
  // cartListener.value.add(model);
  // cartListener.notifyListeners();

  // Check if the item ID is already present in the cart
  // int existingItemId = model.id!;
  // for (final item in table.values) {
  //   if (item.id == model.id) {
  //     existingItemId = item.id as int;
  //     break;
  //   }
  // }

  // if (existingItemId != model.id) {
  //   // If the item is already in the cart, update the quantity
  //   CartModel existingItem = table.get(existingItemId) as CartModel;
  //   existingItem.qty += model.qty;
  //   table.put(existingItemId, existingItem);
  // } else {
  //   // If the item is not in the cart, add it
  //   model.id = await table.add(model);
  // }

  // Check if the item ID is already present in the cart
  // final existingItemIndex =
  //     table.values.toList().indexWhere((item) => item.id == model.id);

  // print(existingItemIndex);

  // if (existingItemIndex != -1) {
  //   // Item already exists, update the quantity
  //   final existingItem = table.values.toList()[existingItemIndex];
  //   existingItem.qty += model.qty; // Update quantity (adjust as needed)
  //   await table.put(
  //       existingItem.id, existingItem); // Update existing item in Hive
  // } else {
  //   // Item does not exist, add it to the cart
  //   model.id = await table.add(model);
  // }

  int existingItemId = model.id!;
  // for (final item in table.values) {
  //   if (item.id == model.id) {
  //     existingItemId = item.id as int;
  //     final existingItem = table.values.toList()[existingItemId];
  //     existingItem.qty += model.qty; // Update quantity (adjust as needed)
  //     await table.put(
  //         existingItem.id, existingItem); // Update existing item in Hive
  //     break;
  //   }
  // }

  // if (existingItemId == model.id) {
  //   final existingItem = table.values.toList()[existingItemId];
  //   existingItem.qty += model.qty; // Update quantity (adjust as needed)
  //   await table.put(
  //       existingItem.id, existingItem); // Update existing item in Hive
  // } else {
  //   await table.add(model);
  // }

  await table.add(model);

  getAllProducts();
}

void getAllProducts() async {
  final table = await Hive.openBox<CartModel>('cart_db');
  cartListener.value.clear();
  cartListener.value.addAll(table.values);
  cartListener.notifyListeners();
  // print(table);
}

deleteCartItem(int id) async {
  final table = await Hive.openBox<CartModel>('cart_db');
  //table.delete(id);
  table.deleteAt(id);
  getAllProducts();
}

updateQty(int index) async {
  final table = await Hive.openBox<CartModel>('cart_db');
  // final existingItem = table.values.toList()[existingItemId];
  // print(existingItem);
  // existingItem.qty++;
  // await table.put(existingItem.id, existingItem);

  final item = table.values.toList()[index];
  item.qty++;
  await table.putAt(index, item);

  // for (final item in table.values) {
  //   if (item.id == existingItemId) {
  //     print(table.values.toList()[0].productDetails.title);
  //     final existingItem = table.values.toList()[0];
  //     existingItem.qty++; // Update quantity (adjust as needed)
  //     await table.put(
  //         existingItem.id, existingItem); // Update existing item in Hive
  //     break;
  //   }
  // }
  getAllProducts();
}

removeQty(int index) async {
  final table = await Hive.openBox<CartModel>('cart_db');

  final item = table.values.toList()[index];
  item.qty--;
  if (item.qty <= 1) {
    item.qty = 1;
  }
  await table.putAt(index, item);
  getAllProducts();
}
