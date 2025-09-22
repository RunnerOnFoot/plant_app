import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:planet_app/constants/constants.dart';
import 'package:planet_app/screens/root.dart';
import '../widgets/extension.dart';
import 'package:planet_app/models/plant.dart';
import '../widgets/get_alert_dialog.dart';
import '../widgets/plant_feature.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.plantId,
  });
  final int plantId;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool toggleIsSelected(bool isSelected) {
    return !isSelected;
  }

  List<Plant> plantList = Plant.plantList;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            //Appbar
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //X button
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Constants.primary.withOpacity(0.13),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                      color: Constants.primary,
                    ),
                  ),
                  //Like Button
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Constants.primary.withOpacity(0.13),
                    ),
                    child: Icon(
                      plantList[widget.plantId].isFavorated
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Constants.primary,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(20),
                width: size.width * 0.8,
                height: size.height * 0.8,
                child: Stack(
                  children: <Widget>[
                    //Product Image
                    Positioned(
                      top: 10,
                      left: 0,
                      child: SizedBox(
                        width: 200,
                        height: 280,
                        child: Image.asset(plantList[widget.plantId].imageURL),
                      ),
                    ),
                    //plan Feature
                    Positioned(
                      top: 10,
                      right: 10,
                      child: SizedBox(
                        height: 207,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            PlantFeature(
                              title: 'اندازه گیاه',
                              plantFeature: plantList[widget.plantId].size,
                            ),
                            PlantFeature(
                              title: 'رطوبت هوا',
                              plantFeature: plantList[widget.plantId]
                                  .humidity
                                  .toString()
                                  .farsiNumber,
                            ),
                            PlantFeature(
                              title: 'دمای نگهداری',
                              plantFeature: plantList[widget.plantId]
                                  .temperature
                                  .farsiNumber,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(top: 60, right: 30, left: 30),
                width: size.width,
                height: size.height * 0.5,
                decoration: BoxDecoration(
                  color: Constants.primary.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      plantList[widget.plantId].plantName,
                      style: TextStyle(
                        fontFamily: Constants.vazirFont,
                        fontWeight: FontWeight.bold,
                        color: Constants.primary,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Constants.primary,
                              size: 25,
                            ),
                            Text(
                              plantList[widget.plantId]
                                  .rating
                                  .toString()
                                  .farsiNumber,
                              style: TextStyle(
                                fontFamily: Constants.vazirFont,
                                fontWeight: FontWeight.bold,
                                color: Constants.primary,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: Image.asset(
                                  'assets/images/PriceUnit-green.png'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              plantList[widget.plantId]
                                  .price
                                  .toString()
                                  .farsiNumber,
                              style: TextStyle(
                                fontFamily: Constants.vazirFont,
                                fontWeight: FontWeight.bold,
                                color: Constants.blackColor,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      plantList[widget.plantId].decription,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontFamily: Constants.danaFont,
                        fontSize: 18,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Constants.primary.withOpacity(0.6),
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: RootPage(
                                      initialPage: 2,
                                    ),
                                    type: PageTransitionType.fade,
                                  ),
                                );
                              });
                            },
                            icon: const Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(260, 50),
                            backgroundColor: Constants.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            setState(
                              () {
                                bool isSelected = toggleIsSelected(
                                    plantList[widget.plantId].isSelected);
                                plantList[widget.plantId].isSelected =
                                    isSelected;
                              },
                            );
                            if (plantList[widget.plantId].isSelected == true) {
                              getAlertDialog(
                                  context,
                                  'محصول به سبد خرید اضافه شد',
                                  Constants.primary);
                            } else {
                              getAlertDialog(context,
                                  'محصول از سبد خرید پاک شد', Colors.redAccent);
                            }
                          },
                          child: const Text(
                            'افزودن به سبد خرید',
                            style: TextStyle(
                              fontFamily: Constants.vazirFont,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
