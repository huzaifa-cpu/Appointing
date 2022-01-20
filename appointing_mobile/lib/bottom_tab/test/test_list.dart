import 'package:appointing_mobile/bottom_tab/test/test_card.dart';
import 'package:appointing_mobile/change_notifier/test_provider.dart';
import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:appointing_mobile/models/test.dart';
import 'package:appointing_mobile/services/test_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestListState();
  }
}

class _TestListState extends State<TestList> {
  final TestService testService = TestService();
  int count;

  @override
  Widget build(BuildContext context) {
    CustomColors _colors = CustomColors();
    return Scaffold(
      backgroundColor: _colors.colorTheme,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(
            "Tests",
            style: TextStyle(
              fontSize: 22.0,
              color: _colors.white,
            ),
          ),
          backgroundColor: _colors.colorTheme,
          centerTitle: true,
          bottomOpacity: 0.0,
          elevation: 0.0),
      body: Consumer<TestProvider>(builder: (context, testProvider, child) {
        List<Test> test = testProvider.test;
        return test.isEmpty
            ? Center(
                child: Text("No Tests available",
                    style: TextStyle(
                        color: _colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              )
            : ListView.builder(
                itemCount: test.length,
                itemBuilder: (context, i) {
                  return TestCard(test: test[i]);
                });
      }),
    );
  }
}
