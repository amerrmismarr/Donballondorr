import 'dart:async';

import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/styles/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Instructions extends StatefulWidget {
  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  CustomTheme customTheme = CustomTheme();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            height: 100.0,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage('assets/PNG app.png'))),
          ),
          Center(child: Text('Donballondor', style: TextStyles.body)),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Predict matches & \n WIN PRIZES!',
                style: customTheme.isDarkMode == true
                    ? TextStyles.subTitle
                    : TextStyles.subTitleLight,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    '• Predict exact score ',
                    style: customTheme.isDarkMode == true
                        ? TextStyles.info
                        : TextStyles.infoLight,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    '  + 50 points',
                    style: customTheme.isDarkMode == true
                        ? TextStyles.info
                        : TextStyles.infoLight,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    '• Predict outcome ',
                    style: customTheme.isDarkMode == true
                        ? TextStyles.info
                        : TextStyles.infoLight,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    '  + 25 points',
                    style: customTheme.isDarkMode == true
                        ? TextStyles.info
                        : TextStyles.infoLight,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    '• Predict incorrectly ',
                    style: customTheme.isDarkMode == true
                        ? TextStyles.info
                        : TextStyles.infoLight,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    '  - 25 points',
                    style: customTheme.isDarkMode == true
                        ? TextStyles.info
                        : TextStyles.infoLight,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'One lucky winner every month will get prizes!',
                style: customTheme.isDarkMode == true
                    ? TextStyles.info
                    : TextStyles.infoLight,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
