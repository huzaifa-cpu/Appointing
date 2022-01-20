import 'package:appointing_desktop/change_notifier/patient_provider.dart';
import 'package:appointing_desktop/dashboard/patients_tab/patient_info.dart';
import 'package:appointing_desktop/models/patient.dart';
import 'package:appointing_desktop/screens/loader.dart';
import 'package:appointing_desktop/services/patient_service.dart';
import 'package:appointing_desktop/widgets/custom_dialog.dart';
import 'package:appointing_desktop/widgets/custom_medium_button.dart';
import 'package:appointing_desktop/widgets/custom_text_light.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constraints/custom_colors.dart';

class PatientsCard extends StatelessWidget {
  CustomColors _colors = new CustomColors();
  PatientService patientService = PatientService();
  Patient patient;
  int index;
  PatientsCard({this.patient, this.index});
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
              name: "${patient.name}",
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomTextLight(
              name: "${patient.age}",
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomTextLight(
              name: "${patient.gender}",
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomTextLight(
              name: "${patient.phoneNumber}",
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomMediumButton(
              name: "View",
              color: _colors.green,
              icon: Icons.remove_red_eye,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return PatientInfo(patient);
                    });
              },
            ),
          ),
          Consumer<PatientProvider>(
            builder: (context, patientProvider, child) => Expanded(
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
                          title: "Remove Patient?",
                          btn1Text: "Yes",
                          btn2Text: "No",
                          onPressed1: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Loader("Please wait..."),
                                ));
                            await patientService
                                .deletePatient(patient.patientId);
                            List<Patient> patients =
                                await patientService.getPatientList();
                            patientProvider.patient = patients;
                            Navigator.pop(context);
                            Navigator.pop(context);
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //     content: Text("Patient has been deleted")));
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
