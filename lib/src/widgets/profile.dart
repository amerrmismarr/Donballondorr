import 'package:Donballondor/src/app.dart';
import 'package:Donballondor/src/blocs/auth_bloc.dart';
import 'package:Donballondor/src/blocs/prediction_bloc.dart';
//import 'package:Donballondor/src/models/predictedFixture.dart';
import 'package:Donballondor/src/models/prediction.dart';
import 'package:Donballondor/src/models/user.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/styles/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:Donballondor/src/services/firestore_service.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}


class _ProfileState extends State<Profile> {
  VoidCallback onClicked;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  List<dynamic> fixture;

  CustomTheme customTheme = CustomTheme();

  

  Future getPredictedFixtures(String predictedFixtureId) async {
    final appUser = Provider.of<AppUser>(context,listen: false);
    var predictionBloc = Provider.of<PredictionBloc>(context,listen: false);

    var response = await http.get(
        Uri.parse(
            'https://api-football-v1.p.rapidapi.com/v2/fixtures/id/' +
                predictedFixtureId),
        headers: {
          'Accept': 'application/json',
          "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
          "x-rapidapi-key":
              "9277c6f840mshffcaa155ce6daf9p1f43c7jsnff99eae70a7c",
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);

      fixture = map['api']['fixtures'];

      var options = SetOptions(merge: true);

      _db
          .collection('users')
          .doc(appUser.userId)
          .collection('Predictions')
          .doc(predictedFixtureId)
          .set({
        "homeTeamScore": fixture[0]['goalsHomeTeam'],
        "awayTeamScore": fixture[0]['goalsAwayTeam'],
        "matchStatus": fixture[0]['statusShort']
      }, options);
    }
    //print(goalsHomeTeam.toString());
    //print(goalsAwayTeam.toString());
    //print(fixture);
  }

  

  Future calculatePredictions(){
    var predictions = Provider.of<List<Prediction>>(context,listen: false);
    final appUser = Provider.of<AppUser>(context,listen: false);

    if (predictions != null) {
      //print(predictedFixtures.length);
      //..print(predictions.length);
      predictions.forEach((prediction) {
        getPredictedFixtures(prediction.fixtureId);
        //print(prediction.fixtureId + " " + prediction.awayTeamScore.toString() + " " + prediction.homeTeamScore.toString());
        if (prediction.homeTeamScore != null &&
            prediction.awayTeamScore != null) {
          if (prediction.isCalculated != true &&
              int.parse(prediction.homeTeamPrediction.toString()) ==
                  int.parse(prediction.homeTeamScore.toString()) &&
              int.parse(prediction.awayTeamPrediction.toString()) ==
                  int.parse(prediction.awayTeamScore.toString())) {
            print(prediction.fixtureId +
                " " +
                'Prediction Successful' +
                " " +
                prediction.homeTeamScore.toString() +
                " " +
                prediction.awayTeamScore.toString() +
                " " +
                'score is up by 50' +
                " " +
                appUser.score.toString());
            var options = SetOptions(merge: true);

            _db
                .collection('users')
                .doc(appUser.userId)
                .update({'score': FieldValue.increment(50)});

            _db
                .collection('users')
                .doc(appUser.userId)
                .collection('Predictions')
                .doc(prediction.fixtureId)
                .set({'isCalculated': true}, options);
          } else if (prediction.isCalculated != true &&
              int.parse(prediction.homeTeamScore.toString()) >
                  int.parse(prediction.awayTeamScore.toString()) &&
              int.parse(prediction.homeTeamPrediction.toString()) >
                  int.parse(prediction.awayTeamPrediction.toString())) {
            print(prediction.fixtureId +
                " " +
                'Predicted home team win' +
                " " +
                prediction.homeTeamScore.toString() +
                " " +
                prediction.awayTeamScore.toString() +
                " " +
                'score is up by 25');

            var options = SetOptions(merge: true);

            _db
                .collection('users')
                .doc(appUser.userId)
                .update({'score': FieldValue.increment(25)});
            _db
                .collection('users')
                .doc(appUser.userId)
                .collection('Predictions')
                .doc(prediction.fixtureId)
                .set({'isCalculated': true}, options);
          } else if (prediction.isCalculated != true &&
              int.parse(prediction.homeTeamScore.toString()) <
                  int.parse(prediction.awayTeamScore.toString()) &&
              int.parse(prediction.homeTeamPrediction.toString()) <
                  int.parse(prediction.awayTeamPrediction.toString())) {
            print(prediction.fixtureId +
                " " +
                'Predicted away team win' +
                " " +
                prediction.homeTeamScore.toString() +
                " " +
                prediction.awayTeamScore.toString() +
                " " +
                'score is up by 25');
            var options = SetOptions(merge: true);

            _db
                .collection('users')
                .doc(appUser.userId)
                .update({'score': FieldValue.increment(25)});
            _db
                .collection('users')
                .doc(appUser.userId)
                .collection('Predictions')
                .doc(prediction.fixtureId)
                .set({'isCalculated': true}, options);
          } else if (prediction.isCalculated != true &&
              int.parse(prediction.homeTeamScore.toString()) ==
                  int.parse(prediction.awayTeamScore.toString()) &&
              int.parse(prediction.homeTeamPrediction.toString()) ==
                  int.parse(prediction.awayTeamPrediction.toString())) {
            print(prediction.fixtureId +
                " " +
                'Predicted tie' +
                " " +
                prediction.homeTeamScore.toString() +
                " " +
                prediction.awayTeamScore.toString() +
                " " +
                'score is up by 25');
            var options = SetOptions(merge: true);

            _db
                .collection('users')
                .doc(appUser.userId)
                .update({'score': FieldValue.increment(25)});
            _db
                .collection('users')
                .doc(appUser.userId)
                .collection('Predictions')
                .doc(prediction.fixtureId)
                .set({'isCalculated': true}, options);
          } else {
            //print(prediction.fixtureId + " " + 'score is not changed');
            var options = SetOptions(merge: true);
            _db
                .collection('users')
                .doc(appUser.userId)
                .collection('Predictions')
                .doc(prediction.fixtureId)
                .set({'isCalculated': true}, options);
          }
        }
      });

      //print(predictionsPredictedFixturesStream().toString());

    }

  }


  @override
  Widget build(BuildContext context) {
    final db = FireStoreService();
    final appUser = Provider.of<AppUser>(context);
    //var predictions = Provider.of<List<Prediction>>(context,listen: false);
    //p/rint(predictions.length);
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: pageBody(context),
      );
    } else {
      return  Scaffold(
            
            body: pageBody(context)
          );
        
      
    }
  }

  Widget pageBody(BuildContext context) {
    var predictions = Provider.of<List<Prediction>>(context);
    var authBloc = Provider.of<AuthBloc>(context);
    var appUser = Provider.of<AppUser>(context);
    //var predictions = Provider.of<List<Prediction>>(context);
    //var predictedFixtures = Provider.of<List<PredictedFixture>>(context);
    FirebaseFirestore _db = FirebaseFirestore.instance;
    
    return StreamBuilder(
      stream: _db.collection('users').doc(appUser.userId).snapshots(),
      

      builder: (context, snapshot){
        
        if(snapshot.hasData){
        authBloc.changeImageUrl(snapshot.data['imagePath']);
        //AppUser userr = snapshot.data;
        print(snapshot.data);
        return Container(
          
      child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(height: 30),
                Center(child:
                 Stack(
                   children: [
                     StreamBuilder<String>(
                       stream: authBloc.imageURL,
                       builder: (context, snapshot) {
                         if(snapshot.data != null){
                           
                           //print(snapshot.data);
                           return ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: Ink.image(
                            image: NetworkImage(snapshot.data),
                            fit: BoxFit.cover,
                            width: 128,
                            height: 128,
                            child: InkWell(onTap: onClicked ,),
                            ),
                          ),
                                     );

                         }
                         return ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: Ink.image(
                            image: NetworkImage(appUser.imagePath),
                            fit: BoxFit.cover,
                            width: 128,
                            height: 128,
                            child: InkWell(onTap: onClicked ,),
                            ),
                          ),
                                     );
                       }
                     ),
                Positioned(
                  bottom: 0,
                  right: 4,
                    child: ClipOval(
                                          child: Container(
                        color: AppColors.darkblue,
                        padding: EdgeInsets.all(4),
                        child: GestureDetector(
                          onTap: (){
                            authBloc.pickImage(appUser.userId);
                          },
                          child: ClipOval(
                              child: Container(
                              padding: EdgeInsets.all(8),
                              color: AppColors.notshinygold,
                              child: Icon(
                              Icons.edit,
                              size: 20,
                              color: AppColors.darkblue,
                                          ),
                            ),
                          ),
                        ),
                      ),
                    ),
                )
                   ], 
                 ),
                  ),
                  SizedBox(height: 20,),
            Center(
              child:Text(snapshot.data['email'].toString(), style: TextStyles.subTitle)
            ),
            SizedBox(height: 20),
            Center(
              child:Text(predictions == null? "Predictions: 0" : "Predictions: " + predictions.length.toString(), style: TextStyles.navTitle)
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              onPrimary: AppColors.darkblue,
              primary: AppColors.notshinygold,
              shape: CircleBorder(),
              fixedSize: Size.fromRadius(60),
              elevation: 20.0,
              shadowColor: AppColors.notshinygold
              
              ),
              child: Text('Refresh Score'),
              onPressed: () {
                calculatePredictions();
              },

            ),
            SizedBox(height:20),
            Center(
              child:Text(snapshot.data['score'].toString(), style: TextStyles.subTitle)
            ),


            IconButton(
              icon: Icon(Icons.logout),
              color: AppColors.notshinygold,
              onPressed:(){
              authBloc.logout();
              Navigator.pushReplacementNamed(context, '/landing');
            } , )

              ],


      ));
      
        } else {
          return (Container(color: customTheme.isDarkMode == true ? 
                                              AppColors.darkblue : Colors.teal,
          child: Center(child: Loading())));
        }
    
      });
      

    
    
    
  }
}

