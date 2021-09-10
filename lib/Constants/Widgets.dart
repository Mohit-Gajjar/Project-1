import 'package:asms/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

Widget inputFieldSem(String hint, IconData icon, BuildContext context,
    TextEditingController textEditingController) {
  return Container(
    width: MediaQuery.of(context).size.width - 60,
    height: 60,
    decoration: BoxDecoration(
        border: Border.all(width: 2, color: textColor),
        borderRadius: BorderRadius.circular(18)),
    child: Center(
      child: TextField(
        maxLength: 2,
        keyboardType: TextInputType.number,
        controller: textEditingController,
        decoration: InputDecoration(
          counterText: "",
          prefixIcon: Icon(
            icon,
            color: textColor,
          ),
          hintText: hint,
          border: InputBorder.none,
          hintStyle: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 16, color: textColor)),
        ),
        style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 16, color: textColor)),
      ),
    ),
  );
}

Widget btn(String string, double num) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: num),
    height: 60,
    decoration:
        BoxDecoration(color: btnColor, borderRadius: BorderRadius.circular(18)),
    child: Center(
      child: Text(
        string,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 20, color: textColor)),
      ),
    ),
  );
}

Widget text(String name, double num) {
  return Text(
    name,
    style: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: num, color: textColor)),
  );
}

// ignore: non_constant_identifier_names
Widget text_underline(String name, double num) {
  return Text(
    name,
    style: GoogleFonts.poppins(
        decoration: TextDecoration.underline,
        textStyle: TextStyle(fontSize: num, color: textColor)),
  );
}

Widget displayBox(String title,String subtitle, double titleSize, subtitleSize,
    BuildContext context) {
  return Card(
    color: btnColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 25,
      height: 170,
      child: Center(
        child: ListTile(
          title: text(title, titleSize),
          subtitle: text(subtitle, subtitleSize),
        ),
      ),
    ),
  );
}

Widget inputFieldPass(String hint, IconData icon, BuildContext context,
    TextEditingController textEditingController) {
  return Container(
    width: MediaQuery.of(context).size.width - 60,
    height: 60,
    decoration: BoxDecoration(
        border: Border.all(width: 2, color: textColor),
        borderRadius: BorderRadius.circular(18)),
    child: Center(
      child: TextField(
        controller: textEditingController,
        obscureText: true,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.visibility,
            ),
            disabledColor: backColor,
          ),
          prefixIcon: Icon(
            icon,
            color: textColor,
          ),
          hintText: hint,
          border: InputBorder.none,
          hintStyle: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 16, color: textColor)),
        ),
        style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 16, color: textColor)),
      ),
    ),
  );
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
    height: 150,
    width: 200,

    decoration:
        BoxDecoration(color: btnColor, borderRadius: BorderRadius.circular(18)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(height: 70, image: AssetImage(assetImage)),
        text(title, 15),
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
    width: MediaQuery.of(context).size.width - 60,
    height: 60,
    decoration: BoxDecoration(
        border: Border.all(width: 2, color: textColor),
        borderRadius: BorderRadius.circular(18)),
    child: Center(
      child: TextFormField(
        validator: (val) {
          if (val!.isEmpty || val.length < 3) {
            // enterusername +3
          }
        },
        controller: textEditingController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: textColor,
          ),
          hintText: hint,
          border: InputBorder.none,
          hintStyle: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 16, color: textColor)),
        ),
        style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 16, color: textColor)),
      ),
    ),
  );
}

Widget inputFieldContact(String hint, IconData icon, BuildContext context,
    TextEditingController textEditingController) {
  return Container(
    width: MediaQuery.of(context).size.width - 60,
    height: 60,
    decoration: BoxDecoration(
        border: Border.all(width: 2, color: textColor),
        borderRadius: BorderRadius.circular(18)),
    child: Center(
      child: TextFormField(
        validator: (val) {
          if (val!.isEmpty || val.length > 10 || val.length < 12) {
            // Enter Correct credentials
          }
        },
        controller: textEditingController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: textColor,
          ),
          hintText: hint,
          border: InputBorder.none,
          hintStyle: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 16, color: textColor)),
        ),
        style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 16, color: textColor)),
      ),
    ),
  );
}

Widget inputFieldemail(String hint, IconData icon, BuildContext context,
    TextEditingController textEditingController) {
  return Container(
    width: MediaQuery.of(context).size.width - 60,
    height: 60,
    decoration: BoxDecoration(
        border: Border.all(width: 2, color: textColor),
        borderRadius: BorderRadius.circular(18)),
    child: Center(
      child: TextFormField(
        validator: (val) {
          if (RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(val!)) {
          } else {
            //  "Please Enter Correct Email"
          }
        },
        controller: textEditingController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: textColor,
          ),
          hintText: hint,
          border: InputBorder.none,
          hintStyle: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 16, color: textColor)),
        ),
        style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 16, color: textColor)),
      ),
    ),
  );
}

Widget inputFieldEnroll(String hint, IconData icon, BuildContext context,
    TextEditingController textEditingController) {
  return Container(
    width: MediaQuery.of(context).size.width - 60,
    height: 60,
    decoration: BoxDecoration(
        border: Border.all(width: 2, color: textColor),
        borderRadius: BorderRadius.circular(18)),
    child: Center(
      child: TextFormField(
        validator: (val) {
          if (val!.isEmpty || val.length == 12) {
            // Enter Correct credentials
          }
        },
        controller: textEditingController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: textColor,
          ),
          hintText: hint,
          border: InputBorder.none,
          hintStyle: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 16, color: textColor)),
        ),
        style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 16, color: textColor)),
      ),
    ),
  );
}
