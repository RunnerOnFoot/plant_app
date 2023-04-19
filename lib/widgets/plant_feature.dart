import 'package:flutter/material.dart';

import '../constants/constants.dart';

class PlantFeature extends StatelessWidget {
  const PlantFeature({
    super.key,
    required this.title,
    required this.plantFeature,
  });

  final String title;
  final String plantFeature;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: Constants.blackColor,
            fontFamily: Constants.danaFont,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          plantFeature,
          style: TextStyle(
            color: Constants.primary,
            fontFamily: Constants.vazirFont,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
