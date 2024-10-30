import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'attendance_provider.dart';
import 'attendence_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AttendanceProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Student Attendance',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Change the primary color here
        hintColor: Colors.black,   // Change the accent color here
        scaffoldBackgroundColor: Colors.grey[200], // Background color for scaffold
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue, // AppBar color
        ),
      ),
      // ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: AttendancePage(),
    );
  }
}