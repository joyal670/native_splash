// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:alot/presentation/utils/colors.dart';
import 'package:alot/presentation/utils/dims.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../providers/LocaleProvider.dart';
import '../utils/Responsive .dart';
import '../utils/common_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartNotifier(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: colorBlue,
            leading: Builder(builder: (context) {
              return InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Image.asset(
                    'assets/images/hamburger_icon.png',
                  ),
                ),
              );
            }),
            // leadingWidth: 35,
          ),
          drawer: Drawer(
            width: Responsive.isMobile(context) ? null : 500,
            backgroundColor: colorWhite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LocaleSwitcherWidget(),
                Padding(
                  padding: const EdgeInsets.only(top: 50, right: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 30,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/footer_ogo.png",
                        width: 120,
                        height: 60,
                      ),
                      height15,
                      TextWidget(
                          title: AppLocalizations.of(context)!.hello.toString(),
                          textStyle: TextStyle(fontWeight: FontWeight.bold)),
                      height5,
                      TextWidget(
                          title: "Classifieds",
                          textStyle: TextStyle(fontWeight: FontWeight.bold)),
                      height5,
                      TextWidget(
                          title: "Care",
                          textStyle: TextStyle(fontWeight: FontWeight.bold)),
                      height5,
                      TextWidget(
                          title: "Market",
                          textStyle: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: TextWidget(
                              title: "Login",
                              textStyle:
                                  TextStyle(fontWeight: FontWeight.bold)),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(colorBlue),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: TextWidget(
                              title: "Sign in",
                              textStyle:
                                  TextStyle(fontWeight: FontWeight.bold)),
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(colorRed),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ProductList(),
              ),
              ShoppingCartSummary(),
            ],
          )),
    );
  }
}

class ShoppingCartSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartNotifier = context.watch<CartNotifier>();

    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Shopping Cart Summary',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          // Display items in the cart
          for (final item in cartNotifier.cart.items)
            ListTile(
              title: Text(item.name),
              subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
              trailing: ElevatedButton(
                onPressed: () {
                  context.read<CartNotifier>().removeItem(item);
                },
                child: Text('Remove from Cart'),
              ),
            ),
          SizedBox(height: 10.0),
          Text('Total Items: ${cartNotifier.cart.items.length}'),
          Text(
              'Total Price: \$${cartNotifier.cart.totalPrice.toStringAsFixed(2)}'),
          SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              context.read<CartNotifier>().clearCart();
            },
            child: Text('Clear Cart'),
          ),
        ],
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Product> products = [
    Product(id: '1', name: 'Item 1', price: 20.0),
    Product(id: '2', name: 'Item 2', price: 30.0),
    Product(id: '3', name: 'Item 3', price: 15.0),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<CartNotifier>().addItem(product);
                },
                child: Text('Add to Cart'),
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  context.read<CartNotifier>().removeItem(product);
                },
                child: Text('Remove'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LocaleSwitcherWidget extends StatelessWidget {
  const LocaleSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: locale,
        icon: Container(width: 12),
        items: AppLocalizations.supportedLocales.map(
          (nextLocale) {
            return DropdownMenuItem(
              value: nextLocale,
              onTap: () {
                final provider =
                    Provider.of<LocaleProvider>(context, listen: false);

                provider.setLocale(nextLocale);
              },
              child: Center(
                child: Text(nextLocale.toString()),
              ),
            );
          },
        ).toList(),
        onChanged: (_) {},
      ),
    );
  }
}

// ChangeNotifier class to notify listeners when the cart changes
class CartNotifier extends ChangeNotifier {
  Cart _cart = Cart();

  Cart get cart => _cart;

  void addItem(Product product) {
    _cart.items.add(product);
    notifyListeners();
  }

  void removeItem(Product product) {
    _cart.items.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cart.items.clear();
    notifyListeners();
  }
}

// Model for a product
class Product {
  final String id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});
}

// Model for the shopping cart
class Cart {
  final List<Product> items = [];
  double get totalPrice => items.fold(0, (sum, item) => sum + item.price);
}
