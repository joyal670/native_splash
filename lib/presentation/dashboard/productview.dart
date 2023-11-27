// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:alot/core/product_details.dart';
import 'package:alot/presentation/dashboard/bottom_nav/cart/cart.dart';
import 'package:alot/presentation/dashboard/cart_operation.dart';
import 'package:alot/presentation/dashboard/cartmodel.dart';
import 'package:alot/presentation/utils/colors.dart';
import 'package:alot/presentation/utils/dims.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductView extends StatefulWidget {
  ProductDetails product;

  ProductView({super.key, required this.product});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  int _current = 0;
  int cartQty = 1;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            width10,
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return CartScreen(
                    isHomeScreen: false,
                  );
                }));
              },
              child: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black,
                size: 30,
              ),
            ),
            width20,
            Expanded(
              child: SizedBox(
                height: 45,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(colorpOrange)),
                    onPressed: () async {
                      final model =
                          CartModel(widget.product.id, widget.product, cartQty);
                      final table = await Hive.openBox<CartModel>('cart_db');
                      final existingItemIndex = table.values
                          .toList()
                          .indexWhere((item) => item.id == model.id);
                      print(existingItemIndex);
                      print(model.id);
                      if (existingItemIndex == -1) {
                        addToCart(model);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("added to cart"),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "${widget.product.title} already added in cart"),
                        ));
                      }

                      // for (final item in table.values) {
                      //   if (item.id == model.id) {
                      //     SnackBar(
                      //       content: Text(
                      //           "${widget.product.title}already added in cart"),
                      //     );
                      //     break;
                      //   }
                      // }
                      // addToCart(model);
                    },
                    child: Text('Add to Bag')),
              ),
            ),
            width10
          ],
        ),
      ),
      body: Column(
        children: [
          height40,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: colorBlue,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      widget.product.title.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.product.brand.toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: colorBlue,
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              // padding: EdgeInsets.all(10),
              children: [
                height20,
                Stack(
                  children: [
                    CarouselSlider.builder(
                      carouselController: _controller,
                      itemCount: widget.product.images!.length,
                      options: CarouselOptions(
                          height: 200.0,
                          autoPlay: true,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reas) {
                            setState(() {
                              _current = index;
                            });
                          }),
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) =>
                          Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: Colors.amber),
                        child: Image.network(
                          widget.product.images![itemIndex].toString(),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 10,
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.favorite,
                          size: 25.0,
                        ),
                        padding: EdgeInsets.all(12.0),
                        shape: CircleBorder(),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 10,
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 2, left: 5, right: 5, bottom: 2),
                        decoration: BoxDecoration(
                            color: colorWhite,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Text(
                              widget.product.rating.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                              color: colorAmber,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.product.images!.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 5.0,
                        height: 5.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
                height40,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.product.description.toString(),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                height20,
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: colorMobyDick,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        height15,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Text(
                            //   'Price ',
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.bold, fontSize: 20),
                            // ),
                            Icon(
                              Icons.attach_money_outlined,
                            ),
                            Text(
                              widget.product.price.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            width10,
                            Text(
                              'get a flat discount of ',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              "${widget.product.discountPercentage}%.",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        height15,
                        Row(
                          children: [
                            Text(
                              'In stock : ${widget.product.stock}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                RawMaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      cartQty--;
                                      if (cartQty <= 1) {
                                        cartQty = 1;
                                      }
                                    });
                                  },
                                  elevation: 2.0,
                                  fillColor: Colors.white,
                                  child: Icon(
                                    Icons.remove,
                                    size: 15.0,
                                  ),
                                  //  padding: EdgeInsets.all(5.0),
                                  shape: CircleBorder(),
                                ),
                                Text('$cartQty'),
                                RawMaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      cartQty++;
                                    });
                                  },
                                  elevation: 2.0,
                                  fillColor: Colors.white,
                                  child: Icon(
                                    Icons.add,
                                    size: 20.0,
                                  ),
                                  // padding: EdgeInsets.all(10.0),
                                  shape: CircleBorder(),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
