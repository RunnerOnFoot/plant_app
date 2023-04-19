import 'package:flutter/material.dart';

import '../constants/constants.dart';

Future<dynamic> getAlertDialog(
    BuildContext context, String content, Color color) {
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
          content,
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
                  Navigator.pop(context);
                },
                child: Text(
                  'باشه',
                  style: TextStyle(
                    color: color,
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
