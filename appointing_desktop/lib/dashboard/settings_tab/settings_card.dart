import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  String name;
  Function onPressed;
  SettingsCard({this.name, this.onPressed});
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 30,
        margin: EdgeInsets.all(60),
        child: Container(
          margin: EdgeInsets.all(40),
          color: Colors.white,
          width: mediaQuery.size.width * .25,
          height: mediaQuery.size.height * .15,
          child: Column(
            children: [
              Icon(
                Icons.add,
                size: 60,
                color: Colors.grey[400],
              ),
              Text(
                name,
                style: TextStyle(color: Colors.grey[400], fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
