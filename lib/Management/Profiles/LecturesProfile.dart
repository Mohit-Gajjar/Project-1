// ignore_for_file: non_constant_identifier_names

import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LecturesProfile extends StatefulWidget {
  final String name;
  const LecturesProfile({Key? key, required this.name}) : super(key: key);

  @override
  _LecturesProfileState createState() => _LecturesProfileState();
}

class _LecturesProfileState extends State<LecturesProfile> {
  Stream? lecturesStream;
  @override
  void initState() {
    getLectureInfo();
    super.initState();
  }

  getLectureInfo() {
    DatabaseMethods().getLecturesByName(widget.name).then((value) {
      lecturesStream = value;
      setState(() {});
    });
  }

  Widget lectureInfo() {
    return StreamBuilder(
        stream: lecturesStream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? LecturesInfoTile(
                  to_time: snapshot.data!.docs[0]["To_Time"].toString(),
                  date: snapshot.data!.docs[0]["DateOfAdding"] as Timestamp,
                  from_time: snapshot.data!.docs[0]["From_Time"].toString(),
                  lecture_name: snapshot.data!.docs[0]["Lecture_Name"],
                  subject_name: snapshot.data!.docs[0]["Subject_Name"],
                  fri: snapshot.data!.docs[0]["friday"],
                  mon: snapshot.data!.docs[0]["monday"],
                  sat: snapshot.data!.docs[0]["saturday"],
                  sun: snapshot.data!.docs[0]["sunday"],
                  thurs: snapshot.data!.docs[0]["thursday"],
                  tue: snapshot.data!.docs[0]["tuesday"],
                  wed: snapshot.data!.docs[0]["wednesday"],
                  destinationExternalId:
                      snapshot.data!.docs[0]["destinationExternalId"] as int,
                  destinationTag: snapshot.data!.docs[0]["destinationTag"],
                  externalId: snapshot.data!.docs[0]["externalId"] as int,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: appBar("Lecture Profile"),
      body: Container(
        child: lectureInfo(),
      ),
    );
  }
}

class LecturesInfoTile extends StatefulWidget {
  LecturesInfoTile(
      {required this.date,
      required this.from_time,
      required this.lecture_name,
      required this.subject_name,
      required this.to_time,
      required this.tue,
      required this.wed,
      required this.mon,
      required this.thurs,
      required this.fri,
      required this.sat,
      required this.sun,
      required this.destinationTag,
      required this.externalId,
      required this.destinationExternalId});

  final Timestamp date;
  final String from_time;
  final String lecture_name;
  final String subject_name;
  final String to_time;
  final String destinationTag;
  final int externalId;
  final int destinationExternalId;

  final bool tue;
  final bool wed;
  final bool mon;
  final bool thurs;
  final bool fri;
  final bool sat;
  final bool sun;

  @override
  State<LecturesInfoTile> createState() => _LecturesInfoTileState();
}

class _LecturesInfoTileState extends State<LecturesInfoTile> {
  DateTime? dateTime;
  String? dateString;

  @override
  void initState() {
    timeStampConverter();
    super.initState();
  }

  timeStampConverter() {
    print("Initstate is working");
    dateTime = widget.date.toDate();
    dateString = DateFormat('EEE, M/d/y').format(dateTime!);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: textBlackBold("Lecture Name:", 14),
          subtitle: textBlackThin(widget.lecture_name, 16),
        ),
        ListTile(
          title: textBlackBold("Subject Name:", 14),
          subtitle: textBlackThin(widget.subject_name, 16),
        ),
        ListTile(
          title: textBlackBold("From:", 14),
          subtitle: textBlackThin(widget.from_time, 16),
        ),
        ListTile(
          title: textBlackBold("To:", 14),
          subtitle: textBlackThin(widget.to_time, 16),
        ),
        ListTile(
          title: textBlackBold("Date:", 14),
          subtitle: textBlackThin(dateString.toString(), 16),
        ),
        ListTile(
          title: textBlackBold("Destination External Id:", 14),
          subtitle: textBlackThin(widget.destinationExternalId.toString(), 16),
        ),
        ListTile(
          title: textBlackBold("Destination Tag:", 14),
          subtitle: textBlackThin(widget.destinationTag, 16),
        ),
        ListTile(
          title: textBlackBold("External Id:", 14),
          subtitle: textBlackThin(widget.externalId.toString(), 16),
        ),
        ListTile(
          title: textBlackBold("Days In Week:", 14),
          subtitle: Row(
            children: [
              Column(
                children: [
                  textBlackBold("sun", 16),
                  Container(
                    color:
                        widget.sun == true ? Colors.green : Colors.transparent,
                    height: 20,
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  textBlackBold("mon", 16),
                  Container(
                    color:
                        widget.mon == true ? Colors.green : Colors.transparent,
                    height: 20,
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  textBlackBold("tue", 16),
                  Container(
                    color:
                        widget.tue == true ? Colors.green : Colors.transparent,
                    height: 20,
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  textBlackBold("wed", 16),
                  Container(
                    color:
                        widget.wed == true ? Colors.green : Colors.transparent,
                    height: 20,
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  textBlackBold("thurs", 16),
                  Container(
                    color: widget.thurs == true
                        ? Colors.green
                        : Colors.transparent,
                    height: 20,
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  textBlackBold("fri", 16),
                  Container(
                    color:
                        widget.fri == true ? Colors.green : Colors.transparent,
                    height: 20,
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  textBlackBold("sat", 16),
                  Container(
                    color:
                        widget.sat == true ? Colors.green : Colors.transparent,
                    height: 20,
                    width: 20,
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
