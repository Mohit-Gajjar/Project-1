import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_radar/flutter_radar.dart';
import 'package:nanoid/non_secure.dart';

class MarkAttendence extends StatefulWidget {
  final String uid, lectureName, subject, destinationTag;
  final int destinationExternalId, externalId;
  const MarkAttendence(
      {Key? key,
      required this.uid,
      required this.lectureName,
      required this.subject,
      required this.destinationTag,
      required this.destinationExternalId,
      required this.externalId})
      : super(key: key);

  @override
  _MarkAttendenceState createState() => _MarkAttendenceState();
}

class _MarkAttendenceState extends State<MarkAttendence> {
  String name = " ", email = " ";
  @override
  void initState() {
    getStudentCredentials();
    startTrip();
    startForegroundTracking();
    super.initState();
  }

  String id = " ";
  String enrollmentNo = " ";

  getStudentCredentials() async {
    name = (await HelperFunctions.getStudentNameSharedPreference())!;
    email = (await HelperFunctions.getStudentEmailSharedPreference())!;
    enrollmentNo = await DatabaseMethods().getStudentEnrollment(email);
    id = nanoid(10);
  }

  getGeofences() async {}

  @override
  void dispose() {
    super.dispose();
    Radar.completeTrip();
    Radar.stopTracking();
  }

  startTrip() async {
    Radar.startTrip({
      "externalId": widget.externalId,
      "destinationGeofenceTag": widget.destinationTag,
      "destinationGeofenceExternalId": widget.destinationExternalId,
      "mode": "walk"
    });
  }

  String attendenceStatus = " ";
  var result;
  String event = " ";
  bool color = false;
  startForegroundTracking() async {
    Map<dynamic, dynamic> result = await Radar.trackOnce();
    event = result["events"][0]["type"];

    if (event == "user.entered_geofence" ||
        event == "user.arrived_at_trip_destination") {
      print("You can mark attedence");
      setState(() {
        attendenceStatus = "Mark Attendence";
        color = true;
      });
    } else if (event == "user.exited_geofence" ||
        event == "user.approaching_trip_destination" ||
        event == "user.started_trip" ||
        event == "user.updated_trip") {
      print("You are not in Class");
      setState(() {
        attendenceStatus = "You are not in Class";
        color = false;
      });
    }
  }

  bool button = true;
  markAttendence() {
    Map<String, dynamic> markedAttendenceData = {
      "studentName": name,
      "studentEmail": email,
      "enrollmentNo": enrollmentNo,
      "datetime": DateTime.now(),
      "id": id,
      "key": "attendence"
    };
    DatabaseMethods()
        .attendence(markedAttendenceData, widget.uid, enrollmentNo);
    button = false;
    attendenceStatus = "Attendence Marked";
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pop(context);
  }

  final snackBar = SnackBar(content: Text('Attendence Marked'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: textBlackBold("Mark Attendence", 16),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: button == true
                ? IconButton(
                    icon: Icon(Icons.touch_app_outlined),
                    iconSize: 100,
                    color: color == true ? Colors.green : Colors.red,
                    onPressed: () {
                      if (color) {
                        setState(() {
                          markAttendence();
                        });
                      } else {}
                    },
                  )
                : Container(),
          ),
          SizedBox(
            height: 20,
          ),
          textBlackBold(attendenceStatus, 16),
        ],
      ),
    );
  }
}
