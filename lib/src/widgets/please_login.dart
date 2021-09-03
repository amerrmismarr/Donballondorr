import 'dart:async';

import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PleaseLogin extends StatefulWidget {
  @override
  _PleaseLoginState createState() => _PleaseLoginState();
}

class _PleaseLoginState extends State<PleaseLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 100,
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
                'Please log in to view your profile, predict matches & \n WIN PRIZES!',
                style: TextStyles.subTitle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          AppButton(
            buttonText: 'Login',
            buttonType: ButtonType.NotShinyGold,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
