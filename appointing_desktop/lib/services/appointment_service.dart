import 'dart:convert';

import 'package:appointing_desktop/models/appointment.dart';
import 'package:http/http.dart';

import 'package:appointing_desktop/constraints/custom_strings.dart';
import 'package:appointing_desktop/models/patient.dart';
import 'package:http/http.dart';

class AppointmentService {
  CustomString api = CustomString();
  // GET - appointment List
  Future<List<Appointment>> getAppointmentList() async {
    Response response = await get('${api.endPoint}/appointment',
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      print(body);
      List<Appointment> appointment =
          body.map((dynamic item) => Appointment.fromJson(item)).toList();
      print(appointment);
      return appointment;
    } else {
      throw "Can't get List";
    }
  }

  //post_patient_post_appointment
  Future postAppointment(Patient patient) async {
    var patientJson = jsonEncode(patient);
    print(patientJson);
    Response response = await post("${api.endPoint}/appointment",
        body: patientJson, headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "can't post appointment";
    }
  }

  //Update state of Appointment
  Future cancelAppointment(
      var appointment, String patientId, int doctorId) async {
    var appointmentJson = jsonEncode(appointment);
    Response response = await put(
        "${api.endPoint}/appointmentStatus/$patientId/$doctorId",
        body: appointmentJson,
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "can't cancel appointment";
    }
  }
}
