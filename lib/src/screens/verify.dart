import 'dart:async';

import 'package:Donballondor/src/styles/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  

  
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
     });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
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
              image: DecorationImage(
                  image: AssetImage('assets/PNG app.png'))),
        ),
        Center(
            child: Text(
          'Donballondor',
          style: TextStyles.body
        )),
        SizedBox(height: 20.0,),
           Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text('An email has been sent to ${user.email}. \n Please verify', 
          style: TextStyles.subTitle,
          textAlign: TextAlign.center,),),
        ),

        ],
              
      ),
      
    );
  }

  Future<void> checkEmailVerified() async  {
    user = auth.currentUser;
    await user.reload();
    if(user.emailVerified){
      timer.cancel();
      Navigator.pushReplacementNamed(context, '/landing');
    }
  }
}