import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:appointing_mobile/constraints/custom_colors.dart';

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
      backgroundColor: _colors.colorTheme,
      title: Text(
        title,
        style: TextStyle(color: _colors.white, fontSize: 15.0),
      ),
      actions: [
        GestureDetector(
          onTap: onPressed1,
          child: NeuCard(
            bevel: 4,
            padding: EdgeInsets.all(10),
            color: _colors.colorTheme,
            child: Text(
              btn1Text,
              style: TextStyle(color: _colors.white, fontSize: 15.0),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: onPressed2,
          child: NeuCard(
            bevel: 4,
            padding: EdgeInsets.all(10),
            color: _colors.colorTheme,
            child: Text(
              btn2Text,
              style: TextStyle(color: _colors.white, fontSize: 15.0),
            ),
          ),
        ),
      ],
    );
  }
}
