import 'package:appointing_desktop/change_notifier/doctor_provider.dart';
import 'package:appointing_desktop/dashboard/doctors_tab/edit_doctor.dart';
import 'package:appointing_desktop/models/doctor.dart';
import 'package:appointing_desktop/screens/loader.dart';
import 'package:appointing_desktop/services/doctor_service.dart';
import 'package:appointing_desktop/widgets/custom_dialog.dart';
import 'package:appointing_desktop/widgets/custom_medium_button.dart';
import 'package:appointing_desktop/widgets/custom_text_light.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constraints/custom_colors.dart';

class DoctorsCard extends StatelessWidget {
  CustomColors _colors = new CustomColors();
  final DoctorService doctorService = DoctorService();
  Doctor doctor;
  int index;
  DoctorsCard({this.doctor, this.index});
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
              name: "${doctor.name}",
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomTextLight(
              name: "${doctor.fee}",
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomTextLight(
              name: "${doctor.opd}",
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomTextLight(
              name: "${doctor.specialization}",
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
                      return EditDoctor(
                        isAdd: false,
                        doc: doctor,
                      );
                    });
              },
            ),
          ),
          Consumer<DoctorProvider>(
            builder: (context, doctorProvider, child) => Expanded(
              flex: 1,
              child: CustomMediumButton(
                name: "Remove",
                color: _colors.purple,
                icon: Icons.delete,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomAlertDialog(
                          title: "Remove Doctor?",
                          btn1Text: "Yes",
                          btn2Text: "No",
                          onPressed1: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Loader("Please wait...")));
                            await doctorService.deleteDoctor(doctor.doctorId);
                            List<Doctor> doctors =
                                await doctorService.getDoctorList();
                            doctorProvider.doctor = doctors;
                            Navigator.pop(context);
                            Navigator.pop(context);
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //     content: Text("Doctor has been deleted")));
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
