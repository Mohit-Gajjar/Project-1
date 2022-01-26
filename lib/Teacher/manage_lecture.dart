import 'dart:async';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ManageLecture extends StatefulWidget {
  final String lectureName, id, subject, from, to;
  int duration;
  ManageLecture(
      {Key? key,
      required this.lectureName,
      required this.id,
      required this.subject,
      required this.from,
      required this.to,
      required this.duration})
      : super(key: key);

  @override
  _ManageLectureState createState() => _ManageLectureState();
}

class _ManageLectureState extends State<ManageLecture> {
  bool onGoing = false;
  final snackBar = SnackBar(content: Text('Lecture Started'));
  final snackBar1 = SnackBar(content: Text('Lecture Finished'));
  final snackBar2 = SnackBar(content: Text('Lecture Not Started!'));
  updateLecture() {
    Map<String, dynamic> updateLecture = {"onGoing": onGoing};
    DatabaseMethods().updateLectures(updateLecture, widget.id);
  }

  @override
  void initState() {
    super.initState();

  }

  Timer? timer;
  void start() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (widget.duration > 0) {
        setState(() {
          widget.duration--;
        });
      } else {
        stopTimer();
        setState(() {
          onGoing = false;
          updateLecture();
          ScaffoldMessenger.of(context).showSnackBar(snackBar1);
        });
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    return isRunning
        ? btn(
            name: "Finish Lecture",
            size: 30,
            onPressed: () {
              stopTimer();
              setState(() {
                onGoing = false;
                updateLecture();
                if (onGoing = false) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                }
              });
            })
        : btn(
            name: "Start Lecture",
            size: 30,
            onPressed: () {
              start();
              setState(() {
                onGoing = true;
                updateLecture();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: appBar("Manage Lecture"),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textBlackBold("Name: " + widget.lectureName, 16),
            textBlackBold("Subject: " + widget.subject, 16),
            textBlackBold("Start from: " + widget.from, 16),
            textBlackBold("End at: " + widget.to, 16),
            textBlackBold("Duration: " + widget.duration.toString() + " seconds", 16),
            SizedBox(
              height: 20,
            ),
            Center(child: buildButtons()),
          ],
        ),
      ),
    );
  }

  Widget timerTime() {
    return Container(
      child: Center(child: text("${widget.duration}", 20)),
    );
  }
}
