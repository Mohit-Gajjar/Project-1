import 'package:asms/Constants/Constants.dart';
import 'package:asms/Management/ManageLectures.dart';
import 'package:asms/Management/ManageSubject.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



Widget inputFieldSem(String hint, IconData icon, BuildContext context,
    TextEditingController textEditingController) {
  return Container(
    width: 300,
    height: 60,
    child: Center(
      child: TextField(
        maxLength: 1,
        keyboardType: TextInputType.number,
        controller: textEditingController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.circular(8)),
          counterText: "",
          prefixIcon: Icon(
            icon,
            color: textBlack,
          ),
          labelText: hint,
          labelStyle: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 16, color: textBlack)),
        ),
        style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 16, color: textBlack)),
      ),
    ),
  );
}

// ignore: camel_case_types, must_be_immutable
class btn extends StatelessWidget {
  final VoidCallback onPressed;
  String name;
  double size;
  btn({required this.name, required this.size, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Text(
          name,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 20, color: textColor)),
        ),
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          onSurface: Colors.grey,
          minimumSize: Size(size, 60),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        onPressed: () => onPressed());
  }
}

Widget text(String name, double num) {
  return Text(
    name,
    style: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: num, color: textColor)),
  );
}

Widget textBlackBoldCenter(String name, double num) {
  return Text(
    name,
    textAlign: TextAlign.center,
    style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        textStyle: TextStyle(fontSize: num, color: Colors.black)),
  );
}

Widget textBlackBold(String name, double num) {
  return Text(
    name,
    style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        textStyle: TextStyle(fontSize: num, color: Colors.black)),
  );
}

Widget textBlackThinCenter(String name, double num) {
  return Text(
    name,
    textAlign: TextAlign.center,
    style: GoogleFonts.poppins(
        fontWeight: FontWeight.normal,
        textStyle: TextStyle(fontSize: num, color: Colors.black)),
  );
}

Widget textBlackThin(String name, double num) {
  return Text(
    name,
    style: GoogleFonts.poppins(
        fontWeight: FontWeight.normal,
        textStyle: TextStyle(fontSize: num, color: Colors.black)),
  );
}

// ignore: non_constant_identifier_names
Widget text_underline(String name, double num) {
  return Text(
    name,
    style: GoogleFonts.poppins(
        decoration: TextDecoration.underline,
        textStyle: TextStyle(fontSize: num, color: textBlack)),
  );
}

Widget displayBox(
    String title, String subtitle, double titleSize, subtitleSize) {
  return Container(
    width: 300,
    height: 150,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0), color: btnColor),
    child: Center(
      child: ListTile(
        title: text(title, titleSize),
        subtitle: text(subtitle, subtitleSize),
      ),
    ),
  );
}

Widget displayBoxTablet(
    String title, String subtitle, double titleSize, subtitleSize) {
  return Container(
    width: 200,
    height: 100,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0), color: btnColor),
    child: Center(
      child: ListTile(
        title: text(title, titleSize),
        subtitle: text(subtitle, subtitleSize),
      ),
    ),
  );
}

Widget displayBoxMobile(String title, String subtitle, double titleSize,
    subtitleSize, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width - 110,
    height: 150,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0), color: btnColor),
    child: Center(
      child: ListTile(
        title: text(title, titleSize),
        subtitle: text(subtitle, subtitleSize),
      ),
    ),
  );
}

// ignore: camel_case_types, must_be_immutable
class inputFieldPass extends StatefulWidget {
  String hint;
  IconData icon;
  TextEditingController textEditingController;
  inputFieldPass(
      {required this.hint,
      required this.icon,
      required this.textEditingController});

  @override
  State<inputFieldPass> createState() => PasswordTextBox();
}

class PasswordTextBox extends State<inputFieldPass> {
  bool isVisable = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 300,
      child: Center(
        child: TextFormField(
          controller: widget.textEditingController,
          obscureText: !isVisable,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2),
                borderRadius: BorderRadius.circular(8.0)),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  if (isVisable == true) {
                    isVisable = false;
                  } else if (isVisable == false) {
                    isVisable = true;
                  }
                });
              },
              icon: Icon(
                Icons.visibility,
              ),
              disabledColor: textBlack,
            ),
            prefixIcon: Icon(
              widget.icon,
              color: textBlack,
            ),
            labelText: widget.hint,
            labelStyle: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 16, color: textBlack)),
          ),
          style: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 16, color: textBlack)),
        ),
      ),
    );
  }
}

Widget tbox(String title, subtitle, double titleSize, subtitleSize,
    BuildContext context) {
  return Card(
    color: btnColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: SizedBox(
        width: MediaQuery.of(context).size.width - 25,
        height: 170,
        child: Container(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              text(title, titleSize),
              text(subtitle, subtitleSize),
            ],
          ),
        )),
  );
}

Widget gridTile(String title, String assetImage, BuildContext context) {
  return Container(
    margin: EdgeInsets.all(5),
    height: 100,
    width: 150,
    decoration:
        BoxDecoration(color: btnColor, borderRadius: BorderRadius.circular(18)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(height: 60, image: AssetImage(assetImage)),
        text(title, 12),
      ],
    ),
  );
}

Widget gridTileMob(String title, String assetImage, BuildContext context) {
  return Container(
    margin: EdgeInsets.all(5),
    height: 130,
    width: 200,
    decoration:
        BoxDecoration(color: btnColor, borderRadius: BorderRadius.circular(18)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(height: 60, image: AssetImage(assetImage)),
        text(title, 12),
      ],
    ),
  );
}

Widget gridTileAnd(String title, String assetImage, BuildContext context) {
  return Container(
    margin: EdgeInsets.all(5),
    height: 130,
    width: 160,
    decoration:
        BoxDecoration(color: btnColor, borderRadius: BorderRadius.circular(18)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(height: 60, image: AssetImage(assetImage)),
        text(title, 12),
      ],
    ),
  );
}

Widget imageBox(String name, double num) {
  return Image(height: num, image: AssetImage(name));
}

Widget inputFieldUsername(String hint, IconData icon, BuildContext context,
    TextEditingController textEditingController) {
  return Container(
    height: 60,
    width: 300,
    child: Center(
      child: TextFormField(
        controller: textEditingController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.circular(8.0)),
          prefixIcon: Icon(
            icon,
            color: textBlack,
          ),
          labelText: hint,
          labelStyle: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 16, color: textBlack)),
        ),
        style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 16, color: textBlack)),
      ),
    ),
  );
}

Widget inputFieldContact(String hint, IconData icon, BuildContext context,
    TextEditingController textEditingController) {
  return Container(
    height: 60,
    width: 300,
    child: Center(
      child: TextFormField(
        controller: textEditingController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.circular(8.0)),
          prefixIcon: Icon(
            icon,
            color: textBlack,
          ),
          labelText: hint,
          labelStyle: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 16, color: textBlack)),
        ),
        style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 16, color: textBlack)),
      ),
    ),
  );
}

Widget inputFieldemail(String hint, IconData icon, BuildContext context,
    TextEditingController textEditingController) {
  return Container(
    height: 60,
    width: 300,
    child: Center(
      child: TextFormField(
        controller: textEditingController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.circular(8.0)),
          prefixIcon: Icon(
            icon,
            color: textBlack,
          ),
          labelText: hint,
          labelStyle: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 16, color: textBlack)),
        ),
        style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 16, color: textBlack)),
      ),
    ),
  );
}

Widget inputFieldEnroll(String hint, IconData icon, BuildContext context,
    TextEditingController textEditingController) {
  return Container(
    height: 60,
    width: 300,
    child: Center(
      child: TextFormField(
        controller: textEditingController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.circular(8.0)),
          prefixIcon: Icon(
            icon,
            color: textBlack,
          ),
          labelText: hint,
          labelStyle: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 16, color: textBlack)),
        ),
        style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 16, color: textBlack)),
      ),
    ),
  );
}

class UniversityTile extends StatefulWidget {
  UniversityTile(
      this.courseName, this.departmentName, this.semester, this.universityName);

  final String departmentName;
  final String courseName;
  final String semester;
  final String universityName;

  @override
  State<UniversityTile> createState() => _UniversityTileState();
}

class _UniversityTileState extends State<UniversityTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textBlackBold("University Information", 20),
        SizedBox(
          height: 10,
        ),
        textBlackThin(widget.universityName, 16),
        textBlackThin(widget.departmentName, 16),
        textBlackThin(widget.semester, 16),
        textBlackThin(widget.courseName, 16),
      ],
    );
  }
}

class TotalCard extends StatelessWidget {
  final int counter;
  final String title;
  TotalCard({
    required this.counter,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.width / 15,
        width: MediaQuery.of(context).size.width / 9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: btnColor),
        child: Center(
          child: ListTile(
              title: text(
                  counter.toString(), MediaQuery.of(context).size.width / 50),
              subtitle: text(title, MediaQuery.of(context).size.width / 90)),
        ));
  }
}

class TotalCardTeacherDesktop extends StatelessWidget {
  final int counter;
  final String title;
  TotalCardTeacherDesktop({
    required this.counter,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: btnColor),
        child: Center(
          child: ListTile(
              title: text(counter.toString(), 50), subtitle: text(title, 16)),
        ));
  }
}

class TotalCardTeacherTablet extends StatelessWidget {
  final int counter;
  final String title;
  TotalCardTeacherTablet({
    required this.counter,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: btnColor),
        child: Center(
          child: ListTile(
              title: text(counter.toString(), 30), subtitle: text(title, 16)),
        ));
  }
}

class GridTabs extends StatelessWidget {
  const GridTabs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ManageSubject()));
            },
            child: gridTile("Manage Subject", "assets/1.png", context)),
        GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ManageLectures()));
            },
            child: gridTile("Manage Lecture", "assets/1.png", context)),
      ],
    );
  }
}

class TotalCards extends StatelessWidget {
  const TotalCards({
    Key? key,
    required this.studentCounter,
    required this.teacherCounter,
    required this.subjectCounter,
    required this.lectureCounter,
  }) : super(key: key);
  final int studentCounter;
  final int teacherCounter;
  final int subjectCounter;
  final int lectureCounter;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TotalCard(
                counter: studentCounter,
                title: 'Total Students',
              ),
              SizedBox(
                width: 20,
              ),
              TotalCard(
                counter: teacherCounter,
                title: 'Total Teachers',
              ),
              SizedBox(
                width: 20,
              ),
              TotalCard(
                counter: subjectCounter,
                title: 'Total Subjects',
              ),
              SizedBox(
                width: 20,
              ),
              TotalCard(
                counter: lectureCounter,
                title: 'Total Lectures',
              ),
            ],
          ),
        ));
  }
}

PreferredSizeWidget appBar(String title) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: textBlackBoldCenter(title, 15),
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
  );
}
