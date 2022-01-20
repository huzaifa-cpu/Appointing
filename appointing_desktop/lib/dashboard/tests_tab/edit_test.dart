import 'package:appointing_desktop/change_notifier/test_provider.dart';
import 'package:appointing_desktop/constraints/custom_colors.dart';
import 'package:appointing_desktop/models/test.dart';
import 'package:appointing_desktop/services/test_service.dart';
import 'package:appointing_desktop/widgets/custom_button.dart';
import 'package:appointing_desktop/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditTest extends StatefulWidget {
  Test test;
  bool isAdd;
  EditTest({this.test, this.isAdd});
  @override
  _EditTestState createState() => _EditTestState();
}

class _EditTestState extends State<EditTest> {
  CustomColors _colors = CustomColors();
  final TestService testService = TestService();
  final _formKey = GlobalKey<FormState>();
  String name;
  String fee;
  String description;
  double height = 330;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AlertDialog(
          content: Container(
            height: height,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel,
                        color: _colors.purple,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+|\s')),
                  ],
                  labelText: "Name",
                  initialValue: widget.isAdd ? null : widget.test.name,
                  obscureText: false,
                  validation: (val) => val.isEmpty ? 'Enter name' : null,
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  labelText: "Fee",
                  initialValue: widget.isAdd ? null : widget.test.fee,
                  obscureText: false,
                  validation: (val) => val.isEmpty ? 'Enter fee' : null,
                  onChanged: (val) {
                    setState(() {
                      fee = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+|\s')),
                  ],
                  labelText: "Description",
                  initialValue: widget.isAdd ? null : widget.test.description,
                  obscureText: false,
                  validation: (val) => val.isEmpty ? 'Enter description' : null,
                  onChanged: (val) {
                    setState(() {
                      description = val;
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Consumer<TestProvider>(
                  builder: (context, testProvider, child) => CustomButton(
                    text: widget.isAdd ? "Add" : "Update",
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        if (widget.isAdd) {
                          Test test = Test(
                            name: name,
                            description: description,
                            fee: fee,
                          );
                          testProvider.addTest(test);
                          Navigator.pop(context);
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text("Test has been created")));
                          await testService.postTest(test);
                        } else {
                          Test test = Test(
                            testId: widget.test.testId,
                            name: name ?? widget.test.name,
                            description: description ?? widget.test.description,
                            fee: fee ?? widget.test.fee,
                          );
                          testProvider.updateTest(test, widget.test.testId);
                          Navigator.pop(context);
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text("Test has been updated")));
                          await testService.putTest(test, widget.test.testId);
                        }
                        List<Test> tests = await testService.getTestList();
                        testProvider.test = tests;
                      } else {
                        setState(() {
                          height = 400;
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
