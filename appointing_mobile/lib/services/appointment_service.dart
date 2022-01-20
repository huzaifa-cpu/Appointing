import 'package:http/http.dart';
import 'package:appointing_mobile/constraints/custom_strings.dart';

class AppointmentService {
  CustomString api = CustomString();
  //update_patient_post_appointment
  Future insertAppointment(var patient, String id) async {
    Response response = await put("${api.endPoint}/appointment/$id",
        body: patient, headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "can't post appointment";
    }
  }

//Update state of Appointment
  Future cancelAppointment(
      var appointment, String patientId, int doctorId) async {
    Response response = await put(
        "${api.endPoint}/appointmentStatus/$patientId/$doctorId",
        body: appointment,
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "can't cancel appointment";
    }
  }
}
