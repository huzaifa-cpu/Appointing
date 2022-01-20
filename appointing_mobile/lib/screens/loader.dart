import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:appointing_mobile/constraints/custom_colors.dart';

class Loader extends StatelessWidget {
  String text;
  Loader(this.text);
  CustomColors _colors = new CustomColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: _colors.colorTheme,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitCircle(
                color: _colors.grey,
                size: 60,
              ),
              Text(text,
                  style: TextStyle(
                    color: _colors.grey,
                    fontSize: 14.0,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
