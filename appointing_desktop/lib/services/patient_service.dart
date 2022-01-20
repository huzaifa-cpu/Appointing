import 'dart:convert';

import 'package:appointing_desktop/constraints/custom_strings.dart';
import 'package:appointing_desktop/models/patient.dart';
import 'package:http/http.dart';

class PatientService {
  CustomString api = CustomString();
  Future<List<Patient>> getPatientList() async {
    Response response = await get('${api.endPoint}/patient',
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      print(body);
      List<Patient> test =
          body.map((dynamic item) => Patient.fromJson(item)).toList();
      print(test);
      return test;
    } else {
      throw "Can't get List";
    }
  }

  // delete - patient
  Future deletePatient(String id) async {
    Response response = await delete('${api.endPoint}/patient/$id',
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "Can't delete";
    }
  }
}
