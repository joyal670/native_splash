// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:alot/presentation/dashboard/cart_operation.dart';
import 'package:alot/presentation/dashboard/cartmodel.dart';
import 'package:alot/presentation/dashboard/dashboard.dart';
import 'package:alot/presentation/order/address.dart';
import 'package:alot/presentation/utils/colors.dart';
import 'package:alot/presentation/utils/dims.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({super.key});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  int payment = 0;
  AddressModel? model;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: colorBlue,
            )),
        elevation: 0,
        title: Text(
          'Checkout',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: colorBlack),
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
                  onPressed: () {
                    Navigator.pushAndRemoveUntil<void>(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const DashboardScreen()),
                      ModalRoute.withName('/'),
                    );
                  },
                  child: Text('Pay Now')),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Cart(),
              )),
          Container(
            padding: EdgeInsets.all(10),
            color: colorWhite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery to',
                      style: TextStyle(fontSize: 12, color: colorGrey),
                    ),
                    TextButton(
                        onPressed: () async {
                          final result = await Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return AddressListing();
                          }));

                          if (!mounted) return;

                          // ScaffoldMessenger.of(context)
                          //   ..removeCurrentSnackBar()
                          //   ..showSnackBar(
                          //       SnackBar(content: Text('$result')));

                          setState(() {
                            model = result;
                          });
                        },
                        child: Text('Edit')),
                  ],
                ),
                model == null
                    ? Text(
                        'no address found, please add an address',
                        style: TextStyle(
                          color: colorRed,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    : Text(
                        '${model!.location}, ${model!.name}, ${model!.phone}'),
                height20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery service, Delivery by',
                      style: TextStyle(fontSize: 12, color: colorGrey),
                    ),
                    TextButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              currentDate: DateTime.now(),
                              initialDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(Duration(days: 365)));

                          if (picked != null && picked != selectedDate) {
                            setState(() {
                              selectedDate = picked;
                            });
                          }

                          // print(
                          //     'Fedex Express, ${DateFormat('yyyy-MM-dd').format(selectedDate!)}');
                        },
                        child: Text('Change')),
                  ],
                ),
                selectedDate == null
                    ? Text(
                        'Fedex Express, Friday 28 July',
                        style: TextStyle(
                          color: colorBlack,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        'Fedex Express, ${DateFormat('EEEE dd MMM').format(selectedDate!)}',
                        style: TextStyle(
                          color: colorBlack,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                height30,
                Summary(),
                height30,
                Text(
                  'Payment Method',
                  style: TextStyle(
                    color: colorBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                height15,
                Container(
                  height: 90,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: colorpOBackground,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          payment == 0 ? Border.all(color: colorBlack) : null),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          payment = 0;
                        });
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Credit Card',
                                  style: TextStyle(
                                    color: colorBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '**** **** **** 1254',
                                  style: TextStyle(
                                    color: colorpOrange,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset(
                                  'assets/images/mastercard.png',
                                  width: 30,
                                  height: 30,
                                ),
                                Text(
                                  '01/25',
                                  style: TextStyle(
                                    color: colorBlack,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                height10,
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 90,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: colorpOBackground,
                        borderRadius: BorderRadius.circular(10),
                        border: payment == 0
                            ? null
                            : Border.all(color: colorBlack)),
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            payment = 1;
                          });
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Paypal',
                                    style: TextStyle(
                                      color: colorBlack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'CARD HOLDER NAME',
                                    style: TextStyle(
                                      color: colorBlack,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/paypal.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
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

  Container Summary() {
    return Container(
        width: double.infinity,
        // padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: colorpOBackground, borderRadius: BorderRadius.circular(10)),
        child: ValueListenableBuilder(
            valueListenable: cartListener,
            builder: (context, value, child) {
              int total = 0;
              for (var element in value) {
                var sub = (element.productDetails.price! * element.qty);
                total = total + sub;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Order Summary',
                      style: TextStyle(
                        color: colorBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Divider(
                    color: colorBlack,
                    thickness: 0.5,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 10, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: TextStyle(fontSize: 12, color: colorGrey),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money_outlined,
                              size: 17,
                              color: colorOrange,
                            ),
                            Text(
                              total.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 17),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 10, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tax',
                          style: TextStyle(fontSize: 12, color: colorGrey),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money_outlined,
                              size: 17,
                              color: colorOrange,
                            ),
                            Text(
                              "2.0",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 17),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 10, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery',
                          style: TextStyle(fontSize: 12, color: colorGrey),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money_outlined,
                              size: 17,
                              color: colorOrange,
                            ),
                            Text(
                              "10.0",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 17),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, top: 10, right: 16, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 12, color: colorGrey),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money_outlined,
                              size: 17,
                              color: colorOrange,
                            ),
                            Text(
                              '${total + 2 + 10}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 17),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }));
  }

  ValueListenableBuilder<List<CartModel>> Cart() {
    return ValueListenableBuilder(
        valueListenable: cartListener,
        builder: (context, value, child) {
          return ListView.separated(
              separatorBuilder: (context, index) {
                return height10;
              },
              shrinkWrap: true,
              itemCount: value.length,
              itemBuilder: (cxt, index) {
                final data = value[index];
                return ListTile(
                  tileColor: colorpOBackground,
                  leading: Image.network(
                    data.productDetails.thumbnail ??
                        'assets/images/no_image.png',
                    width: 90,
                    height: 90,
                  ),
                  title: Text(
                    data.productDetails.title.toString(),
                    style: TextStyle(
                        color: colorBlack,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis),
                    softWrap: true,
                    maxLines: 1,
                  ),
                  subtitle: Column(
                    children: [
                      height4,
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money_outlined,
                            size: 17,
                            color: colorOrange,
                          ),
                          Text(
                            data.productDetails.price.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                        ],
                      ),
                      height5,
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              await removeQty(index);
                            },
                            child: Icon(
                              Icons.remove,
                              size: 20.0,
                            ),
                          ),
                          width10,
                          Text(
                            data.qty.toString(),
                            style: TextStyle(
                                color: colorBlack, fontWeight: FontWeight.bold),
                          ),
                          width10,
                          InkWell(
                            onTap: () async {
                              await updateQty(index);
                            },
                            child: Icon(
                              Icons.add,
                              size: 20.0,
                            ),
                          ),
                          width20
                        ],
                      ),
                      height10
                    ],
                  ),
                  trailing: InkWell(
                    onTap: () {
                      deleteCartItem(index);
                    },
                    child: Icon(
                      Icons.delete_rounded,
                      size: 17.0,
                      color: colorRed,
                    ),
                  ),
                );
              });
        });
  }
}
