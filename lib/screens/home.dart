import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/courses.dart';
import '../widgets/modal_form.dart';
import '../widgets/course_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  Future<dynamic> addCourse(BuildContext context, [Course? course]) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) => ModalForm(),
    );
  }

  void deleteAll(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete All Courses'),
            content: Text('Would you like to delete all the courses'),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.read<Courses>().deleteAll();
                  },
                  child: Text(
                    'Delete',
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      foregroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<Courses>();
    final courseList = courses.courseList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gpa Calculator'),
        centerTitle: true,
      ),
      floatingActionButton:
        Row(
          mainAxisAlignment: MainAxisAlignment.end, 
          children: [
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => addCourse(context),
              foregroundColor: Colors.white,
              // backgroundColor: Colors.amberAccent,
            ),
            SizedBox(width: 20,),
            FloatingActionButton(
              child: Icon(Icons.delete),
              onPressed: () => deleteAll(context),
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
          ]
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          children: [
                        TextSpan(
                            text: 'Current CGPA :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                            text: ' ${courses.getCgpa().toStringAsFixed(2)}')
                      ])),
                  ElevatedButton(
                    child: Text('Add course'),
                    onPressed: () => addCourse(context),
                  )
                ],
              ),
            ),
            if (courseList.isNotEmpty) Text('Courses'),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: courseList.length,
              itemBuilder: (ctx, i) {
                return CourseCard(courseList[i]);
              },
            )
          ],
        ),
      ),
    );
  }
}

