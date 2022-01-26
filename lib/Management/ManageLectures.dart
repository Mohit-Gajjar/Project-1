import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/Management/Profiles/LecturesProfile.dart';
import 'package:flutter/material.dart';

class ManageLectures extends StatefulWidget {
  const ManageLectures({
    Key? key,
  }) : super(key: key);

  @override
  _ManageLecturesState createState() => _ManageLecturesState();
}

class _ManageLecturesState extends State<ManageLectures> {
  Stream? lectureStream;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Widget lectureList() => StreamBuilder(
      stream: lectureStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return LectureTile(snapshot.data.docs[index]["Subject_Name"],
                      snapshot.data.docs[index]["Lecture_Name"]);
                })
            : Center(
                child: CircularProgressIndicator(),
              );
      });
  @override
  void initState() {
    getLectures();
    super.initState();
  }

  getLectures() {
    databaseMethods.getLectures("Computer").then((val) {
      lectureStream = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(height: 450, child: lectureList());
  }
}

class LectureTile extends StatelessWidget {
  final String subject;
  final String name;
  LectureTile(this.subject, this.name);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LecturesProfile(name: name)));
      },
      leading: CircleAvatar(
        child: Center(
          child: text(name[0].toUpperCase(), 16),
        ),
      ),
      title: textBlackBold(name, 16),
      subtitle: textBlackThin(subject, 14),
    );
  }
}
