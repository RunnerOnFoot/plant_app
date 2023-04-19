import 'package:flutter/material.dart';

import 'package:planet_app/widgets/extension.dart';

import '../constants/constants.dart';
import '../models/plant.dart';

import '../widgets/plant_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
    required this.addedToCartPlants,
  });
  final List<Plant> addedToCartPlants;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int finalPrice() {
    int sum = 0;
    for (Plant item in widget.addedToCartPlants) {
      setState(() {
        sum += item.price.toInt();
      });
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Badge(
                  // smallSize: 120,
                  largeSize: 20,
                  label: Text('${widget.addedToCartPlants.length}'.farsiNumber),
                  textStyle: const TextStyle(fontFamily: Constants.vazirFont),
                  backgroundColor: Constants.primary,
                  child: Icon(
                    Icons.shopping_cart,
                    color: Constants.blackColor,
                  ),
                ),
                Text(
                  'سبد خرید',
                  style: TextStyle(
                    color: Constants.blackColor,
                    fontFamily: Constants.vazirFont,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          )),
      body: widget.addedToCartPlants.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    child: Image.asset('assets/images/add-cart.png'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'سبد خرید خالی است',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      fontFamily: Constants.danaFont,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          confirmDismiss: (DismissDirection direction) async {
                            return await getDeleteConfirm(context);
                          },
                          background: Container(),
                          secondaryBackground: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'حذف کردن',
                                style: TextStyle(
                                    fontFamily: Constants.vazirFont,
                                    color: Colors.redAccent),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                            ],
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (DismissDirection direction) {
                            setState(
                              () {
                                widget.addedToCartPlants[index].isSelected =
                                    false;
                                widget.addedToCartPlants.removeAt(index);
                              },
                            );
                          },
                          key: ObjectKey(widget.addedToCartPlants[index]),
                          child: NewPlantWidget(
                            plantList: widget.addedToCartPlants,
                            size: size,
                            index: index,
                          ),
                        );
                      },
                      itemCount: widget.addedToCartPlants.length,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      const Divider(thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                                child: Image.asset(
                                  'assets/images/PriceUnit-green.png',
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                finalPrice().toString().farsiNumber,
                                style: TextStyle(
                                  fontFamily: Constants.vazirFont,
                                  color: Constants.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'جمع کل',
                            style: TextStyle(
                              fontFamily: Constants.vazirFont,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

Future<dynamic> getDeleteConfirm(
  BuildContext context,
) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          'سبد خرید',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Constants.blackColor,
            fontFamily: Constants.danaFont,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'محصول از سبد خرید حذف شود؟',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Constants.blackColor,
            fontFamily: Constants.danaFont,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  'بله',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: Constants.vazirFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'خیر',
                  style: TextStyle(
                    color: Colors.green,
                    fontFamily: Constants.vazirFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
