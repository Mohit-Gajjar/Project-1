import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Teacher/available_lectures.dart';
import 'package:asms/Teacher/view_attendence.dart';
import 'package:flutter/material.dart';

class MobileView extends StatefulWidget {
  const MobileView({
    Key? key,
    required this.studentCounter,
    required this.teacherCounter,
    required this.universityTile,
  }) : super(key: key);
  final int studentCounter;
  final int teacherCounter;
  final Widget universityTile;

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  bool lecture = false, attendence = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.universityTile,
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  textBlackBold(widget.studentCounter.toString(), 80),
                  textBlackThin("Total Students", 16)
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 15,
          ),
          managementClicker(context),
          Container(
              height: 480,
              child: attendence
                  ? ViewAttendence()
                  : lecture
                      ? TakeOrLeave()
                      : Container())
        ],
      ),
    );
  }

  Row managementClicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              lecture = true;
              attendence = false;
            });
          },
          child: Container(
            height: 55,
            width: MediaQuery.of(context).size.width / 2.5,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 12,
                  color: lecture ? Colors.black45 : Colors.white,
                )
              ],
              borderRadius: BorderRadius.circular(30),
              color: Colors.blue,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 8),
                CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.history_edu)),
                SizedBox(width: 10),
                text("Lecture", 14)
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              lecture = false;
              attendence = true;
            });
          },
          child: Container(
            height: 55,
            width: MediaQuery.of(context).size.width / 2.5,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 12,
                  color: attendence ? Colors.black45 : Colors.white,
                )
              ],
              borderRadius: BorderRadius.circular(30),
              color: Colors.amberAccent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 8),
                CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.fact_check,
                      color: Colors.amberAccent,
                    )),
                SizedBox(width: 10),
                text("Attendence", 14)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
