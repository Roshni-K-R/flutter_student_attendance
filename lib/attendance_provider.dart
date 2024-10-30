import 'package:flutter/material.dart';
import 'student.dart';

class AttendanceProvider extends ChangeNotifier {
  String? selectedClass;
  String? selectedSection;
  List<Student> students = [];

  // Map to store attendance data for each student by class and section
  Map<String, Map<String, List<Student>>> attendanceData = {};

  // Helper to create a unique key for each class-section combination
  String get currentKey => '$selectedClass-$selectedSection';

  void selectClass(String className) {
    selectedClass = className;
    if (selectedSection != null) {
      loadStudents();
    }
    notifyListeners();
  }

  void selectSection(String section) {
    selectedSection = section;
    if (selectedClass != null) {
      loadStudents();
    }
    notifyListeners();
  }

  void loadStudents() {
    // Check if attendance data already exists for the selected class and section
    if (attendanceData.containsKey(currentKey)) {
      // Load existing students with their attendance status
      students = attendanceData[currentKey]![selectedSection!]!;
    } else {
      // Load default students and mark them as not present
      students = _getDefaultStudents();
      attendanceData[currentKey] = {selectedSection!: students};
    }
    notifyListeners();
  }

  // Helper to get default students for each section
  List<Student> _getDefaultStudents() {
    if (selectedSection == 'A') {
      return [
        Student(name: 'Aman', entryTime: '9:00 AM', isPresent: false),
        Student(name: 'Babar', entryTime: '9:05 AM', isPresent: false),
        Student(name: 'Chaitanya', entryTime: '9:10 AM', isPresent: false),
        Student(name: 'Deepak', entryTime: '9:15 AM', isPresent: false),
        Student(name: 'Esha', entryTime: '9:20 AM', isPresent: false),
        Student(name: 'Farhan', entryTime: '9:25 AM', isPresent: false),
        Student(name: 'Geeta', entryTime: '9:30 AM', isPresent: false),
        Student(name: 'Himanshu', entryTime: '9:35 AM', isPresent: false),
        Student(name: 'Isha', entryTime: '9:40 AM', isPresent: false),
        Student(name: 'Jasmin', entryTime: '9:45 AM', isPresent: false),
        Student(name: 'Karan', entryTime: '9:50 AM', isPresent: false),
        Student(name: 'Lara', entryTime: '9:55 AM', isPresent: false),
        Student(name: 'Manish', entryTime: '10:00 AM', isPresent: false),
        Student(name: 'Nisha', entryTime: '10:05 AM', isPresent: false),
        Student(name: 'Omar', entryTime: '10:10 AM', isPresent: false),
        Student(name: 'Priya', entryTime: '10:15 AM', isPresent: false),
        Student(name: 'Qasim', entryTime: '10:20 AM', isPresent: false),
        Student(name: 'Riya', entryTime: '10:25 AM', isPresent: false),
        Student(name: 'Sahil', entryTime: '10:30 AM', isPresent: false),
        Student(name: 'Tania', entryTime: '10:35 AM', isPresent: false),
        Student(name: 'Uday', entryTime: '10:40 AM', isPresent: false),
        Student(name: 'Vikram', entryTime: '10:45 AM', isPresent: false),
        Student(name: 'Waseem', entryTime: '10:50 AM', isPresent: false),
        Student(name: 'Xena', entryTime: '10:55 AM', isPresent: false),
        Student(name: 'Yash', entryTime: '11:00 AM', isPresent: false),
        Student(name: 'Zara', entryTime: '11:05 AM', isPresent: false),

      ];
    } else if (selectedSection == 'B') {
      return [
        Student(name: 'Aaron', entryTime: '9:00 AM', isPresent: false),
        Student(name: 'Bella', entryTime: '9:05 AM', isPresent: false),
        Student(name: 'Cameron', entryTime: '9:10 AM', isPresent: false),
        Student(name: 'Diana', entryTime: '9:15 AM', isPresent: false),
        Student(name: 'Ethan', entryTime: '9:20 AM', isPresent: false),
        Student(name: 'Fiona', entryTime: '9:25 AM', isPresent: false),
        Student(name: 'Gavin', entryTime: '9:30 AM', isPresent: false),
        Student(name: 'Hannah', entryTime: '9:35 AM', isPresent: false),
        Student(name: 'Isaac', entryTime: '9:40 AM', isPresent: false),
        Student(name: 'Jade', entryTime: '9:45 AM', isPresent: false),
        Student(name: 'Kendall', entryTime: '9:50 AM', isPresent: false),
        Student(name: 'Leo', entryTime: '9:55 AM', isPresent: false),
        Student(name: 'Mia', entryTime: '10:00 AM', isPresent: false),
        Student(name: 'Nolan', entryTime: '10:05 AM', isPresent: false),
        Student(name: 'Olivia', entryTime: '10:10 AM', isPresent: false),
        Student(name: 'Parker', entryTime: '10:15 AM', isPresent: false),
        Student(name: 'Quinn', entryTime: '10:20 AM', isPresent: false),
        Student(name: 'Ryder', entryTime: '10:25 AM', isPresent: false),
        Student(name: 'Sophie', entryTime: '10:30 AM', isPresent: false),
        Student(name: 'Tristan', entryTime: '10:35 AM', isPresent: false),
        Student(name: 'Ursula', entryTime: '10:40 AM', isPresent: false),
        Student(name: 'Victor', entryTime: '10:45 AM', isPresent: false),
        Student(name: 'Willow', entryTime: '10:50 AM', isPresent: false),
        Student(name: 'Xander', entryTime: '10:55 AM', isPresent: false),
        Student(name: 'Yvette', entryTime: '11:00 AM', isPresent: false),
        Student(name: 'Zach', entryTime: '11:05 AM', isPresent: false),

      ];
    } else {
      return [
        Student(name: 'Adrian', entryTime: '9:00 AM', isPresent: false),
        Student(name: 'Bianca', entryTime: '9:05 AM', isPresent: false),
        Student(name: 'Caleb', entryTime: '9:10 AM', isPresent: false),
        Student(name: 'Daphne', entryTime: '9:15 AM', isPresent: false),
        Student(name: 'Elias', entryTime: '9:20 AM', isPresent: false),
        Student(name: 'Freya', entryTime: '9:25 AM', isPresent: false),
        Student(name: 'Gideon', entryTime: '9:30 AM', isPresent: false),
        Student(name: 'Haley', entryTime: '9:35 AM', isPresent: false),
        Student(name: 'Imani', entryTime: '9:40 AM', isPresent: false),
        Student(name: 'Jaxon', entryTime: '9:45 AM', isPresent: false),
        Student(name: 'Kira', entryTime: '9:50 AM', isPresent: false),
        Student(name: 'Landon', entryTime: '9:55 AM', isPresent: false),
        Student(name: 'Maya', entryTime: '10:00 AM', isPresent: false),
        Student(name: 'Noah', entryTime: '10:05 AM', isPresent: false),
        Student(name: 'Paige', entryTime: '10:10 AM', isPresent: false),
        Student(name: 'Riley', entryTime: '10:15 AM', isPresent: false),
        Student(name: 'Sebastian', entryTime: '10:20 AM', isPresent: false),
        Student(name: 'Tessa', entryTime: '10:25 AM', isPresent: false),
        Student(name: 'Uriah', entryTime: '10:30 AM', isPresent: false),
        Student(name: 'Vanessa', entryTime: '10:35 AM', isPresent: false),
        Student(name: 'Wyatt', entryTime: '10:40 AM', isPresent: false),
        Student(name: 'Xena', entryTime: '10:45 AM', isPresent: false),
        Student(name: 'Yasmin', entryTime: '10:50 AM', isPresent: false),
        Student(name: 'Zane', entryTime: '10:55 AM', isPresent: false),
      ];
    }
  }

  void markAttendance(Student student, bool isPresent) {
    int index = students.indexOf(student);
    if (index != -1) {
      students[index] = Student(
        name: student.name,
        entryTime: student.entryTime,
        isPresent: isPresent,
      );
      attendanceData[currentKey]![selectedSection!] = students;
      notifyListeners();
    }
  }

  // Calculate the number of students marked as present for the current selection
  int get presentCount {
    return students.where((student) => student.isPresent == true).length;
  }
}
