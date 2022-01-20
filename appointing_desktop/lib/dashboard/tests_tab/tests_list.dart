import 'package:appointing_desktop/change_notifier/test_provider.dart';
import 'package:appointing_desktop/dashboard/tests_tab/tests_card.dart';
import 'package:appointing_desktop/models/test.dart';
import 'package:appointing_desktop/services/test_service.dart';
import 'package:appointing_desktop/widgets/custom_text_dark.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestsTab extends StatefulWidget {
  @override
  _TestsTabState createState() => _TestsTabState();
}

class _TestsTabState extends State<TestsTab> {
  final TestService testService = TestService();
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
                flex: 1,
                child: CustomTextDark(
                  name: "Name",
                )),
            Expanded(
                flex: 1,
                child: CustomTextDark(
                  name: "Fee",
                )),
            Expanded(
                flex: 1,
                child: CustomTextDark(
                  name: "Description",
                )),
            Expanded(
              flex: 2,
              child: Text(
                "",
              ),
            ),
          ],
        ),
        Divider(),
        Expanded(child:
            Consumer<TestProvider>(builder: (context, testProvider, child) {
          List<Test> test = testProvider.test;
          return test.length == 0
              ? Center(
                  child: CustomTextDark(
                    name: "No Tests available",
                  ),
                )
              : ListView.builder(
                  itemCount: test.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: TestsCard(app: test[index], index: index),
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
