// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/product_details.dart';
import '../../../../core/products_list/product.dart';
import '../../../../domain/api.dart';
import '../../../utils/colors.dart';
import '../../../utils/dims.dart';
import '../../productview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();
  List<Product> productsList = [];

  @override
  void initState() {
    callApi();
    super.initState();
  }

  void callApi() async {
    final result = await ApiClass.instance.getProducts();
    setState(() {
      productsList.addAll(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: GridView.count(
        controller: _scrollController,
        crossAxisCount: 2,
        mainAxisSpacing: 7,
        crossAxisSpacing: 7,
        shrinkWrap: true,
        childAspectRatio: 1,
        children: List.generate(productsList.length, (index) {
          return GestureDetector(
              onTap: () {
                // pushNewScreen(
                //   context,
                //   screen: ViewImageScreen(
                //     photoId: model[index].id,
                //   ),
                //   withNavBar: false, // OPTIONAL VALUE. True by default.
                //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                // );
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 2, right: 2, top: 5, bottom: 5),
                child: ProductGrid(
                  product: productsList[index],
                ),
              ));
        }),
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final Product product;

  const ProductGrid({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(10),
        //border: Border.all(color: colorBlack),
      ),
      child: Material(
        child: InkWell(
          onTap: () async {
            ProductDetails result = await ApiClass.instance
                .getProductDetails(product.id.toString());
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ProductView(
                product: result,
              );
            }));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                width: double.infinity,
                height: 100,
                product.images![0].toString(),
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 3),
                child: Text(
                  product.title.toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                ),
              ),
              height10,
              Row(
                children: [
                  Icon(Icons.currency_rupee),
                  Text(
                    product.price.toString(),
                    style: TextStyle(
                        fontSize: 19,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal),
                  ),
                  width5,
                  Text(
                    product.discountPercentage.toString(),
                    style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.lineThrough),
                  ),
                  width5,
                  Spacer(),
                  RatingBar.builder(
                    initialRating: product.rating!,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 15,
                    ignoreGestures: true,
                    // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
