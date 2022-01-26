import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Teacher/available_lectures.dart';
import 'package:asms/Teacher/view_attendence.dart';
import 'package:flutter/material.dart';

class DesktopView extends StatefulWidget {
  const DesktopView({
    Key? key,
    required this.studentcounter,
    required this.university,
  }) : super(key: key);
  final int studentcounter;
  final Widget university;

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
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
              widget.university,
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  textBlackBold(widget.studentcounter.toString(), 80),
                  textBlackThin("Total Students", 16)
                ],
              ),
              SizedBox(
                width: 20,
              ),
              managementClicker(context),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width/2,
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

  Column managementClicker(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              lecture = true;
              attendence = false;
            });
          },
          child: Container( height: MediaQuery.of(context).size.width / 17,
                    width: MediaQuery.of(context).size.width / 11,
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
            child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               
                CircleAvatar(
                  radius:  MediaQuery.of(context).size.width/60,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.history_edu, size: MediaQuery.of(context).size.width/60,)),
              
                text("Manage Lecture", MediaQuery.of(context).size.width/100)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              lecture = false;
              attendence = true;
            });
          },
          child: Container( height: MediaQuery.of(context).size.width / 17,
                    width: MediaQuery.of(context).size.width / 11,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               
                CircleAvatar(
                    backgroundColor: Colors.white,
                    radius:  MediaQuery.of(context).size.width/60,
                    child: Icon(
                      Icons.fact_check,
                      color: Colors.amberAccent,
                      size: MediaQuery.of(context).size.width/60,
                    )),
                
                text("View Attendence", MediaQuery.of(context).size.width/100)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
