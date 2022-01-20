import 'dart:convert';

import 'package:appointing_desktop/constraints/custom_strings.dart';
import 'package:appointing_desktop/models/test.dart';
import 'package:http/http.dart';

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

  // GET - Doctor
  Future<Test> getTest(int id) async {
    Response response = await get('${api.endPoint}/test/$id',
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      print(body);
      Test test = Test.fromJson(body);
      print(test);
      return test;
    } else {
      throw "Can't get test";
    }
  }

  // Post - Test
  Future postTest(Test test) async {
    var testJson = jsonEncode(test);
    Response response = await post('${api.endPoint}/test',
        body: testJson, headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "Can't post";
    }
  }

  // Put - Test
  Future putTest(Test test, int id) async {
    var testJson = jsonEncode(test);
    Response response = await put('${api.endPoint}/test/$id',
        body: testJson, headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "Can't put";
    }
  }

  // delete - Test
  Future deleteTest(int id) async {
    Response response = await delete('${api.endPoint}/test/$id',
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "Can't delete";
    }
  }
}
