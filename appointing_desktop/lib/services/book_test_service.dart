import 'dart:convert';

import 'package:appointing_desktop/constraints/custom_strings.dart';
import 'package:appointing_desktop/models/booked_test.dart';
import 'package:appointing_desktop/models/patient.dart';
import 'package:http/http.dart';

class PatientTestService {
  CustomString api = CustomString();
  // GET - patientTest List
  Future<List<PatientTest>> getPatientTestList() async {
    Response response = await get('${api.endPoint}/patientTest',
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      print(body);
      List<PatientTest> patientTest =
          body.map((dynamic item) => PatientTest.fromJson(item)).toList();
      print(patientTest);
      return patientTest;
    } else {
      throw "Can't get List";
    }
  }

  //post_patient_post_PatientTest
  Future postPatientTest(Patient patient) async {
    var patientJson = jsonEncode(patient);
    print(patientJson);
    Response response = await post("${api.endPoint}/patientTest",
        body: patientJson, headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "can't post PatientTest";
    }
  }

  //Update state of PatientTest
  Future cancelPatientTest(
      var patientTest, String patientId, int testId) async {
    var patientTestJson = jsonEncode(patientTest);
    Response response = await put(
        "${api.endPoint}/patientTestStatus/$patientId/$testId",
        body: patientTestJson,
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "can't cancel PatientTest";
    }
  }
}
