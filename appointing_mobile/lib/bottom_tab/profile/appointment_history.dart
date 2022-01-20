import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:appointing_mobile/models/appointment.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class AppointmentHistory extends StatefulWidget {
  List<Appointment> appointment;
  AppointmentHistory(this.appointment);
  @override
  _AppointmentHistoryState createState() => _AppointmentHistoryState();
}

class _AppointmentHistoryState extends State<AppointmentHistory> {
  CustomColors _colors = CustomColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: _colors.colorTheme,
        elevation: 0.0,
        title: Text(
          ("Appointment History"),
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF39927B)),
          textAlign: TextAlign.left,
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: _colors.colorTheme,
      body: widget.appointment.isEmpty
          ? Center(
              child: Text("No appointments yet",
                  style: TextStyle(
                      color: _colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
            )
          : ListView.builder(
              itemCount: widget.appointment.length,
              itemBuilder: (context, i) {
                return AppointmentTestCard(
                  appointment: widget.appointment[i],
                );
              }),
    );
  }
}

class AppointmentTestCard extends StatelessWidget {
  CustomColors _colors = CustomColors();

  Appointment appointment;
  AppointmentTestCard({this.appointment});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 10, left: 15, right: 15),
      child: NeuCard(
        color: _colors.colorTheme,
        bevel: 8,
        curveType: CurveType.flat,
        decoration: NeumorphicDecoration(
            borderRadius: BorderRadius.circular(15), color: _colors.colorTheme),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appointment.date,
                    style: TextStyle(color: _colors.white, fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 17),
                    child: Text(appointment.time,
                        style: TextStyle(
                            color: _colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800)),
                  )
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(appointment.doctor.name,
                      style: TextStyle(
                        color: _colors.white,
                        fontSize: 16,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 17, top: 5),
                    child: NeuCard(
                      color: _colors.colorTheme,
                      bevel: 15,
                      curveType: CurveType.emboss,
                      decoration: NeumorphicDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: _colors.colorTheme),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 7, right: 7, top: 4, bottom: 4),
                          child: Text(
                              appointment.state ? "In Progress" : "Completed",
                              style: TextStyle(
                                  color: _colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
