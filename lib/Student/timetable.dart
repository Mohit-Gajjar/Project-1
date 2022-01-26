import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({Key? key}) : super(key: key);

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
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
                    return TimeTableTile(
                        from: snapshot.data!.docs[0]["From_Time"],
                        to: snapshot.data!.docs[0]["To_Time"],
                        name: snapshot.data!.docs[0]["Lecture_Name"]);
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
    return Container(
      height: 480,
      child: timetable(),
    );
  }
}

class TimeTableTile extends StatelessWidget {
  final String from, to, name;
  const TimeTableTile(
      {Key? key, required this.from, required this.to, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: textBlackBold(name, 16),
      subtitle: textBlackThin("From " + from + " to " + to, 16),
    );
  }
}
