import 'package:Donballondor/src/blocs/auth_bloc.dart';
import 'package:Donballondor/src/blocs/prediction_bloc.dart';
//import 'package:Donballondor/src/models/predictedFixture.dart';
import 'package:Donballondor/src/models/prediction.dart';
import 'package:Donballondor/src/models/user.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:Donballondor/src/services/firestore_service.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: pageBody(context),
      );
    } else {
      return Scaffold(
        body: pageBody(context),
      );
    }
  }

  Widget pageBody(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    var appUser = Provider.of<AppUser>(context);
    //var predictions = Provider.of<List<Prediction>>(context);
    //var predictedFixtures = Provider.of<List<PredictedFixture>>(context);
    var predictionBloc = Provider.of<PredictionBloc>(context);
    FireStoreService db = FireStoreService();
    FirebaseFirestore _db = FirebaseFirestore.instance;
    
    return StreamBuilder(
      stream: _db.collection('users').doc(appUser.userId).snapshots(),
      

      builder: (context, snapshot){
        if(snapshot.hasData){
        //AppUser userr = snapshot.data;
        print(snapshot.data);
        return Container(
      child: Column(
        children: [
          SizedBox(height: 200,),
          Center(
            child:Text(snapshot.data['score'].toString(), style: TextStyle(color: Colors.white))
          ),
          FlatButton(onPressed: authBloc.logout, child: Text('logout', style: TextStyles.body,))
        ],
      ));
        } else {
          return (Container(color: AppColors.darkblue,
          child: Center(child: Loading())));
        }
    
      });
      

    
    
    
  }
}

