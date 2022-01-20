import 'package:appointing_mobile/models/test.dart';
import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier {
  List<Test> _test = [
    Test(testId: null, fee: null, description: null, name: null)
  ];

  List<Test> get test => _test;

  set test(List<Test> value) {
    _test = value;
    notifyListeners();
  }

  //ADD
  void addTest(Test test) {
    _test.add(test);
    notifyListeners();
  }

  //UPDATE
  void updateTest(Test test, int id) {
    for (var i in _test) {
      if (i.testId == id) {
        i.testId = test.testId;
        i.name = test.name;
        i.description = test.description;
        i.fee = test.fee;
        notifyListeners();
      }
    }
  }

  //DELETE
  void deleteTest(Test test, int id) {
    for (var i in _test) {
      if (i.testId == id) {
        _test.remove(test);
        notifyListeners();
      }
    }
  }
}
