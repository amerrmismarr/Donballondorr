import 'package:Donballondor/src/blocs/auth_bloc.dart';
import 'package:Donballondor/src/blocs/prediction_bloc.dart';
//import 'package:Donballondor/src/models/predictedFixture.dart';
import 'package:Donballondor/src/models/prediction.dart';
import 'package:Donballondor/src/models/user.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Donballondor/src/styles/colors.dart';


class MatchInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
        body: pageBody(context),
      );
    
  }

  Widget pageBody(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.lightblue,
        title: Center(child: Text('Match Info',style: TextStyles.navTitle,)),
      ),
    );
      

    
    
    
  }
}

