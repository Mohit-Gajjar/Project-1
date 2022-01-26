import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nanoid/async.dart';

class CreateLectures extends StatefulWidget {
  const CreateLectures({Key? key}) : super(key: key);

  @override
  _CreateLecturesState createState() => _CreateLecturesState();
}

class _CreateLecturesState extends State<CreateLectures> {
  TextEditingController subjectController = new TextEditingController();
  TextEditingController lectureNameController = new TextEditingController();
  TextEditingController destinationExternalID = new TextEditingController();
  TextEditingController externalIdController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController durationController = new TextEditingController();

  final formKey = GlobalKey<FormState>();
  final snackBar = SnackBar(content: Text('Lecture Created Sucessfully'));
  DateTime? selectedDate;
  @override
  void initState() {
    super.initState();
  }

  String id = "";
  generateId() async {
    id = await nanoid(10);
    print(id);
  }

  TimeOfDay? fromTimefinal;
  Duration? duration;
  TimeOfDay? toTimefinal;

  calculateDuration() {
    var format = DateFormat("HH:mm");
    var one = format.parse(fromTimefinal
        .toString()
        .replaceAll("TimeOfDay", "")
        .replaceAll("(", "")
        .replaceAll(")", ""));
    var two = format.parse(
      toTimefinal
          .toString()
          .replaceAll("TimeOfDay", "")
          .replaceAll("(", "")
          .replaceAll(")", ""),
    );
    setState(() {
      duration = two.difference(one);
    });
    print("${two.difference(one)}");
  }

  TextEditingController classController = new TextEditingController();
  createLectures() {
    if (formKey.currentState!.validate()) {
      generateId();
      Map<String, dynamic> createdLecturesMap = {
        "Subject_Name": subjectController.text,
        "Lecture_Name": lectureNameController.text,
        "DateOfAdding": DateTime.now(),
        "From_Time": fromTimefinal
            .toString()
            .replaceAll("TimeOfDay", "")
            .replaceAll("(", "")
            .replaceAll(")", ""),
        "To_Time": toTimefinal
            .toString()
            .replaceAll("TimeOfDay", "")
            .replaceAll("(", "")
            .replaceAll(")", ""),
        "department": "Computer",
        "duration": duration!.inSeconds,
        "destinationExternalId": destinationExternalID.text,
        "externalId": externalIdController.text,
        "destinationTag": descriptionController.text,
        "onGoing": null,
        "Id": id,
        "class": classController.text,
        "monday": mon,
        "tuesday": tue,
        "wednesday": wed,
        "thursday": thurs,
        "friday": fri,
        "saturday": sat,
        "sunday": sun,
      };
      DatabaseMethods().createLectureData(createdLecturesMap, id);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      subjectController.clear();
      lectureNameController.clear();
      durationController.clear();
      fromTimefinal = null;
      toTimefinal = null;
      selectedDate = null;
    }
  }

  bool mon = false;
  bool tue = false;
  bool wed = false;
  bool thurs = false;
  bool fri = false;
  bool sat = false;
  bool sun = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: appBar("Create Lecture"),
      body: Container(
        child: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  inputFieldUsername("Enter Subject Name", Icons.subject,
                      context, subjectController),
                  SizedBox(
                    height: 20,
                  ),
                  inputFieldUsername("Enter Lecture Name", Icons.subject,
                      context, lectureNameController),
                  SizedBox(
                    height: 20,
                  ),
                  inputFieldUsername("Enter Classname Name",
                      Icons.class__outlined, context, classController),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final TimeOfDay? timeOfDay = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        initialEntryMode: TimePickerEntryMode.dial,
                      );
                      if (timeOfDay != null && timeOfDay != TimeOfDay.now()) {
                        setState(() {
                          fromTimefinal = timeOfDay;
                        });
                      }
                    },
                    child: Container(
                      width: 300,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: textBlack),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: textBlackThin(
                              "From: " +
                                  fromTimefinal
                                      .toString()
                                      .replaceAll("TimeOfDay", "")
                                      .replaceAll("(", "")
                                      .replaceAll(")", ""),
                              16)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final TimeOfDay? timeOfDay = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        initialEntryMode: TimePickerEntryMode.dial,
                      );
                      if (timeOfDay != null && timeOfDay != TimeOfDay.now()) {
                        setState(() {
                          toTimefinal = timeOfDay;
                        });
                      }
                    },
                    child: Container(
                      width: 300,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: textBlack),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: textBlackThin(
                              "To: " +
                                  toTimefinal
                                      .toString()
                                      .replaceAll("TimeOfDay", "")
                                      .replaceAll("(", "")
                                      .replaceAll(")", ""),
                              16)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  daysOfWeek(),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  inputFieldUsername(
                      "Enter Tag", Icons.subject, context, destinationExternalID),
                  SizedBox(
                    height: 20,
                  ),
                  inputFieldContact(
                      "Enter External Id",
                      Icons.format_list_numbered,
                      context,
                      externalIdController),
                  SizedBox(
                    height: 20,
                  ),
                  inputFieldContact(
                      "Enter Description",
                      Icons.format_list_numbered,
                      context,
                      descriptionController),
                  SizedBox(
                    height: 20,
                  ),
                  btn(
                    onPressed: () {
                      if (subjectController.text.isNotEmpty &&
                          lectureNameController.text.isNotEmpty &&
                          fromTimefinal != null &&
                          toTimefinal != null &&
                          destinationExternalID.text.isNotEmpty &&
                          externalIdController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty &&
                          (mon != false ||
                              tue != false ||
                              wed != false ||
                              thurs != false ||
                              fri != false ||
                              sat != false ||
                              sun != false)) {
                        calculateDuration();
                        createLectures();
                      }
                    },
                    name: 'Create',
                    size: 100,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container daysOfWeek() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                textBlackThin("sun", 16),
                Checkbox(
                    focusColor: textColor,
                    value: sun,
                    onChanged: (val) {
                      setState(() {
                        sun = val!;
                      });
                    }),
              ],
            ),
            Column(
              children: [
                textBlackThin("mon", 16),
                Checkbox(
                    value: mon,
                    onChanged: (val) {
                      setState(() {
                        mon = val!;
                      });
                    }),
              ],
            ),
            Column(
              children: [
                textBlackThin("tue", 16),
                Checkbox(
                    value: tue,
                    onChanged: (val) {
                      setState(() {
                        tue = val!;
                      });
                    }),
              ],
            ),
            Column(
              children: [
                textBlackThin("wed", 16),
                Checkbox(
                    value: wed,
                    onChanged: (val) {
                      setState(() {
                        wed = val!;
                      });
                    }),
              ],
            ),
            Column(
              children: [
                textBlackThin("thurs", 16),
                Checkbox(
                    value: thurs,
                    onChanged: (val) {
                      setState(() {
                        thurs = val!;
                      });
                    }),
              ],
            ),
            Column(
              children: [
                textBlackThin("fri", 16),
                Checkbox(
                    value: fri,
                    onChanged: (val) {
                      setState(() {
                        fri = val!;
                      });
                    }),
              ],
            ),
            Column(
              children: [
                textBlackThin("sat", 16),
                Checkbox(
                    value: sat,
                    onChanged: (val) {
                      setState(() {
                        sat = val!;
                      });
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
