import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:planet_app/widgets/extension.dart';

import '../constants/constants.dart';
import 'package:planet_app/models/plant.dart';
import '../screens/detail_page.dart';

class NewPlantWidget extends StatelessWidget {
  const NewPlantWidget({
    super.key,
    required List<Plant> plantList,
    required this.size,
    required this.index,
  }) : _plantList = plantList;

  final List<Plant> _plantList;
  final Size size;
  final int index;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageTransition(
          child: DetailPage(plantId: _plantList[index].plantId),
          type: PageTransitionType.fade,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        padding: const EdgeInsets.only(right: 10, left: 10),
        height: 80,
        width: size.width,
        decoration: BoxDecoration(
          color: Constants.primary.withOpacity(0.13),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
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
                  _plantList[index].price.toString().farsiNumber,
                  style: TextStyle(
                    fontFamily: Constants.vazirFont,
                    color: Constants.primary,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Constants.primary.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 0,
                  left: 0,
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      _plantList[index].imageURL,
                    ),
                  ),
                ),
                Positioned(
                  right: 80,
                  bottom: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        _plantList[index].category,
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: Constants.danaFont,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _plantList[index].plantName,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: Constants.vazirFont,
                          color: Constants.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
