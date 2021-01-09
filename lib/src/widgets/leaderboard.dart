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

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}



class _LeaderBoardState extends State<LeaderBoard> {

  FireStoreService db = FireStoreService();

  List usersProfilesList = [];
  String amer;

  @override
  void initState() {
    fetchUsersList();
    super.initState();
  }

  fetchUsersList() async {
    dynamic resultant = await db.fetchUsersList();
    
    if(resultant == null) {
      print('unable to retrieve');
    } else {
      setState(() {
      usersProfilesList = resultant;

      });
      print(usersProfilesList);
    }
  }
  @override
  Widget build(BuildContext context) {
   
      return Scaffold(
        body: pageBody(context),
        appBar: AppBar(
          title: Center(child: Text('Top scorers', style: TextStyles.navTitle,)),
          backgroundColor: AppColors.lightblue,
        ),
      );
    
  }

  

  

  Widget pageBody(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    var appUser = Provider.of<AppUser>(context);
    //var predictions = Provider.of<List<Prediction>>(context);
    //var predictedFixtures = Provider.of<List<PredictedFixture>>(context);
    var predictionBloc = Provider.of<PredictionBloc>(context);
    FireStoreService db = FireStoreService();
    FirebaseFirestore _db = FirebaseFirestore.instance;
    
 
        return Container(
           child: ListView.builder(
             itemCount: usersProfilesList.length,
             itemBuilder: (context, index){
               return Card(
                 color: AppColors.lightblue,
                 child: ListTile(
                   title: Text(usersProfilesList[index]['email'],style: TextStyles.body,),
                   trailing: Text(usersProfilesList[index]['score'].toString(),
                   style: TextStyles.body,),
                 ),
               );
             } 
           ),
        );

  }
}

