import 'dart:io';

import 'package:Donballondor/src/blocs/auth_bloc.dart';
import 'package:Donballondor/src/blocs/prediction_bloc.dart';
import 'package:Donballondor/src/models/prediction.dart';
import 'package:Donballondor/src/models/user.dart';
import 'package:Donballondor/src/services/firestore_service.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/styles/tabbar.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/widgets/admin_scaffold.dart';
import 'package:Donballondor/src/widgets/button.dart';
import 'package:Donballondor/src/widgets/events.dart';
import 'package:Donballondor/src/widgets/head2head.dart';
import 'package:Donballondor/src/widgets/lineups.dart';
import 'package:Donballondor/src/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Statistics extends StatefulWidget {
  static TabBar get upperTabBar {
    return TabBar(
      unselectedLabelColor: TabBarStyles.unselectedLabelColor,
      labelColor: TabBarStyles.labelColor,
      indicatorColor: TabBarStyles.indicatorColor,
      tabs: <Widget>[
        Tab(
            icon: Icon(
          Icons.list,
        )),
        Tab(icon: Icon(Icons.shopping_cart)),
        Tab(icon: Icon(Icons.person)),
      ],
    );
  }

  final String homeTeamId;
  final String awayTeamId;
  final String fixtureId;
  final String homeTeamName;
  final String awayTeamName;
  final String homeTeamLogo;
  final String awayTeamLogo;
  final String statusShort;
  final String goalsHomeTeam;
  final String goalsAwayTeam;
  final String homeTeamPredictionn;
  final String awayTeamPredictionn;

  

  Statistics(
      {this.homeTeamId,
      this.awayTeamId,
      this.fixtureId,
      this.homeTeamName,
      this.awayTeamName,
      this.homeTeamLogo,
      this.awayTeamLogo,
      this.statusShort,
      this.goalsHomeTeam,
      this.goalsAwayTeam,
      this.homeTeamPredictionn,
      this.awayTeamPredictionn});
  @override
  _StatisticsState createState() => _StatisticsState(
      homeTeamId,
      awayTeamId,
      fixtureId,
      homeTeamName,
      awayTeamName,
      homeTeamLogo,
      awayTeamLogo,
      statusShort,
      goalsHomeTeam,
      goalsAwayTeam,
      homeTeamPredictionn,
      awayTeamPredictionn);
}

class _StatisticsState extends State<Statistics> {

  TextEditingController _homeTeamController;
  TextEditingController _awayTeamController;

  FirebaseFirestore _db = FirebaseFirestore.instance;
  


  
  String homeTeamId;
  String awayTeamId;
  String fixtureId;
  String homeTeamName;
  String awayTeamName;
  String homeTeamLogo;
  String awayTeamLogo;
  String statusShort;
  String goalsHomeTeam;
  String goalsAwayTeam;
  String homeTeamPredictionn;
  String awayTeamPredictionn;

  String homeTeamPrediction;
  String awayTeamPrediction;

  

  _StatisticsState(
      this.homeTeamId,
      this.awayTeamId,
      this.fixtureId,
      this.homeTeamName,
      this.awayTeamName,
      this.homeTeamLogo,
      this.awayTeamLogo,
      this.statusShort,
      this.goalsHomeTeam,
      this.goalsAwayTeam,
      this.homeTeamPredictionn,
      this.awayTeamPredictionn);


  @override
  void initState() {
    
    var prediction_bloc = Provider.of<PredictionBloc>(context, listen: false);
    prediction_bloc.predictionSaved.listen((saved) {  
      if(saved != null && saved == true  && context != null){
        Fluttertoast.showToast(
        msg: "Done! Good luck",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColors.notshinygold,
        textColor: AppColors.darkblue,
        fontSize: 16.0
    );

        Navigator.of(context).pop();
        


      }
    });
    _homeTeamController = TextEditingController();
    _awayTeamController = TextEditingController();

     _homeTeamController.text = homeTeamPredictionn;
     _awayTeamController.text = awayTeamPredictionn;


    super.initState();
  }


 
  @override
  Widget build(BuildContext context) {
    var predictionBloc = Provider.of<PredictionBloc>(context);
    var authBloc = Provider.of<AuthBloc>(context);
    final db = FireStoreService();
    final appUser = Provider.of<AppUser>(context);
    Prediction existingPrediction;
    


    
    

    return (Platform.isIOS) ?  CupertinoPageScaffold(
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  AppNavBar.cupertinoNavBar(
                      title: 'Admin', buildContext: context)
                ];
              },
              body: AdminScaffold.cupertinoTabScaffold))
              : DefaultTabController(
        length: 3,
        
        child: 
        FutureBuilder<Prediction>(
          future: db.fetchPrediction(fixtureId, appUser.userId),
          builder: (context, snapshot) {
            if(snapshot.data != null){
            existingPrediction = snapshot.data;
            print(existingPrediction.awayTeamPrediction.toString());
            }
            

            return Consumer<AppUser>(
            builder: (_,user,__){
              if(user != null) predictionBloc.changeAppUserId(user.userId);
              return (user != null) ?
              Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: AppColors.notshinygold,
                label: Text('PREDICT', style: TextStyle(color: AppColors.darkblue),),
                onPressed: (){
                if(fixtureId != null) predictionBloc.changeFixtureId(fixtureId);
                   // if(goalsHomeTeam != null) predictionBloc.changeHomeTeamScore(goalsHomeTeam);
                   // if(goalsAwayTeam != null) predictionBloc.changeAwayTeamScore(goalsAwayTeam);
                    if(statusShort != null) predictionBloc.changeMatchStatus(statusShort);
                    //print(fixtureId);
                   // print(goalsHomeTeam);
                    //print(goalsAwayTeam);
                   // print(statusShort);

                    createAlertDialog(context, predictionBloc, existingPrediction, appUser);

                   
                }  
              ),
              
              body: NestedScrollView(
                
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    AppNavBar.materialStatisticsSliverAppBar(
                        homeTeamName: homeTeamName,
                        homeTeamScore: goalsHomeTeam,
                        awayTeamName: awayTeamName,
                        awayTeamScore: goalsAwayTeam,
                        tabBar: Statistics.upperTabBar),
                  ];
                },
                body: TabBarView(
                  children: <Widget>[
                    Lineups(
                      fixtureId: fixtureId,
                      homeTeamName: homeTeamName,
                      homeTeamLogo: homeTeamLogo,
                      awayTeamLogo: awayTeamLogo,
                      awayTeamName: awayTeamName,
                    ),
                    Events(
                      fixtureId: fixtureId,
                    ),
                    Head2Head(
                      homeTeamId: homeTeamId,
                      awayTeamId: awayTeamId,
                    ),
                  ],
                ),
              ),
            ) : Container(child: Center(child: Text('please log in'),));
            }
            );
          }
        )
      
        
      );
    
     
      
  
  }

  createAlertDialog(BuildContext context, PredictionBloc predictionBloc, Prediction existingPrediction,
  AppUser appUser) {
    var buttonLabel = (existingPrediction != null) ? 'Change' : 'Submit';
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Color.fromRGBO(41, 48, 67, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 200.0,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                height: 20.0,
                                width: 20.0,
                                child: Image.network(widget.homeTeamLogo),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                widget.homeTeamName,
                                style: TextStyle(
                                  color: Color.fromRGBO(222, 177, 92, 1),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              widget.statusShort == 'NS' ||
                                      widget.statusShort == 'TBD'
                                      || widget.statusShort == 'FT'
                                  ? 
                                           Container(
                                            height: 40,
                                            width: 50,
                                            child: TextField(
                                              keyboardType: TextInputType.number,
                                              controller: _homeTeamController,
                                              onChanged: (value){
                                                if(value != null){
                                                this.homeTeamPrediction = value;
                                                } else {
                                                  this.homeTeamPrediction = existingPrediction.homeTeamPrediction.toString();
                                                }
                                              },
                                              decoration: InputDecoration(
                                                
                                                hintText: " ",
                                                
                                                errorStyle: TextStyles.error
                                              ),
                                            )
                                          )
                                        
                                      
                                  : Container(
                                      child: Container(
                                      child: Text(
                                        'X',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              SizedBox(
                                width: 25.0,
                              )
                            ],
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                height: 20.0,
                                width: 20.0,
                                child: Image.network(widget.awayTeamLogo),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                widget.awayTeamName,
                                style: TextStyle(
                                  color: Color.fromRGBO(222, 177, 92, 1),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              widget.statusShort == 'NS' ||
                                      widget.statusShort == 'TBD'
                                      || widget.statusShort == 'FT'
                                  ?  
                                           Container(
                                            height: 40,
                                            width: 50,
                                            child: TextField(
                                              keyboardType: TextInputType.number,
                                              controller: _awayTeamController,
                                              onChanged: (value) {
                                                if(value != null){
                                                this.awayTeamPrediction = value;
                                                } else {
                                                  this.awayTeamPrediction = existingPrediction.awayTeamPrediction.toString();
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText:" ",
                                                
                                                errorStyle: TextStyles.error
                                              ),
                                            )
                                          )
                                        
                                      
                                    
                                  : Container(
                                      child: Container(
                                      child: Text(
                                        'X',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              SizedBox(
                                width: 25.0,
                              )
                            ],
                          ),
                        ]),
                    if (widget.statusShort == 'NS' ||
                        widget.statusShort == 'TBD'
                        || widget.statusShort == 'FT')
                        
                      SizedBox(
                        width: 520.0,
                        child: /*StreamBuilder<bool>(
                          stream: predictionBloc.isValid,
                          builder: (context, snapshot) {
                            return*/ AppButton(buttonText: 
                             buttonLabel,
                             buttonType: 
                             /*(snapshot.data == true) ?*/ ButtonType.NotShinyGold,
                             /*: ButtonType.Disabled,*/
                             onPressed: (){
                             
                             //var options = SetOptions(merge: true);
                             if(this.homeTeamPrediction == null){
                              this.homeTeamPrediction = existingPrediction.homeTeamPrediction.toString();
                             }

                             if(this.awayTeamPrediction == null){
                              this.awayTeamPrediction = existingPrediction.awayTeamPrediction.toString();
                             }


                             predictionBloc.savePrediction(this.homeTeamPrediction, this.awayTeamPrediction,
                             this.statusShort, this.fixtureId);
                                                  Fluttertoast.showToast(
                              msg: "Done! Good luck",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 2,
                              backgroundColor: AppColors.notshinygold,
                              textColor: AppColors.darkblue,
                              fontSize: 16.0
                          );

                              Navigator.of(context).pop();

                              /*_db.collection('users')
                                .doc(appUser.userId)
                                .collection('Predictions')
                                .doc(fixtureId)
                                .set({
                                  "homeTeamPrediction" : this.homeTeamPrediction,
                                  "awayTeamPrediction" : this.awayTeamPrediction,
                                  "matchStatus": statusShort,
                                  "fixtureId" : fixtureId

                                }, options);*/
                             //_homeTeamController.text = existingPrediction.homeTeamPrediction.toString();
                             //_awayTeamController.text = existingPrediction.awayTeamPrediction.toString();
                             //Navigator.of(context).pop();
                             })
                          /*}*/
                       /* )*/
                      )
                    else
                      widget.statusShort == 'PST'
                          ? Container(
                              child: Text(
                              'Match Postponed',
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold),
                            ))
                          : Container(
                              child: Text(
                              'Prediction time is over',
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold),
                            ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
