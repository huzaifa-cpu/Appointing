import 'package:flutter/material.dart';

import '../constraints/custom_colors.dart';

class CustomAlertDialog extends StatelessWidget {
  String btn1Text;
  String btn2Text;
  String title;
  Function onPressed1;
  Function onPressed2;
  CustomAlertDialog(
      {this.title,
      this.onPressed1,
      this.onPressed2,
      this.btn1Text,
      this.btn2Text});
  CustomColors _colors = CustomColors();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: _colors.white,
      title: Text(
        title,
        style: TextStyle(
          color: _colors.green,
          fontSize: 15.0,
          fontFamily: "CenturyGothic",
        ),
      ),
      actions: [
        RaisedButton(
          elevation: 0,
          onPressed: onPressed1,
          padding: EdgeInsets.all(10),
          color: _colors.white,
          child: Text(
            btn1Text,
            style: TextStyle(
              color: _colors.green,
              fontSize: 15.0,
              fontFamily: "CenturyGothic",
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        RaisedButton(
          elevation: 0,
          onPressed: onPressed2,
          padding: EdgeInsets.all(10),
          color: _colors.white,
          child: Text(
            btn2Text,
            style: TextStyle(
              color: _colors.green,
              fontSize: 15.0,
              fontFamily: "CenturyGothic",
            ),
          ),
        ),
      ],
    );
  }
}
