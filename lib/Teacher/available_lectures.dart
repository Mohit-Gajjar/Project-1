import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/Teacher/manage_lecture.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TakeOrLeave extends StatefulWidget {
  const TakeOrLeave({Key? key}) : super(key: key);

  @override
  _TakeOrLeaveState createState() => _TakeOrLeaveState();
}

class _TakeOrLeaveState extends State<TakeOrLeave> {
  @override
  void initState() {
    super.initState();
    getTimeTable();
  }

  Stream? timetableStream;
  timetable() {
    return StreamBuilder(
        stream: timetableStream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return AvailableLectureTile(
                      from: snapshot.data!.docs[0]["From_Time"],
                      to: snapshot.data!.docs[0]["To_Time"],
                      id: snapshot.data!.docs[0]["Id"],
                      title: snapshot.data!.docs[0]["Lecture_Name"],
                      subtitle: snapshot.data!.docs[0]["Subject_Name"],
                      duration: snapshot.data!.docs[0]["duration"] as int,
                    );
                  })
              : Center(child: CircularProgressIndicator());
        });
  }

  getTimeTable() async {
    DatabaseMethods()
        .getTimeTable(DateFormat('EEEE').format(DateTime.now()).toLowerCase())
        .then((val) {
      setState(() {
        timetableStream = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  timetable();
  }
}

class AvailableLectureTile extends StatelessWidget {
  final String title, subtitle, id, from, to;
  final int duration;

  AvailableLectureTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.id,
      required this.from,
      required this.to,
      required this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ManageLecture(
                    lectureName: title,
                    id: id,
                    from: from,
                    subject: subtitle,
                    to: to,
                    duration: duration)));
      },
      leading: CircleAvatar(
        child: Center(
          child: text(title[0].toUpperCase(), 16),
        ),
      ),
      title: textBlackBold(title, 16),
      subtitle: textBlackThin(subtitle, 14),
    );
  }
}
