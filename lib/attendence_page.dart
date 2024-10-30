import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';  // Import this package for date formatting
import 'attendance_provider.dart';
import 'student.dart';

class AttendancePage extends StatelessWidget {
  final List<String> classes = ['Class I', 'Class II', 'Class III'];
  final List<String> sections = ['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<AttendanceProvider>(context);

    // Get the current date
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Consumer<AttendanceProvider>(
      builder: (context, attendanceProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Student Attendance'),
            actions: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Present: ${attendanceProvider.presentCount}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Class Dropdown
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Select Class:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        DropdownButton<String>(
                          hint: Text('Select Class'),
                          value: attendanceProvider.selectedClass,
                          onChanged: (value) {
                            if (value != null) {
                              attendanceProvider.selectClass(value);
                            }
                          },
                          items: classes.map((className) {
                            return DropdownMenuItem<String>(
                              value: className,
                              child: Text(className),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    // Section Dropdown
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Select Section:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        DropdownButton<String>(
                          hint: Text('Select Section'),
                          value: attendanceProvider.selectedSection,
                          onChanged: (value) {
                            if (value != null) {
                              attendanceProvider.selectSection(value);
                            }
                          },
                          items: sections.map((section) {
                            return DropdownMenuItem<String>(
                              value: section,
                              child: Text(section),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Header Row for column headings
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Student Name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            'Date',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            'Status',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // Student List
                    Container(
                      child: Expanded(
                        child: attendanceProvider.students.isNotEmpty
                            ? ListView.builder(
                          itemCount: attendanceProvider.students.length,
                          itemBuilder: (context, index) {
                            final student = attendanceProvider.students[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  // Student Name Column
                                  Expanded(
                                    child: Text(student.name),
                                  ),
                                  // Date Column
                                  Expanded(
                                    child: Text(currentDate,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  // Status Column
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () =>
                                          _showAttendanceDialog(
                                              context, student),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 6.0),
                                        decoration: BoxDecoration(
                                          color: student.isPresent ? Colors
                                              .green : Colors.red,
                                          borderRadius: BorderRadius.circular(
                                              8.0),
                                        ),
                                        child: Text(
                                          student.isPresent
                                              ? 'Present'
                                              : 'Absent',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            // align: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                            : Center(child: Text(
                            'No students available for this class and section.')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showAttendanceDialog(BuildContext context, Student student) {
    final attendanceProvider = Provider.of<AttendanceProvider>(context, listen: false);

    // Initial value for the radio button
    bool? isPresent = student.isPresent;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Mark Attendance for ${student.name}'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Select attendance status:'),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: isPresent,
                        onChanged: (value) {
                          setState(() {
                            isPresent = value;  // Update the selected value
                          });
                        },
                      ),
                      Text('Present'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<bool>(
                        value: false,
                        groupValue: isPresent,
                        onChanged: (value) {
                          setState(() {
                            isPresent = value;  // Update the selected value
                          });
                        },
                      ),
                      Text('Absent'),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (isPresent != null) {
                  attendanceProvider.markAttendance(student, isPresent!);
                  Navigator.of(context).pop();
                } else {
                  // Optionally, show a message if no selection is made
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select an attendance status.')),
                  );
                }
              },
              child: Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
