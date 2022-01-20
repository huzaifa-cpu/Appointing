import 'package:appointing_desktop/services/admin_service.dart';
import 'package:appointing_desktop/widgets/custom_text_dark.dart';
import 'package:flutter/material.dart';
import 'package:appointing_desktop/constraints/custom_colors.dart';

import '../constraints/custom_colors.dart';
import 'custom_button.dart';
import 'custom_textfiled.dart';

class CustomAdminPanel extends StatefulWidget {
  String title;
  String buttonText;
  bool isCancel;
  Function onPressed;
  TextEditingController email;
  TextEditingController password;

  CustomAdminPanel({
    this.isCancel,
    this.onPressed,
    this.email,
    this.password,
    this.title,
    this.buttonText,
  });
  @override
  _CustomAdminPanelState createState() => _CustomAdminPanelState();
}

class _CustomAdminPanelState extends State<CustomAdminPanel> {
  final AdminService adminService = AdminService();
  final _formKey = GlobalKey<FormState>();
  bool verified;

  CustomColors _colors = CustomColors();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
                alignment: Alignment.centerLeft,
                width: 350,
                height: height * 0.5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.isCancel
                          ? Row(
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
                            )
                          : Container(),
                      Center(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              fontFamily: "CenturyGothic",
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: _colors.purple),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: CustomTextDark(
                          name: "Username",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 30),
                          child: CustomTextfield(
                            controller: widget.email,
                            labelText: "Enter your Username",
                            hintText: "abc@xyz.com",
                            obscureText: false,
                            validate: (val) =>
                                val.isEmpty ? 'Enter a Username' : null,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: CustomTextDark(
                          name: "Password",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 30),
                          child: CustomTextfield(
                            controller: widget.password,
                            labelText: "Enter your passward",
                            hintText: "Password should be 4-Digits",
                            obscureText: true,
                            validate: (val) => val.length < 6 ? '' : null,
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: CustomButton(
                              text: widget.buttonText,
                              onPressed: widget.onPressed))
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
