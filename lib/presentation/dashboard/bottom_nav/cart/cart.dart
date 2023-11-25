// ignore_for_file: prefer_const_constructors

import 'package:alot/presentation/utils/colors.dart';
import 'package:alot/presentation/utils/dims.dart';
import 'package:flutter/material.dart';

import '../../cart_operation.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.isHomeScreen});

  final bool isHomeScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorWhite,
        appBar: isHomeScreen
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
        body: ValueListenableBuilder(
            valueListenable: cartListener,
            builder: (context, value, child) {
              return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final data = value[index];
                    return InkWell(
                      onTap: () {
                        deleteCartItem(data.productDetails.id!);
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  fontWeight: FontWeight.w700,
                                                  overflow:
                                                      TextOverflow.ellipsis),
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
                                        data.productDetails.brand.toString(),
                                        style: TextStyle(
                                            color: colorGrey, fontSize: 12),
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
                                        data.productDetails.price.toString(),
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
            }));
  }
}
