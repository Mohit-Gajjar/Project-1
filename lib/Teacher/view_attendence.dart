import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/Teacher/student_attendence.dart';
import 'package:flutter/material.dart';

class ViewAttendence extends StatefulWidget {
  const ViewAttendence({Key? key}) : super(key: key);

  @override
  _ViewAttendenceState createState() => _ViewAttendenceState();
}

class _ViewAttendenceState extends State<ViewAttendence> {
  Stream? lectureStream;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Widget lectureList() => StreamBuilder(
      stream: lectureStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return LectureTile(
                      snapshot.data.docs[index]["Subject_Name"],
                      snapshot.data.docs[index]["Lecture_Name"],
                      snapshot.data.docs[index]["Id"]);
                })
            : Center(
                child: CircularProgressIndicator(),
              );
      });
  @override
  void initState() {
    getLectures();
    super.initState();
  }

  getLectures() {
    databaseMethods.getLectures("Computer").then((val) {
      lectureStream = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return lectureList();
  }
}

class LectureTile extends StatelessWidget {
  final String subject;
  final String name;
  final String id;
  LectureTile(this.subject, this.name, this.id);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StudentAttendence(lectureId: id)));
      },
      leading: CircleAvatar(
        child: Center(
          child: text(name[0].toUpperCase(), 16),
        ),
      ),
      title: textBlackBold(name, 16),
      subtitle: textBlackThin(subject, 14),
    );
  }
}
