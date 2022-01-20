import 'package:http/http.dart';
import 'package:appointing_mobile/constraints/custom_strings.dart';

class PatientTestService {
  CustomString api = CustomString();
  //update_patient_post_appointment
  Future insertTest(var patient, String id) async {
    Response response = await put("${api.endPoint}/patientTest/$id",
        body: patient, headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "can't post test";
    }
  }

  Future cancelAppointment(var test, String patientId, int testId) async {
    Response response = await put(
        "${api.endPoint}/patientTestStatus/$patientId/$testId",
        body: test,
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "can't cancel test";
    }
  }
}
