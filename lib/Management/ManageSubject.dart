import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/Management/Profiles/SubjectProfile.dart';
import 'package:flutter/material.dart';

class ManageSubject extends StatefulWidget {
  const ManageSubject({Key? key,}) : super(key: key);

  @override
  _ManageSubjectState createState() => _ManageSubjectState();
}

class _ManageSubjectState extends State<ManageSubject> {
  Stream? studentListStream;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Widget subjectList() => StreamBuilder(
      stream: studentListStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return SubjectTile(snapshot.data.docs[index]["Subject_Code"],
                      snapshot.data.docs[index]["Subject_Name"]);
                })
            : Center(
                child: CircularProgressIndicator(),
              );
      });
  @override
  void initState() {
    getSubjects();
    super.initState();
  }

  getSubjects() {
    databaseMethods.getSubject("Computer").then((val) {
      studentListStream = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: subjectList());
  }
}

class SubjectTile extends StatelessWidget {
  final String code;
  final String name;
  SubjectTile(this.code, this.name);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubjectProfile(
                      code: code,
                    )));
      },
      leading: CircleAvatar(
        child: Center(
          child: text(name[0].toUpperCase(), 16),
        ),
      ),
      title: textBlackBold(name, 16),
      subtitle: textBlackThin(code, 14),
    );
  }
}
