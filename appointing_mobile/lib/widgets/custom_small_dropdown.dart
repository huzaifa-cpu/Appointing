import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:appointing_mobile/constraints/custom_colors.dart';

class CustomSmallDropdown extends StatelessWidget {
  String title1;
  String title2;
  Color titleColor1;
  Color titleColor2;
  Function onPressed1;
  Function onPressed2;
  Function onPressed3;
  CustomSmallDropdown(
      {this.title1,
      this.title2,
      this.titleColor1,
      this.titleColor2,
      this.onPressed1,
      this.onPressed3,
      this.onPressed2});

  //COLORS
  CustomColors _colors = CustomColors();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: _colors.colorTheme,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: onPressed3,
            child: Icon(
              Icons.keyboard_arrow_down,
              size: 50,
              color: _colors.grey,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  height: 45.0,
                  width: 150.0,
                  margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                  child: NeuButton(
                    decoration: NeumorphicDecoration(
                        color: _colors.colorTheme,
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: onPressed1,
                    child: Text(
                      title1,
                      textScaleFactor: 1.3,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: titleColor1,
                        fontFamily: "CenturyGothic",
                        fontSize: 8.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 45.0,
                  width: 150.0,
                  margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                  child: NeuButton(
                    decoration: NeumorphicDecoration(
                        color: _colors.colorTheme,
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: onPressed2,
                    child: Text(
                      title2,
                      textScaleFactor: 1.3,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: titleColor2,
                        fontFamily: "CenturyGothic",
                        fontSize: 8.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
