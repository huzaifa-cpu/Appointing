import 'package:appointing_desktop/change_notifier/doctor_provider.dart';
import 'package:appointing_desktop/change_notifier/test_provider.dart';
import 'package:appointing_desktop/constraints/custom_colors.dart';
import 'package:appointing_desktop/dashboard/doctors_tab/edit_doctor.dart';
import 'package:appointing_desktop/dashboard/settings_tab/settings_card.dart';
import 'package:appointing_desktop/dashboard/tests_tab/edit_test.dart';
import 'package:appointing_desktop/screens/create_patient.dart';
import 'package:appointing_desktop/services/doctor_service.dart';
import 'package:appointing_desktop/services/test_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatelessWidget {
  final DoctorService doctorService = DoctorService();
  final TestService testService = TestService();
  CustomColors _colors = CustomColors();
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              SettingsCard(
                name: "Add Doctor",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return EditDoctor(
                          isAdd: true,
                        );
                      });
                },
              ),
              SizedBox(
                width: 30,
              ),
              SettingsCard(
                name: "Add Test",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return EditTest(
                          isAdd: true,
                        );
                      });
                },
              )
            ],
          ),
          Row(
            children: [
              Consumer<DoctorProvider>(
                  builder: (context, doctorProvider, child) {
                if (doctorProvider.doctor.isNotEmpty) {
                  return SettingsCard(
                    name: "Book Appointment",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CreatePatient(
                              isTest: false,
                            );
                          });
                    },
                  );
                } else {
                  return SettingsCard(
                    name: "No Doctors available",
                    onPressed: () {},
                  );
                }
              }),
              SizedBox(
                width: 30,
              ),
              Consumer<TestProvider>(builder: (context, testProvider, child) {
                if (testProvider.test.isNotEmpty) {
                  return SettingsCard(
                    name: "Book Test",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CreatePatient(
                              isTest: true,
                            );
                          });
                    },
                  );
                } else {
                  return SettingsCard(
                    name: "No Tests available",
                    onPressed: () {},
                  );
                }
              }),
            ],
          )
        ],
      ),
    );
  }
}
