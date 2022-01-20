import 'package:appointing_desktop/constraints/custom_colors.dart';
import 'package:appointing_desktop/widgets/custom_text_light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  String text;
  Loader(this.text);
  CustomColors _colors = new CustomColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: _colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitCircle(
                color: _colors.green,
                size: 70,
              ),
              CustomTextLight(name: text)
            ],
          ),
        ),
      ),
    );
  }
}
