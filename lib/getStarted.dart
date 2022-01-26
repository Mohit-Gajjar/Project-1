import 'package:asms/Constants/Widgets.dart';
import 'package:flutter/material.dart';

import 'OTP/Levels/LevelsPage.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imageBox('assets/4.png', 480),
              textBlackBoldCenter("Automate the \nWorkflow", 30),
              textBlackThinCenter("Level Up the \nManagement System", 20),
              SizedBox(
                height: 30,
              ),
              btn(
                  name: "Get Started",
                  size: 200,
                  onPressed: () {
                    // HelperFunctions.saveIsViewedState(true);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LevelPage()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
