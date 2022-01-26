import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SubjectProfile extends StatefulWidget {
  String code;
  SubjectProfile({Key? key, required this.code}) : super(key: key);

  @override
  _SubjectProfileState createState() => _SubjectProfileState();
}

class _SubjectProfileState extends State<SubjectProfile> {
  Stream? studentInfoStream;
  Widget subjectInfo() {
    return StreamBuilder(
        stream: studentInfoStream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? SubjectInfo(
                  snapshot.data!.docs[0]["Subject_Name"],
                  snapshot.data!.docs[0]["Subject_Code"],
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  @override
  void initState() {
    getSubjectInfo();
    super.initState();
  }

  getSubjectInfo() {
    DatabaseMethods().getSubjectByCode(widget.code.toString()).then((value) {
      studentInfoStream = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: appBar("Subject Info"),
      body: Container(
        child: subjectInfo(),
      ),
    );
  }
}

class SubjectInfo extends StatelessWidget {
  SubjectInfo(
    this.name,
    this.code,
  );

  final String name;
  final String code;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: textBlackBold("Subject Name", 14),
          subtitle: textBlackThin(name, 16),
        ),
        ListTile(
          title: textBlackBold("Subject Code", 14),
          subtitle: textBlackThin(code, 16),
        ),
      ],
    );
  }
}
