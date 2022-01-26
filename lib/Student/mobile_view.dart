import 'package:asms/Student/attendence.dart';
import 'package:asms/Student/timetable.dart';
import 'package:flutter/material.dart';

class MobileView extends StatefulWidget {
  final Widget universityInfo;
  final Widget anouncement;
  final String uid;

  MobileView(
      {Key? key,
      required this.universityInfo,
      required this.anouncement,
      required this.uid})
      : super(key: key);

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  bool timetable = false,
      markattendence = false,
      home = false,
      hasAnouncement = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [widget.universityInfo, managementClicker(context)],
            ),
            SizedBox(
              height: 15,
            ),
            markattendence
                ? MarkAttendance(uid: widget.uid)
                : timetable
                    ? TimeTable()
                    : hasAnouncement
                        ? Container(
                            height: 480,
                            child: widget.anouncement,
                          )
                        : Container()
          ],
        ),
      ),
    );
  }

  Column managementClicker(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            setState(() {
              timetable = false;
              markattendence = true;
              home = false;
              hasAnouncement = false;
            });
          },
          child: Material(
            borderRadius: BorderRadius.circular(30),
            elevation: markattendence ? 15 : 0,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue,
              child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.touch_app)),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              timetable = true;
              markattendence = false;
              home = false;
              hasAnouncement = false;
            });
          },
          child: Material(
            borderRadius: BorderRadius.circular(30),
            elevation: timetable ? 15 : 0,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.amberAccent,
              child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.description,
                    color: Colors.amberAccent,
                  )),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              timetable = false;
              markattendence = false;
              home = false;
              hasAnouncement = true;
            });
          },
          child: Material(
            borderRadius: BorderRadius.circular(30),
            elevation: hasAnouncement ? 15 : 0,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green,
              child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.campaign,
                    color: Colors.green,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
