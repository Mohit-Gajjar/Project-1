import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/Management/Profiles/TeacherProfile.dart';
import 'package:flutter/material.dart';

class ManageTeacher extends StatefulWidget {
  const ManageTeacher({
    Key? key,
  }) : super(key: key);

  @override
  _ManageTeacherState createState() => _ManageTeacherState();
}

class _ManageTeacherState extends State<ManageTeacher> {
  Stream? teacherListStream;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Widget teacherList() => StreamBuilder(
      stream: teacherListStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return TeacherTile(snapshot.data.docs[index]["name"],
                      snapshot.data.docs[index]["email"]);
                })
            : Center(
                child: CircularProgressIndicator(),
              );
      });
  @override
  void initState() {
    getTeacherInfo();
    super.initState();
  }

  getTeacherInfo() {
    databaseMethods.getTeachers().then((val) {
      teacherListStream = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: teacherList());
  }
}

class TeacherTile extends StatelessWidget {
  final String email;
  final String name;
  TeacherTile(this.name, this.email);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (contex) => TeacherProfile()));
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Center(
            child: text(name[0].toUpperCase(), 16),
          ),
        ),
        title: textBlackBold(name, 16),
        subtitle: textBlackThin(email, 14),
      ),
    );
  }
}
