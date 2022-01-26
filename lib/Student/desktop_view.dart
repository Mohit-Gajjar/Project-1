import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Student/attendence.dart';
import 'package:asms/Student/timetable.dart';
import 'package:flutter/material.dart';

class DesktopView extends StatefulWidget {
  final Widget anouncement;
  final Widget universityTile;
  final String uid;
  DesktopView({
    required this.anouncement,
    required this.uid,
    Key? key,
    required this.universityTile,
  }) : super(key: key);

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  bool timetable = false,
      markattendence = false,
      home = false,
      hasAnouncement = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.universityTile,
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      timetable = false;
                      markattendence = true;
                      home = false;
                      hasAnouncement = false;
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.width / 15,
                    width: MediaQuery.of(context).size.width / 9,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 12,
                          color:
                              markattendence ? Colors.black45 : Colors.white,
                        )
                      ],
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.blue,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: MediaQuery.of(context).size.width / 60,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.touch_app,
                              size: MediaQuery.of(context).size.width / 60,
                            )),
                        SizedBox(height: 5),
                        text("Mark", MediaQuery.of(context).size.width / 70)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
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
                  child: Container(
                    height: MediaQuery.of(context).size.width / 15,
                    width: MediaQuery.of(context).size.width / 9,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 12,
                          color: timetable ? Colors.black45 : Colors.white,
                        )
                      ],
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.amberAccent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: MediaQuery.of(context).size.width / 60,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.description,
                              color: Colors.amberAccent,
                              size: MediaQuery.of(context).size.width / 60,
                            )),
                        SizedBox(height: 5),
                        text("TimeTable",
                            MediaQuery.of(context).size.width / 80)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
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
                  child: Container(
                    height: MediaQuery.of(context).size.width / 15,
                    width: MediaQuery.of(context).size.width / 9,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 12,
                          color:
                              hasAnouncement ? Colors.black45 : Colors.white,
                        )
                      ],
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.green,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: MediaQuery.of(context).size.width / 60,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.campaign,
                              color: Colors.green,
                              size: MediaQuery.of(context).size.width / 60,
                            )),
                        SizedBox(height: 5),
                        text("Anouncements",
                            MediaQuery.of(context).size.width / 80)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width/2,
              child: markattendence
                  ? MarkAttendance(uid: widget.uid)
                  : timetable
                      ? TimeTable()
                      : hasAnouncement
                          ? Container(
                              height: 480,
                              child: widget.anouncement,
                            )
                          : Container(),
            )
          ],
        ),
      ),
    );
  }
}
