import 'package:appointing_mobile/authentication/login_screen.dart';
import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:appointing_mobile/screens/loader.dart';
import 'package:appointing_mobile/screens/person_info.dart';
import 'package:appointing_mobile/services/auth_service.dart';
import 'package:appointing_mobile/widgets/custom_button.dart';
import 'package:appointing_mobile/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neumorphic/neumorphic.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  CustomColors _colors = new CustomColors();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          backgroundColor: _colors.colorTheme,
          resizeToAvoidBottomInset: false,
          body: loading
              ? Loader("Please wait...")
              : ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 25,
                          right: 25,
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          top: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Register',
                            style: TextStyle(
                                color: _colors.white,
                                fontSize: 50.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Email',
                            style:
                                TextStyle(color: _colors.white, fontSize: 15.0),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            hint: "eg. abc@gmail.com",
                            obscureText: false,
                            type: TextInputType.emailAddress,
                            validate: (val) => val.isEmpty ? '' : null,
                            onchanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Password',
                            style:
                                TextStyle(color: _colors.white, fontSize: 15.0),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            hint: "Enter 7-digit password",
                            obscureText: true,
                            validate: (val) => val.length < 6 ? '' : null,
                            onchanged: (val) {
                              setState(() => password = val);
                            },
                          ),
                          SizedBox(
                            height: 35.0,
                          ),
                          CustomButton(
                              name: "Register",
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Invalid email or password",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.grey[500],
                                        textColor: _colors.white,
                                        fontSize: 14);
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PersonInfo()));
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Data may invalid or empty",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.grey[500],
                                      textColor: _colors.white,
                                      fontSize: 14);
                                }
                              }),
                          Padding(
                            padding: EdgeInsets.only(top: 40.0),
                            child: Container(
                              height: 0.5,
                              width: 330.0,
                              color: _colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account? ",
                                    style: TextStyle(
                                        color: _colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold)),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                  child: Text("Log in",
                                      style: TextStyle(
                                          color: _colors.grey,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
    );
  }
}
