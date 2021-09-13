import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/CustomWidgets.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CreateLectures extends StatefulWidget {
  const CreateLectures({Key? key}) : super(key: key);

  @override
  _CreateLecturesState createState() => _CreateLecturesState();
}

class _CreateLecturesState extends State<CreateLectures> {
  TextEditingController subjectController = new TextEditingController();
  TextEditingController lectureNameController = new TextEditingController();

  final formKey = GlobalKey<FormState>();
  final snackBar = SnackBar(content: Text('Lecture Created Sucessfully'));
  DateTime? selectedDate;
  DateTime? fromTimefinal;
  DateTime? toTimefinal;
  createLectures() {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> createdLecturesMap = {
        "Subject_Name": subjectController.text,
        "Lecture_Name": lectureNameController.text,
        "Date": selectedDate,
        "From_Time": fromTimefinal,
        "To_Time": toTimefinal
      };
      DatabaseMethods().createLectureData(createdLecturesMap);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      subjectController.clear();
      lectureNameController.clear();
    }
  }

  CustomPicker timePicker =
      new CustomPicker(currentTime: DateTime.now(), locale: LocaleType.en);
  Widget selectDate() {
    return TextButton(
        onPressed: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime.now(), onChanged: (date) {
            selectedDate = date;
            print('change $date');
          }, onConfirm: (date) {
            print('confirm $date');
            selectedDate = date;
            setState(() {});
          }, currentTime: DateTime.now(), locale: LocaleType.en);
        },
        child: text("$selectedDate", 16));
  }

  Widget fromTime() {
    return TextButton(
        onPressed: () {
          DatePicker.showTimePicker(context, showTitleActions: true,
              onChanged: (date) {
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
            fromTimefinal = date;
          }, onConfirm: (date) {
            fromTimefinal = date;
            setState(() {});
            print('confirm $date');
          }, currentTime: DateTime.now());
        },
        child: text("$fromTimefinal", 16));
  }

  Widget toTime() {
    return TextButton(
        onPressed: () {
          DatePicker.showTimePicker(context, showTitleActions: true,
              onChanged: (date) {
            toTimefinal = date;
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
          }, onConfirm: (date) {
            toTimefinal = date;
            setState(() {});
            print('confirm $date');
          }, currentTime: DateTime.now());
        },
        child: text("$toTimefinal", 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        title: text("Create Lecture", 16),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                inputFieldUsername("Enter Subject Name", Icons.subject, context,
                    subjectController),
                SizedBox(
                  height: 20,
                ),
                inputFieldUsername("Enter Lecture Name", Icons.subject, context,
                    lectureNameController),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: textColor),
                        borderRadius: BorderRadius.circular(18)),
                    child: selectDate()),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: textColor),
                        borderRadius: BorderRadius.circular(18)),
                    child: fromTime()),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: textColor),
                        borderRadius: BorderRadius.circular(18)),
                    child: toTime()),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      if (subjectController.text.isNotEmpty &&
                          lectureNameController.text.isNotEmpty) {
                        createLectures();
                      }
                    },
                    child: btn("Create", 100))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
