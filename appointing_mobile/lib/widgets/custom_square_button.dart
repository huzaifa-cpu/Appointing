import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:appointing_mobile/constraints/custom_colors.dart';

class CustomSquareButton extends StatelessWidget {
  CustomColors _colors = new CustomColors();
  Widget attribute;
  VoidCallback onPressed;
  CustomSquareButton({this.attribute, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: NeuCard(
            alignment: Alignment.center,
            curveType: CurveType.flat,
            bevel: 8,
            decoration: NeumorphicDecoration(
                borderRadius: BorderRadius.circular(15),
                color: _colors.colorTheme),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: attribute,
              ),
            )));
  }
}
