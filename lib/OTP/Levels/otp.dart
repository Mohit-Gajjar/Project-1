import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageBox('assets/2.png', 300),
          text("Enter OTP", 32),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _textFieldOTP(),
                _textFieldOTP(),
                _textFieldOTP(),
                _textFieldOTP(),
                _textFieldOTP(),
                _textFieldOTP(),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          btn("Submit", 150)
        ],
      ),
    );
  }

  Widget _textFieldOTP() {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: textColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 20, color: btnColor)),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counterText: "",
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
