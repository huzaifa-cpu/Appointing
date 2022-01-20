import 'package:flutter/material.dart';

import '../constraints/custom_colors.dart';

class CustomButton extends StatelessWidget {
  CustomColors _colors = new CustomColors();
  VoidCallback onPressed;
  String text;
  CustomButton({this.text, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 285,
      child: RaisedButton(
        color: _colors.green,
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            fontFamily: "CenturyGothic",
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
