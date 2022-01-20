import 'package:appointing_desktop/change_notifier/appointment_provider.dart';
import 'package:appointing_desktop/constraints/custom_colors.dart';
import 'package:appointing_desktop/models/appointment.dart';
import 'package:appointing_desktop/models/appointment_id.dart';
import 'package:appointing_desktop/models/doctor.dart';
import 'package:appointing_desktop/models/patient.dart';
import 'package:appointing_desktop/models/patient_extra.dart';
import 'package:appointing_desktop/screens/loader.dart';
import 'package:appointing_desktop/services/appointment_service.dart';
import 'package:appointing_desktop/services/doctor_service.dart';
import 'package:appointing_desktop/widgets/custom_button.dart';
import 'package:appointing_desktop/widgets/custom_dropdown.dart';
import 'package:appointing_desktop/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BookAppointment extends StatefulWidget {
  bool isAdd;
  Appointment app;
  PatientExtra patientExtra;
  BookAppointment({this.isAdd, this.app, this.patientExtra});
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  CustomColors _colors = CustomColors();
  final DoctorService doctorService = DoctorService();
  final AppointmentService appointmentService = AppointmentService();
  final _formKey = GlobalKey<FormState>();
  String time = "10:00-12:00 AM";
  String date;
  String doctorName;
  double height = 360;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
            future: doctorService.getDoctorList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Doctor> doctor = snapshot.data;
                List<String> names = [];
                for (var i in doctor) {
                  names.add(i.name);
                }
                return AlertDialog(
                  content: Container(
                    height: height,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                if (widget.isAdd) {
                                  Navigator.pop(context);
                                } else {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              },
                              child: Icon(
                                Icons.cancel,
                                color: _colors.purple,
                              ),
                            )
                          ],
                        ),
                        Center(
                          child: Text(
                            "Book Appointment",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                fontFamily: "CenturyGothic",
                                color: _colors.purple),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomDropDown(
                          label: "Doctor",
                          value: doctorName,
                          onChanged: (val) {
                            setState(() {
                              doctorName = val;
                            });
                          },
                          list: names,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomDropDown(
                          label: "Time",
                          value: time,
                          onChanged: (vals) {
                            setState(() {
                              time = vals;
                            });
                          },
                          list: [
                            "10:00-12:00 AM",
                            "12:00-02:00 PM",
                            "02:00-04:00 PM",
                            "04:00-06:00 PM",
                            "06:00-08:00 PM",
                            "08:00-10:00 PM"
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextfield(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9-]')),
                          ],
                          labelText: "Date",
                          initialValue: widget.isAdd ? null : widget.app.date,
                          validation: (val) =>
                              val.isEmpty ? 'Enter date' : null,
                          obscureText: false,
                          hintText: "25-10-2020",
                          onChanged: (vals) {
                            setState(() {
                              date = vals;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Consumer<AppointmentProvider>(
                          builder: (context, appointmentProvider, child) =>
                              CustomButton(
                            text: "Book",
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Loader("Booking...")));
                                if (widget.isAdd) {
                                  int doctorId;
                                  for (var i in doctor) {
                                    if (i.name == doctorName) {
                                      doctorId = i.doctorId;
                                    }
                                  }
                                  Doctor doc =
                                      await doctorService.getDoctor(doctorId);
                                  print("selected value ${doctorName}");
                                  print(doctorId);
                                  AppointmentId id = AppointmentId(
                                    doctorId: doc.doctorId,
                                    patientId: widget.patientExtra.patientId,
                                  );
                                  Appointment appointment = Appointment(
                                      appointmentId: id,
                                      doctor: doc,
                                      date: date,
                                      time: time,
                                      patient: widget.patientExtra,
                                      state: true);
                                  Patient pat = Patient(
                                    image: null,
                                    patientId: widget.patientExtra.patientId,
                                    name: widget.patientExtra.name,
                                    age: widget.patientExtra.age,
                                    gender: widget.patientExtra.gender,
                                    phoneNumber:
                                        widget.patientExtra.phoneNumber,
                                    patientTest: [],
                                    appointment: [appointment],
                                  );
                                  await appointmentService.postAppointment(pat);
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //         content:
                                  //             Text("Doctor has been booked")));
                                } else {
                                  Appointment appointment = Appointment(
                                      appointmentId: widget.app.appointmentId,
                                      doctor: widget.app.doctor,
                                      date: date ?? widget.app.date,
                                      time: time ?? widget.app.time,
                                      patient: widget.app.patient,
                                      state: true);
                                  await appointmentService.cancelAppointment(
                                      appointment,
                                      widget.app.appointmentId.patientId,
                                      widget.app.appointmentId.doctorId);

                                  Navigator.pop(context);
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //         content: Text(
                                  //             "Appointment has been rescheduled")));
                                }
                                List<Appointment> appointmentList =
                                    await appointmentService
                                        .getAppointmentList();
                                appointmentProvider.appoint = appointmentList;
                                Navigator.pop(context);
                                Navigator.pop(context);
                              } else {
                                setState(() {
                                  height = 380;
                                });
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Loader("Please wait..."),
                );
              }
            }),
      ),
    );
  }
}
