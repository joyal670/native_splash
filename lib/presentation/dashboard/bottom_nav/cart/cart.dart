// ignore_for_file: prefer_const_constructors

import 'package:alot/core/product_details.dart';
import 'package:alot/presentation/dashboard/productview.dart';
import 'package:alot/presentation/utils/colors.dart';
import 'package:alot/presentation/utils/dims.dart';
import 'package:alot/presentation/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../domain/api.dart';
import '../../cart_operation.dart';
import '../../cartmodel.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.isHomeScreen});

  final bool isHomeScreen;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late TextEditingController _searchController;
  late List<CartModel> _filteredCartList;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredCartList = cartListener.value;
  }

  void _searchProducts(String query) {
    setState(() {
      _filteredCartList = cartListener.value
          .where((cartItem) => cartItem.productDetails.title!
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();

      print(_filteredCartList);
    });
  }

  @override
  Widget build(BuildContext context) {
    getAllProducts();
    return Scaffold(
        backgroundColor: colorWhite,
        appBar: widget.isHomeScreen
            ? null
            : AppBar(
                backgroundColor: colorpOBackground,
                centerTitle: true,
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: colorBlue,
                    )),
                iconTheme: IconThemeData(
                  color: colorBlack, //change your color here
                ),
                elevation: 0,
                title: Text(
                  'My Cart',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorBlack),
                  textAlign: TextAlign.center,
                ),
              ),
        bottomNavigationBar: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(colorBlack)),
                    onPressed: () {},
                    child: Text('Proceed to checkout')),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                // controller: _searchController,
                onChanged: (value) {
                  _searchProducts(value);
                },
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: cartListener,
                  builder: (context, value, child) {
                    return ListView.builder(
                        itemCount: _filteredCartList.length,
                        itemBuilder: (cxt, index) {
                          final data = _filteredCartList[index];
                          return InkWell(
                            onTap: () async {
                              if (isRedundantClick(DateTime.now())) {
                                print('hold on, processing');
                                return;
                              }
                              print('run process');
                              ProductDetails result = await ApiClass.instance
                                  .getProductDetails(data.id.toString());
                              Navigator.of(cxt)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ProductView(
                                  product: result,
                                );
                              }));
                            },
                            child: Container(
                              //  padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: colorpOBackground,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  width10,
                                  Image.network(
                                    data.productDetails.thumbnail ??
                                        'assets/images/no_image.png',
                                    width: 90,
                                    height: 90,
                                  ),
                                  width20,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    data.productDetails.title
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: colorBlack,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                    softWrap: true,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    deleteCartItem(index);
                                                  },
                                                  child: Icon(
                                                    Icons.delete_rounded,
                                                    size: 20.0,
                                                    color: colorBlack,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              data.productDetails.brand
                                                  .toString(),
                                              style: TextStyle(
                                                  color: colorGrey,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.attach_money_outlined,
                                              size: 15,
                                            ),
                                            Text(
                                              data.productDetails.price
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 22),
                                            ),
                                            Spacer(),
                                            Row(
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    await removeQty(index);
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 20.0,
                                                  ),
                                                ),
                                                Text(data.qty.toString()),
                                                TextButton(
                                                  onPressed: () async {
                                                    await updateQty(index);
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 20.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        height10
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }),
            ),
          ],
        ));
  }
}
