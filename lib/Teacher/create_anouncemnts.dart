import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreateAnouncemnt extends StatefulWidget {
  String name = "";
  String subject = "";
  CreateAnouncemnt({Key? key, required this.name, required this.subject})
      : super(key: key);
  @override
  _CreateAnouncemntState createState() => _CreateAnouncemntState();
}

class _CreateAnouncemntState extends State<CreateAnouncemnt> {
  final formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  DateTime dateNow = DateTime.now();
  Future datePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateNow,
        firstDate: DateTime(1640),
        lastDate: DateTime(2030));
    if (picked != null && picked != dateNow) {
      setState(() {
        selectedDate = picked;
        print(selectedDate.toString());
      });
    }
  }

  TextEditingController announcemntController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  Widget selectDate(BuildContext context) {
    return TextButton(
        onPressed: () {
          datePicker(context);
        },
        child: textBlackBold("$selectedDate", 16));
  }

  final snackBar = SnackBar(content: Text('Anouncement Sucessfully Created'));
  createAnouncement() {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> createdAnouncementData = {
        "Message": announcemntController.text,
        "ExpireDate": selectedDate,
        "Subject": widget.subject,
        "TeacherName": widget.name,
        "key": "anouncements",
      };
      DatabaseMethods().createAnouncements(createdAnouncementData);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: appBar("Create Anouncement"),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              inputFieldUsername("Enter The Message", Icons.campaign_outlined,
                  context, announcemntController),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: textBlack),
                      borderRadius: BorderRadius.circular(8)),
                  child: selectDate(context)),
              SizedBox(
                height: 20,
              ),
              btn(
                  name: "Create",
                  size: 100,
                  onPressed: () {
                    if (announcemntController.text.isNotEmpty &&
                        selectedDate != null) {
                      createAnouncement();
                      announcemntController.clear();
                      selectedDate = null;
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
