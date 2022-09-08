import 'package:flutter/widgets.dart';

class Course {
  String code;
  String? title;
  int unit;
  String grade;

  Course(
      {required this.code,
      required this.unit,
      required,
      required this.grade,
      this.title});
  final Map<String, int> gpaMap = {
    'A': 5,
    'B': 4,
    'C': 3,
    'D': 2,
    'E': 1,
    'F': 0
  };

  int get gpa {
    return gpaMap[grade] as int;
  }
}

