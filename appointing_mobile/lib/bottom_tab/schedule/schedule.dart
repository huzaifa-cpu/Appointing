import 'package:appointing_mobile/bottom_tab/schedule/my_appointment.dart';
import 'package:appointing_mobile/bottom_tab/schedule/my_test.dart';
import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:flutter/material.dart';


class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  int pages = 0;
  final options = [AppointmentList(), MyTest()];
  CustomColors _colors = CustomColors();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: _colors.colorTheme,
          appBar: AppBar(
            backgroundColor: _colors.colorTheme,
            elevation: 0.0,
            title: Center(
                child: Text(
              "My Schedule",
              style: TextStyle(
                fontSize: 22,
                color: _colors.white,
              ),
            )),
            bottom: TabBar(
              indicatorColor: _colors.grey,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    "Appointments",
                    textScaleFactor: 1.0,
                    style: TextStyle(color: _colors.white),
                  ),
                ),
                Tab(
                  child: Text(
                    "Tests",
                    textScaleFactor: 1.0,
                    style: TextStyle(color: _colors.white),
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(children: options),
        ));
  }
}
