import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:flutter/material.dart';

class CreateSubject extends StatefulWidget {
  const CreateSubject({Key? key}) : super(key: key);

  @override
  _CreateSubjectState createState() => _CreateSubjectState();
}

class _CreateSubjectState extends State<CreateSubject> {
  TextEditingController subjectController = new TextEditingController();
  TextEditingController subjectCodeController = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  final snackBar = SnackBar(content: Text('Subject Created Sucessfully'));
  createSubject() {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> createdSubjectMap = {
        "Subject_Name": subjectController.text,
        "Subject_Code": subjectCodeController.text
      };
      DatabaseMethods().createSubjectData(createdSubjectMap);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      subjectCodeController.clear();
      subjectController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        appBar: appBar("Create Subject"),
        body: Container(
            child: Form(
                key: formKey,
                child: Center(
                  child: Container(
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
                        inputFieldContact(
                            "Enter Subject Code",
                            Icons.format_list_numbered,
                            context,
                            subjectCodeController),
                        SizedBox(
                          height: 20,
                        ),
                        btn(
                          name: 'Create',
                          size: 100,
                          onPressed: () {
                            if (subjectController.text.isNotEmpty &&
                                subjectCodeController.text.isNotEmpty) {
                              createSubject();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ))));
  }
}
