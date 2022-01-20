import 'package:appointing_desktop/change_notifier/patient_test_provider.dart';
import 'package:appointing_desktop/dashboard/booked_tests_tab/booked_tests_card.dart';
import 'package:appointing_desktop/models/booked_test.dart';
import 'package:appointing_desktop/services/book_test_service.dart';
import 'package:appointing_desktop/widgets/custom_text_dark.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookedTestsTab extends StatefulWidget {
  @override
  _TestsTabState createState() => _TestsTabState();
}

class _TestsTabState extends State<BookedTestsTab> {
  final PatientTestService patientTestService = PatientTestService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: CustomTextDark(
                  name: "No",
                )),
            Expanded(
                flex: 2,
                child: CustomTextDark(
                  name: "Test",
                )),
            Expanded(
                flex: 2,
                child: CustomTextDark(
                  name: "Patient",
                )),
            Expanded(
                flex: 2,
                child: CustomTextDark(
                  name: "Date",
                )),
            Expanded(
                flex: 2,
                child: CustomTextDark(
                  name: "Time",
                )),
            Expanded(
                flex: 2,
                child: CustomTextDark(
                  name: "Status",
                )),
            Expanded(
              flex: 2,
              child: Text(
                "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Divider(),
        Expanded(child: Consumer<PatientTestProvider>(
            builder: (context, patientTestProvider, child) {
          List<PatientTest> patientTest = patientTestProvider.test;
          return patientTest.length == 0
              ? Center(
                  child: CustomTextDark(
                    name: "No Booked Tests",
                  ),
                )
              : ListView.builder(
                  itemCount: patientTest.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: BookedTestsCard(
                          app: patientTest[index], index: index),
                    );
                  },
                );
        })),
        SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}
