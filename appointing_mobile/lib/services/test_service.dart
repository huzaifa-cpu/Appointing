import 'dart:convert';

import 'package:appointing_mobile/models/test.dart';
import 'package:http/http.dart';
import 'package:appointing_mobile/constraints/custom_strings.dart';

class TestService {
  CustomString api = CustomString();
  Future<List<Test>> getTestList() async {
    Response response = await get('${api.endPoint}/test',
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      print(body);
      List<Test> test =
          body.map((dynamic item) => Test.fromJson(item)).toList();
      print(test);
      return test;
    } else {
      throw "Can't get List";
    }
  }
}
