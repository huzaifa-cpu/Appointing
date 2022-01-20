import 'package:flutter/material.dart';
import '../constraints/custom_colors.dart';
import 'custom_button.dart';
import 'custom_textfield.dart';

class CustomBottomSheet extends StatelessWidget {
  CustomColors _colors = new CustomColors();
  Function onPressed1;
  Function onpressed2;
  String initialValue1;
  String initialValue2;
  String initialValue3;
  Function onChanged1;
  Function onChanged2;
  Function onChanged3;
  Function validation3;
  Function validation2;
  Function validation1;
  CustomBottomSheet(
      {this.onPressed1,
      this.onpressed2,
      this.initialValue1,
      this.initialValue2,
      this.initialValue3,
      this.onChanged1,
      this.validation3,
      this.validation2,
      this.validation1,
      this.onChanged2,
      this.onChanged3});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          color: _colors.colorTheme,
          child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: onPressed1,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 50,
                        color: _colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    initialValue: initialValue1,
                    type: TextInputType.name,
                    onchanged: onChanged1,
                    validate: validation1,
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  CustomTextField(
                    onchanged: onChanged2,
                    initialValue: initialValue2,
                    type: TextInputType.number,
                    validate: validation2,
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  CustomTextField(
                    initialValue: initialValue3,
                    type: TextInputType.number,
                    onchanged: onChanged3,
                    validate: validation3,
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    name: "Update",
                    onPressed: onpressed2,
                  )
                ],
              ))),
    );
  }
}
