import 'package:appointing_desktop/change_notifier/appointment_provider.dart';
import 'package:appointing_desktop/dashboard/appointments_tab/appointments_card.dart';
import 'package:appointing_desktop/models/appointment.dart';
import 'package:appointing_desktop/services/appointment_service.dart';
import 'package:appointing_desktop/widgets/custom_text_dark.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentsTab extends StatefulWidget {
  @override
  _AppointmentsTabState createState() => _AppointmentsTabState();
}

class _AppointmentsTabState extends State<AppointmentsTab> {
  final AppointmentService appointmentService = AppointmentService();
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
                flex: 2,
                child: CustomTextDark(
                  name: "Doctor",
                )),
            Expanded(
                flex: 2,
                child: CustomTextDark(
                  name: "Patient",
                )),
            Expanded(
                flex: 2,
                child: CustomTextDark(
                  name: "Date",
                )),
            Expanded(
                flex: 2,
                child: CustomTextDark(
                  name: "Time",
                )),
            Expanded(
                flex: 2,
                child: CustomTextDark(
                  name: "Status",
                )),
            Expanded(
              flex: 2,
              child: Text(
                "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Divider(),
        Expanded(child: Consumer<AppointmentProvider>(
            builder: (context, appointmentProvider, child) {
          List<Appointment> appointment = appointmentProvider.appoint;
          return appointment.length == 0
              ? Center(
                  child: CustomTextDark(
                    name: "No appointments",
                  ),
                )
              : ListView.builder(
                  itemCount: appointment.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: AppointmentsCard(
                          app: appointment[index], index: index),
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
