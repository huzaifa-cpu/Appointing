import 'dart:convert';
import 'dart:io';

import 'package:appointing_desktop/change_notifier/doctor_provider.dart';
import 'package:appointing_desktop/constraints/custom_colors.dart';
import 'package:appointing_desktop/models/doctor.dart';
import 'package:appointing_desktop/services/doctor_service.dart';
import 'package:appointing_desktop/widgets/custom_button.dart';
import 'package:appointing_desktop/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditDoctor extends StatefulWidget {
  Doctor doc;
  bool isAdd;
  EditDoctor({this.doc, this.isAdd});
  @override
  _EditDoctorState createState() => _EditDoctorState();
}

class _EditDoctorState extends State<EditDoctor> {
  String base64Image; //(Save that String in AVATAR field of API)

  // Future openWindow() async {
  //   var image2 = await showOpenPanel(allowsMultipleSelection: true);
  //   File path = File(image2.paths[0]);
  //   List<int> imageBytes = path.readAsBytesSync();
  //   setState(() {
  //     base64Image = base64Encode(imageBytes);
  //   });
  //   print('string is: $base64Image');
  // }

  CustomColors _colors = CustomColors();
  final DoctorService doctorService = DoctorService();
  final _formKey = GlobalKey<FormState>();
  String name;
  String fee;
  String opd;
  String specialization;
  double height = 520;
  bool load = false;

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
                widget.isAdd
                    ? GestureDetector(
                        onTap: () {
                          // openWindow();
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: _colors.purple, width: 1),
                              borderRadius: BorderRadius.circular(200),
                              image: DecorationImage(
                                  image: base64Image == null
                                      ? AssetImage("images/profile_image.jpg")
                                      : MemoryImage(
                                          Base64Decoder().convert(base64Image)),
                                  fit: BoxFit.fill)),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          // openWindow();
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: _colors.purple, width: 1),
                              borderRadius: BorderRadius.circular(200),
                              image: DecorationImage(
                                  image: widget.doc.image == null
                                      ? AssetImage("images/profile_image.jpg")
                                      : MemoryImage(Base64Decoder()
                                          .convert(widget.doc.image)),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+|\s')),
                  ],
                  labelText: "Name",
                  initialValue: widget.isAdd ? null : widget.doc.name,
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
                  initialValue: widget.isAdd ? null : widget.doc.fee,
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
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z,]+|\s')),
                  ],
                  labelText: "Opd",
                  initialValue: widget.isAdd ? null : widget.doc.opd,
                  obscureText: false,
                  validation: (val) => val.isEmpty ? 'Enter opd' : null,
                  onChanged: (val) {
                    setState(() {
                      opd = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z,]+|\s')),
                  ],
                  labelText: "Specialization",
                  initialValue: widget.isAdd ? null : widget.doc.specialization,
                  obscureText: false,
                  validation: (val) =>
                      val.isEmpty ? 'Enter specialization' : null,
                  onChanged: (val) {
                    setState(() {
                      specialization = val;
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Consumer<DoctorProvider>(
                  builder: (context, doctorProvider, child) => CustomButton(
                    text: widget.isAdd ? "Add" : "Update",
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        if (widget.isAdd) {
                          Doctor doctor = Doctor(
                              name: name,
                              opd: opd,
                              specialization: specialization,
                              fee: fee,
                              image: base64Image);
                          doctorProvider.addDoctor(doctor);
                          Navigator.pop(context);
                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //     content: Text("Doctor has been created")));
                          await doctorService.postDoctor(doctor);
                        } else {
                          Doctor doctor = Doctor(
                            doctorId: widget.doc.doctorId,
                            name: name ?? widget.doc.name,
                            opd: opd ?? widget.doc.opd,
                            specialization:
                                specialization ?? widget.doc.specialization,
                            fee: fee ?? widget.doc.fee,
                            image: base64Image ?? widget.doc.image,
                          );
                          doctorProvider.updateDoctor(
                              doctor, widget.doc.doctorId);
                          Navigator.pop(context);
                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //     content: Text("Doctor has been updated")));
                          await doctorService.putDoctor(
                              doctor, widget.doc.doctorId);
                        }
                        List<Doctor> doctors =
                            await doctorService.getDoctorList();
                        doctorProvider.doctor = doctors;
                      } else {
                        setState(() {
                          height = 800;
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
