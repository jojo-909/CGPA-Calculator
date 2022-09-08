import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/courses.dart';

class ModalForm extends StatefulWidget {
  Course? course;
  ModalForm({this.course, Key? key}) : super(key: key);

  @override
  State<ModalForm> createState() => _ModalFormState();
}

class _ModalFormState extends State<ModalForm> {
  late Course? course;
  final _formKey = GlobalKey<FormState>();
  bool _editForm = false;
  var _gradeDropdownValue = "A";
  var _unitDropdownValue = 1;
  var _newCourseInput = Course(code: '', unit: 0, grade: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    course = widget.course;
    if (course != null) {
      _editForm = true;
      _gradeDropdownValue = course!.grade;
      _unitDropdownValue = course!.unit;
      _newCourseInput =
          Course(code: course!.code, unit: course!.unit, grade: course!.grade);
    } else {}
  }

  void saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    if (!_editForm) {
      context.read<Courses>().addCourse(_newCourseInput);
      Navigator.of(context).pop(); 
    } else {
      // Navigator.of(context).pop();
      bool deleteDecision = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm Edit'),
              content: Text('Edit course ${_newCourseInput.code}?'),
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      'Edit',
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('Cancel'))
              ],
            );
          });
      if (deleteDecision) {
        context.read<Courses>().addCourse(_newCourseInput);
        Navigator.of(context).pop();
      } 
      else {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Course Code'),
                  initialValue: _newCourseInput.code,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please input a course code';
                    } else if (value.length > 8) {
                      return 'Course code too long, input a valid course code';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _newCourseInput = Course(
                        code: value.toString(),
                        unit: _newCourseInput.unit,
                        grade: _newCourseInput.grade);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Course Title'),
                  initialValue: _newCourseInput.title,
                  onSaved: (value) {
                    if (value != null && value.isNotEmpty) {
                      _newCourseInput = Course(
                          code: _newCourseInput.code,
                          unit: _newCourseInput.unit,
                          grade: _newCourseInput.grade,
                          title: value);
                    }
                  },
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Credit Units'),
                  value: _unitDropdownValue,
                  items: [
                    const DropdownMenuItem<int>(
                      value: 1,
                      child: Text('1'),
                    ),
                    const DropdownMenuItem<int>(
                      value: 2,
                      child: Text('2'),
                    ),
                    const DropdownMenuItem<int>(
                      value: 3,
                      child: Text('3'),
                    ),
                    const DropdownMenuItem<int>(
                      value: 4,
                      child: Text('4'),
                    ),
                    const DropdownMenuItem<int>(
                      value: 5,
                      child: Text('5'),
                    ),
                    const DropdownMenuItem<int>(
                      value: 6,
                      child: Text('6'),
                    ),
                    const DropdownMenuItem<int>(
                      value: 7,
                      child: Text('7'),
                    ),
                    const DropdownMenuItem<int>(
                      value: 8,
                      child: Text('8'),
                    ),
                    const DropdownMenuItem<int>(
                      value: 9,
                      child: Text('9'),
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      _unitDropdownValue = value as int;
                    });
                  },
                  onSaved: (value) {
                    _newCourseInput = Course(
                        code: _newCourseInput.code,
                        unit: value as int,
                        grade: _newCourseInput.grade,
                        title: _newCourseInput.title);
                  },
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Course Grade'),
                  value: _gradeDropdownValue,
                  items: [
                    const DropdownMenuItem<String>(
                      value: "A",
                      child: Text('A'),
                    ),
                    const DropdownMenuItem<String>(
                      value: "B",
                      child: Text('B'),
                    ),
                    const DropdownMenuItem<String>(
                      value: "C",
                      child: Text('C'),
                    ),
                    const DropdownMenuItem<String>(
                      value: "D",
                      child: Text('D'),
                    ),
                    const DropdownMenuItem<String>(
                      value: "E",
                      child: Text('E'),
                    ),
                    const DropdownMenuItem<String>(
                      value: "F",
                      child: Text('F'),
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      _gradeDropdownValue = value.toString();
                    });
                  },
                  onSaved: (value) {
                    _newCourseInput = Course(
                        code: _newCourseInput.code,
                        unit: _newCourseInput.unit,
                        grade: value as String,
                        title: _newCourseInput.title);
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: saveForm,
                    child: Text(course == null ? 'Submit' : 'Edit'))
              ],
            )));
  }
}
