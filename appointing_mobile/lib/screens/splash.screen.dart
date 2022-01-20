import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  CustomColors _colors = new CustomColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _colors.colorTheme,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("lib/images/splash_icon.png"))),
              ),
              SizedBox(
                height: 15,
              ),
              SpinKitCircle(
                color: _colors.grey,
                size: 60,
              ),
            ],
          ),
        ));
  }
}
