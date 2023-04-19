import 'package:flutter/material.dart';

import '../constants/constants.dart';

class BuildProfileOption extends StatelessWidget {
  const BuildProfileOption({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.arrow_back_ios,
            size: 16,
            color: Constants.blackColor.withOpacity(0.4),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontFamily: Constants.danaFont,
                  color: Constants.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                icon,
                color: Constants.blackColor.withOpacity(0.5),
                size: 23,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
