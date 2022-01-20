import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:appointing_mobile/models/patient_test.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class TestHistory extends StatefulWidget {
  List<PatientTest> patientTest;
  TestHistory(this.patientTest);
  @override
  _TestHistoryState createState() => _TestHistoryState();
}

class _TestHistoryState extends State<TestHistory> {
  CustomColors _colors = CustomColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: _colors.colorTheme,
        elevation: 0.0,
        title: Text(
          ("Test History"),
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF39927B)),
          textAlign: TextAlign.left,
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: _colors.colorTheme,
      body: widget.patientTest.isEmpty
          ? Center(
              child: Text("No Booked tests yet",
                  style: TextStyle(
                      color: _colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
            )
          : ListView.builder(
              itemCount: widget.patientTest.length,
              itemBuilder: (context, i) {
                return PatientTestCard(
                  test: widget.patientTest[i],
                );
              }),
    );
  }
}

class PatientTestCard extends StatelessWidget {
  CustomColors _colors = CustomColors();

  PatientTest test;
  PatientTestCard({this.test});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 10, left: 15, right: 15),
      child: NeuCard(
        color: _colors.colorTheme,
        bevel: 8,
        curveType: CurveType.flat,
        decoration: NeumorphicDecoration(
            borderRadius: BorderRadius.circular(15), color: _colors.colorTheme),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    test.date,
                    style: TextStyle(color: _colors.white, fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 17),
                    child: Text(test.time,
                        style: TextStyle(
                            color: _colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800)),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(test.test.name,
                      style: TextStyle(
                        color: _colors.white,
                        fontSize: 16,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 17),
                    child: NeuCard(
                      color: _colors.colorTheme,
                      bevel: 15,
                      curveType: CurveType.emboss,
                      decoration: NeumorphicDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: _colors.colorTheme),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 7, right: 7, top: 4, bottom: 4),
                          child: Text(test.state ? "In progress" : "Completed",
                              style: TextStyle(
                                  color: _colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
