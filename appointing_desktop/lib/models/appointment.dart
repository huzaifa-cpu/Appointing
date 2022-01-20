import 'package:appointing_desktop/models/appointment_id.dart';
import 'package:appointing_desktop/models/doctor.dart';
import 'package:appointing_desktop/models/patient_extra.dart';

class Appointment {
  Appointment(
      {this.appointmentId,
      this.doctor,
      this.date,
      this.time,
      this.state,
      this.patient});

  AppointmentId appointmentId;
  Doctor doctor;
  String date;
  String time;
  PatientExtra patient;
  bool state;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        appointmentId: AppointmentId.fromJson(json["appointmentId"]),
        doctor: Doctor.fromJson(json["doctor"]),
        date: json["date"],
        time: json["time"],
        state: json["state"],
        patient: PatientExtra.fromJson(json["patient"]),
      );

  Map<String, dynamic> toJson() => {
        "appointmentId": appointmentId.toJson(),
        "doctor": doctor.toJson(),
        "date": date,
        "time": time,
        "state": state,
        "patient": patient.toJson(),
      };
}
