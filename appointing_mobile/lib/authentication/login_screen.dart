import 'package:appointing_mobile/authentication/registration.dart';
import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:appointing_mobile/screens/loader.dart';
import 'package:appointing_mobile/services/auth_service.dart';
import 'package:appointing_mobile/widgets/custom_button.dart';
import 'package:appointing_mobile/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neumorphic/neumorphic.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  CustomColors _colors = CustomColors();
  // text field state
  String email = '';
  String password = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    ///
    double scaffoldHeigth = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    ///
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
                            'Login',
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
                            type: TextInputType.emailAddress,
                            hint: "eg. abc@gmail.com",
                            obscureText: false,
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
                              name: "Login",
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Error login",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.grey[500],
                                        textColor: _colors.white,
                                        fontSize: 14);
                                  } else {
                                    setState(() {
                                      loading = false;
                                    });
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
                                Text("Don't have an account? ",
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
                                                Registration()));
                                  },
                                  child: Text("Register",
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
