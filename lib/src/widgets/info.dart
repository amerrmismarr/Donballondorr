import 'dart:async';

import 'package:Donballondor/src/app.dart';
import 'package:Donballondor/src/blocs/auth_bloc.dart';
import 'package:Donballondor/src/blocs/prediction_bloc.dart';
import 'package:Donballondor/src/models/prediction.dart';
import 'package:Donballondor/src/models/user.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/styles/themes.dart';
import 'package:Donballondor/src/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:Donballondor/src/widgets/lineups.dart' as second;
import 'package:Donballondor/src/widgets/head2head.dart' as third;
import 'package:Donballondor/src/widgets/events.dart' as first;
import 'package:Donballondor/src/widgets/match_info.dart' as fourth;

import 'button.dart';

class Orders extends StatefulWidget {
  final String fixtureId;

  Orders({this.fixtureId});
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  TabController controller;
  StreamController _streamController = StreamController();
  List<dynamic> fixture;
  Stream get _stream => _streamController.stream.asBroadcastStream();

  String homeTeamId;
  String awayTeamId;
  String homeTeamName;
  String awayTeamName;
  String homeTeamLogo;
  String awayTeamLogo;
  String statusShort;

  String homeTeamPrediction;
  String awayTeamPrediction;

  TextEditingController _homeTeamController;
  TextEditingController _awayTeamController;

  CustomTheme customTheme = CustomTheme();

  @override
  void initState() {
    getFixture();

    // ignore: todo
    // TODO: implement initState
    super.initState();
    controller = new TabController(vsync: this, length: 4, initialIndex: 0);
  }

  Future getFixture() async {
    var response = await http.get(
        Uri.parse('https://api-football-v1.p.rapidapi.com/v2/fixtures/id/' +
            widget.fixtureId),
        headers: {
          'Accept': 'application/json',
          "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
          "x-rapidapi-key":
              "API_KEY",
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);

      fixture = map['api']['fixtures'];
      homeTeamId = fixture[0]['homeTeam']['team_id'].toString();
      awayTeamId = fixture[0]['awayTeam']['team_id'].toString();
      homeTeamName = fixture[0]['homeTeam']['team_name'];
      awayTeamName = fixture[0]['awayTeam']['team_name'];
      homeTeamLogo = fixture[0]['homeTeam']['logo'];
      awayTeamLogo = fixture[0]['awayTeam']['logo'];
      statusShort = fixture[0]['statusShort'];
      print(statusShort);

      _streamController.add(fixture);
    }
    //print(goalsHomeTeam.toString());
    //print(goalsAwayTeam.toString());
    //print(fixture);
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: pageBody(context),
      );
    } else {
      return StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //print(snapshot.data);
              return Consumer<AppUser>(builder: (_, user, __) {
                if (user != null) predictionBloc.changeAppUserId(user.userId);
                return (user != null)
                    ? Scaffold(
                        body: pageBody(context),
                        appBar: AppBar(
                          automaticallyImplyLeading: false,
                          title: Column(
                            children: [
                              SizedBox(
                                height: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          height: 30.0,
                                          width: 30.0,
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Image.network(homeTeamLogo)),
                                      Text(
                                        snapshot.data[0]['homeTeam']
                                            ['team_name'],
                                        style: TextStyles.body,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        snapshot.data[0]['goalsHomeTeam']
                                                    .toString() ==
                                                'null'
                                            ? ' '
                                            : snapshot.data[0]['goalsHomeTeam']
                                                .toString(),
                                        style: TextStyles.body,
                                      ),
                                      SizedBox(width: 10)
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          height: 30.0,
                                          width: 30.0,
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Image.network(awayTeamLogo)),
                                      Text(
                                        snapshot.data[0]['awayTeam']
                                            ['team_name'],
                                        style: TextStyles.body,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        snapshot.data[0]['goalsAwayTeam']
                                                    .toString() ==
                                                'null'
                                            ? ' '
                                            : snapshot.data[0]['goalsAwayTeam']
                                                .toString(),
                                        style: TextStyles.body,
                                      ),
                                      SizedBox(width: 10)
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          backgroundColor: customTheme.isDarkMode == true
                              ? AppColors.darkblue
                              : Colors.teal,
                          bottom: new TabBar(
                              indicatorColor: Color.fromRGBO(222, 177, 92, 1),
                              labelColor: Color.fromRGBO(222, 177, 92, 1),
                              controller: controller,
                              tabs: <Widget>[
                                new Tab(
                                  icon: new Image.asset(
                                    "assets/whistle.png",
                                    width: 30.0,
                                    height: 30.0,
                                  ),
                                ),
                                new Tab(
                                  icon: new Image.asset(
                                    "assets/lineups.png",
                                    width: 30.0,
                                    height: 30.0,
                                  ),
                                ),
                                new Tab(
                                  icon: new Image.asset(
                                    "assets/vsicon.png",
                                    width: 30.0,
                                    height: 30.0,
                                  ),
                                ),
                                new Tab(icon: Icon(Icons.info)),
                              ]),
                        ),
                      )
                    : Scaffold(
                        body: pageBody(context),
                        appBar: AppBar(
                          automaticallyImplyLeading: false,
                          title: Column(
                            children: [
                              SizedBox(
                                height: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          height: 30.0,
                                          width: 30.0,
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Image.network(homeTeamLogo)),
                                      Text(
                                        snapshot.data[0]['homeTeam']
                                            ['team_name'],
                                        style: TextStyles.body,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        snapshot.data[0]['goalsHomeTeam']
                                                    .toString() ==
                                                'null'
                                            ? ' '
                                            : snapshot.data[0]['goalsHomeTeam']
                                                .toString(),
                                        style: TextStyles.body,
                                      ),
                                      SizedBox(width: 10)
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          height: 30.0,
                                          width: 30.0,
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Image.network(awayTeamLogo)),
                                      Text(
                                        snapshot.data[0]['awayTeam']
                                            ['team_name'],
                                        style: TextStyles.body,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        snapshot.data[0]['goalsAwayTeam']
                                                    .toString() ==
                                                'null'
                                            ? ' '
                                            : snapshot.data[0]['goalsAwayTeam']
                                                .toString(),
                                        style: TextStyles.body,
                                      ),
                                      SizedBox(width: 10)
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          backgroundColor: customTheme.isDarkMode == true
                              ? AppColors.darkblue
                              : Colors.teal,
                          bottom: new TabBar(
                              indicatorColor: Color.fromRGBO(222, 177, 92, 1),
                              labelColor: Color.fromRGBO(222, 177, 92, 1),
                              controller: controller,
                              tabs: <Widget>[
                                new Tab(
                                  icon: new Image.asset(
                                    "assets/whistle.png",
                                    width: 30.0,
                                    height: 30.0,
                                  ),
                                ),
                                new Tab(
                                  icon: new Image.asset(
                                    "assets/lineups.png",
                                    width: 30.0,
                                    height: 30.0,
                                  ),
                                ),
                                new Tab(
                                  icon: new Image.asset(
                                    "assets/vsicon.png",
                                    width: 30.0,
                                    height: 30.0,
                                  ),
                                ),
                                new Tab(icon: Icon(Icons.info)),
                              ]),
                        ),
                      );
              });
            } else {
              //print(snapshot.data);
              return Container(
                  color: customTheme.isDarkMode == true
                      ? AppColors.darkblue
                      : Colors.teal,
                  child: Center(child: Loading()));
            }
          });
    }
  }

  Widget pageBody(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    var predictionBloc = Provider.of<PredictionBloc>(context);
    final appUser = Provider.of<AppUser>(context);

    return Column(
      children: <Widget>[
        Container(
          color:
              customTheme.isDarkMode == true ? AppColors.darkblue : Colors.teal,
          height: 70.0,
          width: 500.0,
          padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              color: customTheme.isDarkMode == true
                  ? AppColors.notshinygold
                  : Colors.grey[100],
              child: Text(
                'Predict',
                style: TextStyle(
                    color: customTheme.isDarkMode == true
                        ? AppColors.darkblue
                        : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                createAlertDialog(context, predictionBloc, appUser);
              }),
        ),
        Expanded(
          child: TabBarView(controller: controller, children: <Widget>[
            new first.Events(
                fixtureId: widget.fixtureId,
                homeTeamName: homeTeamName,
                awayTeamName: awayTeamName,
                homeTeamLogo: homeTeamLogo,
                awayTeamLogo: awayTeamLogo),
            new second.Lineups(
                fixtureId: widget.fixtureId,
                homeTeamName: homeTeamName,
                awayTeamName: awayTeamName,
                homeTeamLogo: homeTeamLogo,
                awayTeamLogo: awayTeamLogo),
            new third.Head2Head(
              homeTeamId: homeTeamId,
              awayTeamId: awayTeamId,
            ),
            new fourth.MatchInfo(
              fixtureId: widget.fixtureId,
            ),
          ]),
        ),
      ],
    );
  }

  createAlertDialog(
      BuildContext context, PredictionBloc predictionBloc, AppUser appUser) {
    var buttonLabel = /*(existingPrediction != null) ? 'Change' :*/ 'Submit';
    var buttonLabel2 = 'Login';
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: customTheme.isDarkMode == true
                ? AppColors.lightblue
                : Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: appUser != null
                ? Container(
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
                                Flexible(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 20.0,
                                        width: 20.0,
                                        child: Image.network(homeTeamLogo),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        homeTeamName,
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(222, 177, 92, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    statusShort != '1H' &&
                                            statusShort != 'HT' &&
                                            statusShort != '2H' &&
                                            statusShort != 'ET' &&
                                            statusShort != 'P' &&
                                            statusShort != 'FT' &&
                                            statusShort != 'AET' &&
                                            statusShort != 'PEN' &&
                                            statusShort != 'BT' &&
                                            statusShort != 'INT' &&
                                            statusShort != 'P' &&
                                            statusShort != 'SUSP' &&
                                            statusShort != 'ABD' &&
                                            statusShort != 'AWD' &&
                                            statusShort != 'WO'
                                        ? Container(
                                            height: 40,
                                            width: 50,
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: _homeTeamController,
                                              onChanged: (value) {
                                                if (value != null) {
                                                  this.homeTeamPrediction =
                                                      value;
                                                } else {
                                                  // this.homeTeamPrediction = existingPrediction.homeTeamPrediction.toString();
                                                }
                                              },
                                              decoration: InputDecoration(
                                                  hintText: " ",
                                                  errorStyle: TextStyles.error),
                                            ))
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
                                Flexible(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 20.0,
                                        width: 20.0,
                                        child: Image.network(awayTeamLogo),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        awayTeamName,
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(222, 177, 92, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    statusShort != '1H' &&
                                            statusShort != 'HT' &&
                                            statusShort != '2H' &&
                                            statusShort != 'ET' &&
                                            statusShort != 'P' &&
                                            statusShort != 'FT' &&
                                            statusShort != 'AET' &&
                                            statusShort != 'PEN' &&
                                            statusShort != 'BT' &&
                                            statusShort != 'INT' &&
                                            statusShort != 'P' &&
                                            statusShort != 'SUSP' &&
                                            statusShort != 'ABD' &&
                                            statusShort != 'AWD' &&
                                            statusShort != 'WO'
                                        ? Container(
                                            height: 40,
                                            width: 50,
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: _awayTeamController,
                                              onChanged: (value) {
                                                if (value != null) {
                                                  this.awayTeamPrediction =
                                                      value;
                                                } else {
                                                  //  this.awayTeamPrediction = existingPrediction.awayTeamPrediction.toString();
                                                }
                                              },
                                              decoration: InputDecoration(
                                                  hintText: " ",
                                                  errorStyle: TextStyles.error),
                                            ))
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
                          statusShort != '1H' &&
                                  statusShort != 'HT' &&
                                  statusShort != '2H' &&
                                  statusShort != 'ET' &&
                                  statusShort != 'P' &&
                                  statusShort != 'FT' &&
                                  statusShort != 'AET' &&
                                  statusShort != 'PEN' &&
                                  statusShort != 'BT' &&
                                  statusShort != 'INT' &&
                                  statusShort != 'P' &&
                                  statusShort != 'SUSP' &&
                                  statusShort != 'ABD' &&
                                  statusShort != 'AWD' &&
                                  statusShort != 'WO'
                              ? SizedBox(
                                  width: 520.0,
                                  child:
                                      /*StreamBuilder<bool>(
                          stream: predictionBloc.isValid,
                          builder: (context, snapshot) {
                            return*/
                                      AppButton(
                                          buttonText: buttonLabel,
                                          buttonType:
                                              /*(snapshot.data == true) ?*/ ButtonType
                                                  .NotShinyGold,
                                          /*: ButtonType.Disabled,*/
                                          onPressed: () {
                                            //var options = SetOptions(merge: true);
                                            /*if(this.homeTeamPrediction == null){
                              this.homeTeamPrediction = existingPrediction.homeTeamPrediction.toString();
                             }

                             if(this.awayTeamPrediction == null){
                              this.awayTeamPrediction = existingPrediction.awayTeamPrediction.toString();
                             }*/

                                            if (homeTeamPrediction == null ||
                                                awayTeamPrediction == null) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please fill all of the fields!",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 2,
                                                  backgroundColor:
                                                      AppColors.notshinygold,
                                                  textColor: AppColors.darkblue,
                                                  fontSize: 16.0);
                                            }

                                            predictionBloc.savePrediction(
                                                homeTeamPrediction,
                                                awayTeamPrediction,
                                                statusShort,
                                                widget.fixtureId);

                                            if (homeTeamPrediction != null &&
                                                awayTeamPrediction != null) {
                                              Fluttertoast.showToast(
                                                  msg: "Done! Good luck",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 2,
                                                  backgroundColor:
                                                      AppColors.notshinygold,
                                                  textColor: AppColors.darkblue,
                                                  fontSize: 16.0);
                                            }

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
                              : statusShort == 'PST'
                                  ? Container(
                                      child: Center(
                                      child: Text(
                                        'Match Postponed',
                                        style: TextStyle(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ))
                                  : statusShort == 'CANC'
                                      ? Container(
                                          child: Center(
                                          child: Text(
                                            'Match Cancelled',
                                            style: TextStyle(
                                                color: Colors.amber,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ))
                                      : Container(
                                          child: Center(
                                          child: Text(
                                            'Prediction time is over!',
                                            style: TextStyle(
                                                color: Colors.amber,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ))
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: 200.0,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 30.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/PNG app.png'))),
                          ),
                          Center(
                              child: Text('Please Log in to predict the score',
                                  style: TextStyles.body)),

                          /*SizedBox(
                        width: 520.0,
                        child: /*StreamBuilder<bool>(
                          stream: predictionBloc.isValid,
                          builder: (context, snapshot) {
                            return*/ AppButton(buttonText: 
                             buttonLabel2,
                             buttonType: 
                             /*(snapshot.data == true) ?*/ ButtonType.NotShinyGold,
                             /*: ButtonType.Disabled,*/
                             onPressed: (){
                             


                             

                              Navigator.pushReplacementNamed(context, '/login');

                             
                             })
                          /*}*/
                       /* )*/
                      )*/
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
