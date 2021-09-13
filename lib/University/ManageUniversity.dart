import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:flutter/material.dart';

class ManageUniversity extends StatefulWidget {
  const ManageUniversity({ Key? key }) : super(key: key);

  @override
  _ManageUniversityState createState() => _ManageUniversityState();
}

class _ManageUniversityState extends State<ManageUniversity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        title: text("Manage University", 16),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}