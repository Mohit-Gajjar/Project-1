import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/Teacher/student_info.dart';
import 'package:flutter/material.dart';

class StudentAttendence extends StatefulWidget {
  final String lectureId;
  const StudentAttendence({Key? key, required this.lectureId})
      : super(key: key);

  @override
  _StudentAttendenceState createState() => _StudentAttendenceState();
}

class _StudentAttendenceState extends State<StudentAttendence> {
  // ignore: non_constant_identifier_names
  int student_counter = 0;
  int attendenceMarked = 0;
  bool isAvalable = false;
  @override
  void initState() {
    data();
    getAttendence();
    super.initState();
  }

  data() async {
    student_counter = await DatabaseMethods().noOfStudent();
    setState(() {});
  }

  Stream? attendenceStream;
  Widget getAttendenceList() => StreamBuilder(
      stream: attendenceStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  attendenceMarked = snapshot.data!.docs.length;
                  return AttendenceTile(
                    snapshot.data.docs[index]["enrollmentNo"],
                    snapshot.data.docs[index]["studentName"],
                    widget.lectureId,
                  );
                })
            : Center(
                child: CircularProgressIndicator(),
              );
      });

  getAttendence() async {
    print(widget.lectureId);
    DatabaseMethods().getAttendenceBy(widget.lectureId).then((val) {
      attendenceStream = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: textBlackBold("Present Students", 16),
        centerTitle: true,
         iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        actions: [
          !isAvalable
              ? TextButton(
                  onPressed: () {
                    isAvalable = true;
                    setState(() {});
                  },
                  child: textBlackBold("Click Here", 16),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Center(
                      child: textBlackThin(
                          attendenceMarked.toString() +
                              "/" +
                              student_counter.toString(),
                          16)),
                )
        ],
      ),
      body: getAttendenceList(),
    );
  }
}

class AttendenceTile extends StatelessWidget {
  final String enrollment;
  final String name, id;

  AttendenceTile(this.enrollment, this.name, this.id);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StudentInfo(
                      studentEnroll: enrollment,
                      id: id,
                    )));
      },
      leading: CircleAvatar(
        child: Center(
          child: text(name[0].toUpperCase(), 16),
        ),
      ),
      title: textBlackBold(name, 16),
      subtitle: textBlackThin(enrollment, 14),
    );
  }
}
