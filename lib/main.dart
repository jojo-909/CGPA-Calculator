import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/courses.dart';

import 'screens/home.dart';

void main() {
  runApp(GpaCalculator());
}

class GpaCalculator extends StatelessWidget {
  const GpaCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Courses(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gpa Calculator',
        theme: ThemeData(primarySwatch: Colors.grey),
        home: HomeScreen(),
      ),
    );
  }
}
