import 'package:appointing_desktop/change_notifier/doctor_provider.dart';
import 'package:appointing_desktop/models/doctor.dart';
import 'package:appointing_desktop/services/doctor_service.dart';
import 'package:appointing_desktop/widgets/custom_text_dark.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'doctors_card.dart';

class DoctorsTab extends StatefulWidget {
  @override
  _DoctorsTabState createState() => _DoctorsTabState();
}

class _DoctorsTabState extends State<DoctorsTab> {
  final DoctorService doctorService = DoctorService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: CustomTextDark(
                  name: "No",
                )),
            Expanded(
                flex: 1,
                child: CustomTextDark(
                  name: "Name",
                )),
            Expanded(
                flex: 1,
                child: CustomTextDark(
                  name: "Fee",
                )),
            Expanded(
                flex: 1,
                child: CustomTextDark(
                  name: "Opd",
                )),
            Expanded(
                flex: 1,
                child: CustomTextDark(
                  name: "Specialization",
                )),
            Expanded(
              flex: 2,
              child: Text(
                "",
              ),
            ),
          ],
        ),
        Divider(),
        Expanded(child:
            Consumer<DoctorProvider>(builder: (context, doctorProvider, child) {
          List<Doctor> doctor = doctorProvider.doctor;
          return doctor.length == 0
              ? Center(
                  child: CustomTextDark(
                    name: "No Doctors available",
                  ),
                )
              : ListView.builder(
                  itemCount: doctor.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: DoctorsCard(doctor: doctor[i], index: i),
                    );
                  },
                );
        })),
        SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}
