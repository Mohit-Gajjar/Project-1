import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentInfo extends StatefulWidget {
  final String studentEnroll, id;
  const StudentInfo({Key? key, required this.studentEnroll, required this.id})
      : super(key: key);

  @override
  _StudentInfoState createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  @override
  void initState() {
    getStudentInfoMethord();
    super.initState();
  }

  Stream? studentInfoStream;
  Widget getStudentInfo() => StreamBuilder(
      stream: studentInfoStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return StudentInformation(
                    studentName: snapshot.data.docs[index]["studentName"],
                    enrollmentNo: snapshot.data.docs[index]["enrollmentNo"],
                    studentEmail: snapshot.data.docs[index]["studentEmail"],
                    id: snapshot.data.docs[index]["id"],
                    date: (snapshot.data.docs[index]["datetime"] as Timestamp)
                        .toDate(),
                  );
                })
            : Center(
                child: CircularProgressIndicator(),
              );
      });

  getStudentInfoMethord() {
    DatabaseMethods()
        .getStudentInfo(widget.id, widget.studentEnroll)
        .then((val) {
      studentInfoStream = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: appBar("Student Information"),
      body: getStudentInfo(),
    );
  }
}

class StudentInformation extends StatelessWidget {
  final String studentName, enrollmentNo, studentEmail, id;
  final DateTime date;
  const StudentInformation(
      {Key? key,
      required this.studentName,
      required this.enrollmentNo,
      required this.studentEmail,
      required this.id,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: textBlackBold("Student Name", 14),
          subtitle: textBlackThin(studentName, 16),
        ),
        ListTile(
          title: textBlackBold("Student Email", 14),
          subtitle: textBlackThin(studentEmail, 16),
        ),
        ListTile(
          title: textBlackBold("Student Enrollment No", 14),
          subtitle: textBlackThin(enrollmentNo, 16),
        ),
        ListTile(
          title: textBlackBold("Student Attendence Mark timestamp", 14),
          subtitle: textBlackThin(date.toString(), 16),
        ),
        ListTile(
          title: textBlackBold("Student Id", 14),
          subtitle: textBlackThin(id, 16),
        ),
      ],
    );
  }
}
