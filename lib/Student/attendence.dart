import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/Student/mark_attendence.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MarkAttendance extends StatefulWidget {
  final String uid;
  MarkAttendance({Key? key, required this.uid}) : super(key: key);

  @override
  _MarkAttendanceState createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends State<MarkAttendance> {
  @override
  void initState() {
    super.initState();
    getLectures();
  }

  checkAvailablity() {}
  bool markAttendence = false;
  Stream? availableLecturesListStream;
  availableLectures() => StreamBuilder(
      stream: availableLecturesListStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return AvailableLectureTile(
                    toTime: snapshot.data!.docs[index]["To_Time"].toString(),
                    date:
                        snapshot.data!.docs[index]["DateOfAdding"] as Timestamp,
                    fromTime:
                        snapshot.data!.docs[index]["From_Time"].toString(),
                    lectureName: snapshot.data!.docs[index]["Lecture_Name"],
                    subjectName: snapshot.data!.docs[index]["Subject_Name"],
                    uid: snapshot.data!.docs[index]["Id"],
                    destinationExternalId: snapshot.data!.docs[index]
                        ["destinationExternalId"] as int,
                    destinationTag: snapshot.data!.docs[index]
                        ["destinationTag"],
                    externalId: snapshot.data!.docs[index]["externalId"] as int,
                  );
                })
            : Center(
                child: CircularProgressIndicator(),
              );
      });

  getLectures() {
    DatabaseMethods().getAvaliableLectures().then((value) {
      availableLecturesListStream = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      child: availableLectures(),
    );
  }
}

class AvailableLectureTile extends StatefulWidget {
  final Timestamp date;
  final String fromTime, lectureName, subjectName, toTime, uid, destinationTag;
  final int destinationExternalId, externalId;

  AvailableLectureTile({
    required this.date,
    required this.fromTime,
    required this.lectureName,
    required this.subjectName,
    required this.toTime,
    required this.uid,
    required this.destinationTag,
    required this.destinationExternalId,
    required this.externalId,
  });

  @override
  State<AvailableLectureTile> createState() => _AvailableLectureTileState();
}

class _AvailableLectureTileState extends State<AvailableLectureTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MarkAttendence(
                      uid: widget.uid,
                      lectureName: widget.lectureName,
                      subject: widget.subjectName,
                      destinationExternalId: widget.destinationExternalId,
                      destinationTag: widget.destinationTag,
                      externalId: widget.externalId,
                    )));
      },
      leading: CircleAvatar(
        child: Center(
          child: text(widget.lectureName[0].toUpperCase(), 16),
        ),
      ),
      title: textBlackBold(widget.lectureName, 16),
      subtitle: textBlackThin(widget.subjectName, 14),
    );
  }
}

class AnouncementCard extends StatelessWidget {
  final String subtitle;
  final String title;
  AnouncementCard({
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          child: text(title[0], 16),
        ),
        title: textBlackBold(title, 20),
        subtitle: textBlackThin(subtitle, 16));
  }
}
