import 'package:appointing_desktop/constraints/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatelessWidget {
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
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/splash_icon.png"))),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Appointing",
                style: TextStyle(
                    fontSize: 25,
                    color: _colors.purple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              SpinKitCircle(
                color: _colors.green,
                size: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
