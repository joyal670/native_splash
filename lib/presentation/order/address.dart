// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:alot/presentation/utils/colors.dart';
import 'package:alot/presentation/utils/common_widgets.dart';
import 'package:alot/presentation/utils/dims.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum SampleItem { edit, delete }

class AddressListing extends StatefulWidget {
  const AddressListing({super.key});

  @override
  State<AddressListing> createState() => _AddressListingState();
}

class _AddressListingState extends State<AddressListing> {
  List<AddressModel> model = getAddress();
  int selectedIndex = 0;

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
          'Delivery Address',
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
                    Navigator.pop(context, model[selectedIndex]);
                  },
                  child: Text('Set as defalut')),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {
                bottomSheet(
                  context,
                );
              },
              child: Text('add address')),
          Expanded(
            child: ListView.separated(
                itemCount: model.length,
                separatorBuilder: (context, index) {
                  return height10;
                },
                itemBuilder: (context, index) {
                  AddressModel addressModel = model[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: colorpOBackground,
                            borderRadius: BorderRadius.circular(10),
                            border: addressModel.isSelected
                                ? Border.all(color: colorBlue)
                                : null),
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              for (var element in model) {
                                element.isSelected = false;
                              }
                              selectedIndex = index;
                              setState(() {
                                addressModel.isSelected = true;
                              });
                            },
                            onDoubleTap: () {
                              for (var element in model) {
                                element.isSelected = false;
                              }
                              selectedIndex = index;
                              Navigator.pop(context, model[selectedIndex]);
                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(addressModel.type),
                                    MenuAnchor(
                                      builder: (BuildContext context,
                                          MenuController controller,
                                          Widget? child) {
                                        return IconButton(
                                          onPressed: () {
                                            if (controller.isOpen) {
                                              controller.close();
                                            } else {
                                              controller.open();
                                            }
                                          },
                                          icon: const Icon(Icons.more_horiz),
                                          tooltip: 'Show menu',
                                        );
                                      },
                                      // menuChildren: List<MenuItemButton>.generate(
                                      //   2,
                                      //   (int index) => MenuItemButton(
                                      //     onPressed: () => setState(() =>
                                      //         selectedMenu =
                                      //             SampleItem.values[index]),
                                      //     child: Text('Item ${index + 1}'),
                                      //   ),
                                      // ),
                                      menuChildren: [
                                        MenuItemButton(
                                            onPressed: () {
                                              bottomSheet(context,
                                                  location:
                                                      addressModel.location,
                                                  name: addressModel.name,
                                                  phone: addressModel.phone,
                                                  type: addressModel.type);
                                            },
                                            child: Text(
                                              "edit",
                                              style:
                                                  TextStyle(color: colorBlack),
                                            )),
                                        MenuItemButton(
                                            onPressed: () {
                                              setState(() {
                                                model.removeAt(index);
                                              });
                                            },
                                            child: Text(
                                              "delete",
                                              style:
                                                  TextStyle(color: colorBlack),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                                height15,
                                Row(
                                  children: [
                                    Icon(
                                      Icons.pin_drop,
                                      color: addressModel.isSelected
                                          ? colorBlue
                                          : colorGrey,
                                    ),
                                    width10,
                                    Text(addressModel.location),
                                  ],
                                ),
                                height15,
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: addressModel.isSelected
                                          ? colorBlue
                                          : colorGrey,
                                    ),
                                    width10,
                                    Text(addressModel.name),
                                  ],
                                ),
                                height15,
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: addressModel.isSelected
                                          ? colorBlue
                                          : colorGrey,
                                    ),
                                    width10,
                                    Text(addressModel.phone),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Future<void> bottomSheet(BuildContext context,
      {String? location, String? name, String? phone, String? type}) {
    final locationController = TextEditingController(text: location);
    final nameController = TextEditingController(text: name);
    final phoneController = TextEditingController(text: phone);
    final typeController = TextEditingController(text: type);
    return showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) {
        return Container(
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Center(
            child: Column(
              children: [
                height20,
                TextFormField(
                  controller: locationController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      constraints: BoxConstraints.expand(height: 50),
                      prefixIcon: Icon(Icons.pin_drop),
                      label: TextWidget(
                          title: "Location",
                          textStyle: TextStyle(fontSize: 12)),
                      labelStyle: TextStyle(
                          color: colorGrey, fontWeight: FontWeight.w500),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorGrey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorGrey)),
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                  maxLines: 1,
                ),
                height10,
                TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      constraints: BoxConstraints.expand(height: 50),
                      prefixIcon: Icon(Icons.person),
                      label: TextWidget(
                          title: "Name", textStyle: TextStyle(fontSize: 12)),
                      labelStyle: TextStyle(
                          color: colorGrey, fontWeight: FontWeight.w500),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorGrey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorGrey)),
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                  maxLines: 1,
                ),
                height10,
                TextFormField(
                  controller: phoneController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      constraints: BoxConstraints.expand(height: 50),
                      prefixIcon: Icon(Icons.phone),
                      label: TextWidget(
                          title: "Phone", textStyle: TextStyle(fontSize: 12)),
                      labelStyle: TextStyle(
                          color: colorGrey, fontWeight: FontWeight.w500),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorGrey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorGrey)),
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                  maxLines: 1,
                ),
                height10,
                DropDownTextField(
                  initialValue: typeController.text,
                  textFieldDecoration: InputDecoration(
                      constraints: BoxConstraints.expand(height: 50),
                      prefixIcon: Icon(Icons.account_box),
                      label: TextWidget(
                          title: "Account", textStyle: TextStyle(fontSize: 12)),
                      labelStyle: TextStyle(
                          color: colorGrey, fontWeight: FontWeight.w500),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorGrey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorGrey)),
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                  listSpace: 10,
                  listPadding: ListPadding(top: 20),
                  enableSearch: false,
                  validator: (value) {
                    if (value == null) {
                      return "Required field";
                    } else {
                      return null;
                    }
                  },
                  dropDownList: const [
                    DropDownValueModel(name: 'Home', value: "value1"),
                    DropDownValueModel(name: 'Company', value: "value2"),
                    DropDownValueModel(name: 'Personal', value: "value3"),
                  ],
                  listTextStyle: const TextStyle(color: Colors.red),
                  dropDownItemCount: 3,
                  onChanged: (val) {},
                ),
                height20,
                ElevatedButton(
                  child: const Text('Save Address'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AddressModel {
  final String type;
  final String location;
  final String name;
  final String phone;
  bool isSelected;

  AddressModel(
      {required this.type,
      required this.location,
      required this.name,
      required this.phone,
      required this.isSelected});
}

List<AddressModel> getAddress() {
  List<AddressModel> model = [];
  model.add(AddressModel(
      type: "Home",
      location: "3745 Sycamore Lake Road",
      name: "Appleton",
      phone: "920-402-3227",
      isSelected: true));

  model.add(AddressModel(
      type: "Company",
      location: "3567 Perry Street",
      name: "Grand Blanc",
      phone: "810-603-1441",
      isSelected: false));

  model.add(AddressModel(
      type: "Home",
      location: "3569 Kessla Way",
      name: "Florence",
      phone: "843-306-4018",
      isSelected: false));

  model.add(AddressModel(
      type: "Company",
      location: "508 Norma Avenue",
      name: "Mansfield",
      phone: "937-243-9216",
      isSelected: false));

  model.add(AddressModel(
      type: "Home",
      location: "4000 Whitman Court",
      name: "Stamford",
      phone: "203-561-4561",
      isSelected: false));

  return model;
}
