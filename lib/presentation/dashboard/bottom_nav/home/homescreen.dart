// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_final_fields

import 'package:alot/presentation/bloc/products_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/product_details.dart';
import '../../../../core/products_list/product.dart';
import '../../../../domain/api.dart';
import '../../../utils/colors.dart';
import '../../../utils/dims.dart';
import '../../productview.dart';
import 'package:shimmer/shimmer.dart';

ScrollController scrollController = ScrollController();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductsListBloc>(context).add(
      GetProductsList(),
    );
    return Scaffold(
        backgroundColor: colorWhite,
        body: SafeArea(child:
            BlocBuilder<ProductsListBloc, ProductsListBlocState>(
                builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoSearchTextField(
                  // controller: _searchController,
                  onChanged: (value) {
                    BlocProvider.of<ProductsListBloc>(context).add(
                      SearchItem(title: value),
                    );
                  },
                ),
              ),
              if (state.isLoading)
                SizedBox(
                    height: 50,
                    child: ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext ctx, index) {
                          return Shimmer.fromColors(
                            baseColor: Color(0xfffbf9f6),
                            highlightColor: Color(0xffc0c0c0),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                colorBlack)),
                                    onPressed: () {},
                                    child: Text(
                                      '',
                                      style: TextStyle(color: colorWhite),
                                    ))),
                          );
                        }))
              else
                SizedBox(
                    height: 50,
                    child: ListView.builder(
                        itemCount: state.categoryData.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext ctx, index) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(colorBlack)),
                                  onPressed: () {
                                    if (index == 0) {
                                      BlocProvider.of<ProductsListBloc>(context)
                                          .add(
                                        SearchItem(title: ''),
                                      );
                                    } else {
                                      BlocProvider.of<ProductsListBloc>(context)
                                          .add(
                                        OnClickCategoryItem(
                                            name: state
                                                .categoryData[index].items),
                                      );
                                    }
                                  },
                                  child: Text(
                                    state.categoryData[index].items,
                                    style: TextStyle(color: colorWhite),
                                  )));
                        })),
              if (state.isLoading)
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                Expanded(
                    child: GridView.count(
                  controller: scrollController,
                  crossAxisCount: 2,
                  mainAxisSpacing: 7,
                  crossAxisSpacing: 7,
                  shrinkWrap: true,
                  childAspectRatio: 1,
                  children: List.generate(state.data.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 2, right: 2, top: 5, bottom: 5),
                      child: ProductGrid(
                        product: state.data[index],
                      ),
                    );
                  }),
                )),
            ],
          );
        })));
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
