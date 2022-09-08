import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';

class Courses with ChangeNotifier {
  List<Course> _courses = [
    Course(code: 'GEG 114', unit: 2, grade: 'C'),
    Course(code: 'GEG 112', unit: 3, grade: 'A'),
    Course(code: 'GEG 122', unit: 1, grade: 'B')
  ];
  int _deletedIndex = 0;
  Course _deletedCourse = Course(code: '', unit: 0, grade: '');

  List<Course> get courseList {
    return [..._courses];
  }

  void addCourse(Course course) {
    try {
      if (_courses.any((element) => element.code == course.code)) {
        // print('Course code already exists and would be edited');
        _courses[_courses
            .indexWhere((element) => element.code == course.code)] = course;
      } else {
        _courses.add(course);
      }
    } catch (error) {
      print('There was an error adding to the courselist');
    }
    notifyListeners();
  }

  double getCgpa() {
    if (_courses.length != 0) {
      double unit_total = _courses.fold(0, (prev, course) {
        return prev + course.unit;
      });
      double gpa_total =
          _courses.fold(0, (prev, course) => prev + (course.gpa * course.unit));
      double total = gpa_total / unit_total;
      return total;
    } else {
      return 0;
    }
  }

  void deleteCourse(Course course) {
    try {
      _deletedIndex =
          _courses.indexWhere((element) => element.code == course.code);
      _deletedCourse = _courses[_deletedIndex];
      _courses.removeAt(_deletedIndex);
    } catch (error) {
      print('There was an error deleting this course');
    }
    notifyListeners();
  }

  void deleteAll() {
    _courses.clear();
    notifyListeners();
  }
}
