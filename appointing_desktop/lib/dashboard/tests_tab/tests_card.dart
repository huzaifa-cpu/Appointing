import 'package:appointing_desktop/change_notifier/test_provider.dart';
import 'package:appointing_desktop/constraints/custom_colors.dart';
import 'package:appointing_desktop/dashboard/tests_tab/edit_test.dart';
import 'package:appointing_desktop/models/test.dart';
import 'package:appointing_desktop/screens/loader.dart';
import 'package:appointing_desktop/services/test_service.dart';
import 'package:appointing_desktop/widgets/custom_dialog.dart';
import 'package:appointing_desktop/widgets/custom_medium_button.dart';
import 'package:appointing_desktop/widgets/custom_text_light.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestsCard extends StatelessWidget {
  CustomColors _colors = new CustomColors();
  final TestService testService = TestService();

  Test app;
  int index;
  TestsCard({this.app, this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: CustomTextLight(
              name: "${(index + 1).toString()}",
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomTextLight(
              name: "${app.name}",
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomTextLight(
              name: "${app.fee}",
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomTextLight(
              name: "${app.description}",
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomMediumButton(
              name: "Edit",
              color: _colors.green,
              icon: Icons.edit,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return EditTest(
                        test: app,
                        isAdd: false,
                      );
                    });
              },
            ),
          ),
          Consumer<TestProvider>(
            builder: (context, testProvider, child) => Expanded(
              flex: 1,
              child: CustomMediumButton(
                name: "Remove",
                icon: Icons.delete,
                color: _colors.purple,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomAlertDialog(
                          title: "Remove Test?",
                          btn1Text: "Yes",
                          btn2Text: "No",
                          onPressed1: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Loader("Please wait..."),
                                ));

                            await testService.deleteTest(app.testId);
                            List<Test> tests = await testService.getTestList();
                            testProvider.test = tests;
                            Navigator.pop(context);
                            Navigator.pop(context);
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //     content: Text("Test has been deleted")));
                          },
                          onPressed2: () {
                            Navigator.pop(context);
                          },
                        );
                      });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
