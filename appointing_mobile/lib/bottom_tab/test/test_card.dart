import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:appointing_mobile/models/test.dart';
import 'package:appointing_mobile/screens/book_test.dart';
import 'package:appointing_mobile/widgets/custom_square_button.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class TestCard extends StatelessWidget {
  CustomColors _colors = CustomColors();
  Test test;
  TestCard({this.test});
  @override
  Widget build(BuildContext context) {
    void displayBottomSheet(Test test) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return BookTest(test: test);
          });
    }

    return NeuCard(
      margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      color: _colors.colorTheme,
      curveType: CurveType.flat,
      bevel: 12,
      decoration: NeumorphicDecoration(
        borderRadius: BorderRadius.circular(15),
        color: _colors.colorTheme,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  test.name,
                  style: TextStyle(
                      color: _colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  test.description,
                  style: TextStyle(
                      color: _colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  "Fee: ${test.fee}",
                  style: TextStyle(
                      color: _colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomSquareButton(
                  onPressed: () {
                    displayBottomSheet(test);
                  },
                  attribute: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: _colors.grey,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Book now",
                        style: TextStyle(fontSize: 13, color: _colors.white),
                        //textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
