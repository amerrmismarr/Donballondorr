import 'package:Donballondor/src/blocs/prediction_bloc.dart';
import 'package:Donballondor/src/models/favorites.dart';
import 'package:Donballondor/src/models/favoritesPrefs.dart';
import 'package:Donballondor/src/models/prediction.dart';
import 'package:Donballondor/src/models/user.dart';
import 'package:Donballondor/src/screens/statistics.dart';
import 'package:Donballondor/src/services/firestore_service.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LiveScoreList extends StatefulWidget {
  final List<dynamic> elements;

  LiveScoreList({@required this.elements});

  @override
  _LiveScoreListState createState() => _LiveScoreListState();
}



class _LiveScoreListState extends State<LiveScoreList> {
  List<dynamic> fixture;
  Map<String,dynamic> mapData;
  Set<String> savedIds = Set<String>();
  //List<dynamic> predictedFixtures;
  FireStoreService db = FireStoreService();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //PredictedFixture predictedFixture;
  

  int goalsHomeTeam;
  int goalsAwayTeam;
  
  @override
  void initState() {
    final appUser = Provider.of<AppUser>(context, listen: false);
    /*final favouritesRef = FirebaseFirestore.instance.collection('users')
    .doc(appUser.userId).collection('FavoriteIdList').doc(appUser.userId);*/
    

    super.initState();
    //favouritesRef.get().then((value) => mapData = value.data());
   // print(mapData);
    //print(appUser.userId);
  }



  Future getPredictedFixtures(String predictedFixtureId) async {

    final appUser = Provider.of<AppUser>(context);
    var predictionBloc = Provider.of<PredictionBloc>(context);

    var response = await http.get(Uri.encodeFull('https://api-football-v1.p.rapidapi.com/v2/fixtures/id/' + predictedFixtureId), headers: {
      'Accept': 'application/json',
      "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
      "x-rapidapi-key": "9277c6f840mshffcaa155ce6daf9p1f43c7jsnff99eae70a7c",
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      
      fixture = map['api']['fixtures'];
      //db.addPredictedFixture(predictedFixture, appUser.userId);
      //.changeHomeTeamScore(fixture[0]['goalsHomeTeam'].toString());
      //predictionBloc.changeAwayTeamScore(fixture[0]['goalsAwayTeam'].toString());
     /* predictedFixture = PredictedFixture(
     //homeTeamPrediction: int.parse(_homeTeamPrediction.value),
     //awayTeamPrediction: int.parse(_awayTeamPrediction.value),
     homeTeamScore: fixture[0]['goalsHomeTeam'],
     awayTeamScore: fixture[0]['goalsAwayTeam'],
     matchStatus: fixture[0]['statusShort'],
     fixtureId: predictedFixtureId,
   );*/
     // db.addPredictedFixture(predictedFixture, appUser.userId);
      var options = SetOptions(merge: true);

      _db.collection('users')
        .doc(appUser.userId)
        .collection('Predictions')
        .doc(predictedFixtureId)
        .set({
          "homeTeamScore" : fixture[0]['goalsHomeTeam'],
          "awayTeamScore" : fixture[0]['goalsAwayTeam'],
          "matchStatus": fixture[0]['statusShort']

        }, options);
      
      
      
    
    }
      //print(goalsHomeTeam.toString());
      //print(goalsAwayTeam.toString());
      //print(fixture);
      
    }

    

    
  

  
  @override
  Widget build(BuildContext context) {
    var predictions = Provider.of<List<Prediction>>(context);
    var favorites = Provider.of<List<Favorite>>(context);
    //var predictedFixtures = Provider.of<List<PredictedFixture>>(context);
    var predictionBloc = Provider.of<PredictionBloc>(context);
    final appUser = Provider.of<AppUser>(context);
    
    
    
    
    //print(appUser.userId);
    
    
    
    /*Stream<List<PredictionsAndPredictedFixtures>> predictionsPredictedFixturesStream(){
      return Rx.combineLatest2(predictionBloc.predictionByUserId(appUser.userId), 
      predictionBloc.predictedFixturesByUserId(appUser.userId), (List<Prediction> predictionss
      , List<PredictedFixture> predictedFixturess) {
        return predictionss.map((predictionn) {
          final predictionPredictedFixture = predictedFixturess?.firstWhere((predictedFixturee) => 
          predictedFixturee.fixtureId == predictionn.fixtureId,
          orElse: () => null);

        return PredictionsAndPredictedFixtures(prediction: predictionn);
        }).toList();
      });
    }*/

   
    
    if(predictions != null){
    //print(predictedFixtures.length);
    //..print(predictions.length);
    predictions.forEach((prediction) {
      getPredictedFixtures(prediction.fixtureId);
      //print(prediction.fixtureId + " " + prediction.awayTeamScore.toString() + " " + prediction.homeTeamScore.toString());
      if(prediction.homeTeamScore != null && prediction.awayTeamScore != null){
      if(prediction.isCalculated != true && int.parse(prediction.homeTeamPrediction.toString()) == int.parse(prediction.homeTeamScore.toString()) &&
      int.parse(prediction.awayTeamPrediction.toString()) == int.parse(prediction.awayTeamScore.toString())){
        print(prediction.fixtureId + " " + 'Prediction Successful' +" " + prediction.homeTeamScore.toString() +
        " " + prediction.awayTeamScore.toString() + " " + 'score is up by 50' + " " + appUser.score.toString());
      var options = SetOptions(merge: true);

      _db.collection('users')
      .doc(appUser.userId)
      .update({
        'score' :  FieldValue.increment(50)
      });


      _db.collection('users')
        .doc(appUser.userId)
        .collection('Predictions')
        .doc(prediction.fixtureId)
        .set({
          'isCalculated' : true

        }, options);
        
      } else if (prediction.isCalculated != true && int.parse(prediction.homeTeamScore.toString()) > int.parse(prediction.awayTeamScore.toString()) &&
      int.parse(prediction.homeTeamPrediction.toString()) > int.parse(prediction.awayTeamPrediction.toString())){
        print(prediction.fixtureId + " " + 'Predicted home team win' +" " + prediction.homeTeamScore.toString() +
        " " + prediction.awayTeamScore.toString() + " " + 'score is up by 25');

        var options = SetOptions(merge: true);

      _db.collection('users')
      .doc(appUser.userId)
      .update({
        'score' :  FieldValue.increment(25)
      });
      _db.collection('users')
        .doc(appUser.userId)
        .collection('Predictions')
        .doc(prediction.fixtureId)
        .set({
          'isCalculated' : true

        }, options);
      } else if(prediction.isCalculated != true && int.parse(prediction.homeTeamScore.toString()) < int.parse(prediction.awayTeamScore.toString()) &&
      int.parse(prediction.homeTeamPrediction.toString()) < int.parse(prediction.awayTeamPrediction.toString())){
        print(prediction.fixtureId + " " + 'Predicted away team win' +" " + prediction.homeTeamScore.toString() +
        " " + prediction.awayTeamScore.toString() + " " + 'score is up by 25');
        var options = SetOptions(merge: true);

      _db.collection('users')
      .doc(appUser.userId)
      .update({
        'score' :  FieldValue.increment(25)
      });
      _db.collection('users')
        .doc(appUser.userId)
        .collection('Predictions')
        .doc(prediction.fixtureId)
        .set({
          'isCalculated' : true

        }, options);
      } else if(prediction.isCalculated != true && int.parse(prediction.homeTeamScore.toString()) == int.parse(prediction.awayTeamScore.toString()) &&
      int.parse(prediction.homeTeamPrediction.toString()) == int.parse(prediction.awayTeamPrediction.toString()) ) {
        print(prediction.fixtureId + " " + 'Predicted tie' +" " + prediction.homeTeamScore.toString() +
        " " + prediction.awayTeamScore.toString() + " " + 'score is up by 25');
        var options = SetOptions(merge: true);

      _db.collection('users')
      .doc(appUser.userId)
      .update({
        'score' :  FieldValue.increment(25)
      });
      _db.collection('users')
        .doc(appUser.userId)
        .collection('Predictions')
        .doc(prediction.fixtureId)
        .set({
          'isCalculated' : true

        }, options);
      } else {
        //print(prediction.fixtureId + " " + 'score is not changed');
        var options = SetOptions(merge: true);
        _db.collection('users')
        .doc(appUser.userId)
        .collection('Predictions')
        .doc(prediction.fixtureId)
        .set({
          'isCalculated' : true

        }, options);
        
      }
      }
     
    });
    

    //print(predictionsPredictedFixturesStream().toString());
    
    


    }
    //print(predictions);
    return  Container(
        child: Expanded(
            child: SizedBox(
      height: 450.0,
      child: GroupedListView<dynamic, String>(
              elements: widget.elements,
              useStickyGroupSeparators: true,
              stickyHeaderBackgroundColor: Color.fromRGBO(13, 18, 38, 1),
              groupBy: (element) => element['popularity'].toString(),
              groupHeaderBuilder: (element) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: element['popularity'] != '600' ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                         element['league']['country'] == 'Germany'? 
                                            Image(image: AssetImage('assets/germany.png'), width: 20.0, height: 20.0,) : 
                                            element['league']['country'] == 'Spain'? 
                                            Image(image: AssetImage('assets/spain.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'England' ? 
                                            Image(image: AssetImage('assets/uk.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Italy' ? 
                                            Image(image: AssetImage('assets/italy.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'France' ? 
                                            Image(image: AssetImage('assets/france.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Netherlands' ? 
                                            Image(image: AssetImage('assets/netherlands.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['name'] == 'UEFA Champions League' ? 
                                            Image(image: AssetImage('assets/championsLeague.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Brazil' ? 
                                            Image(image: AssetImage('assets/brazil.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Argentina' ? 
                                            Image(image: AssetImage('assets/argentina.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Portugal' ? 
                                            Image(image: AssetImage('assets/portugal.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Albania' ? 
                                            Image(image: AssetImage('assets/albania.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Algeria' ? 
                                            Image(image: AssetImage('assets/algeria.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Andorra' ? 
                                            Image(image: AssetImage('assets/andorra.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Angola' ? 
                                            Image(image: AssetImage('assets/angola.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Armenia' ? 
                                            Image(image: AssetImage('assets/armenia.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Aruba' ? 
                                            Image(image: AssetImage('assets/aruba.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Australia' ? 
                                            Image(image: AssetImage('assets/australia.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Austria' ? 
                                            Image(image: AssetImage('assets/austria.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Azerbaidjan' ? 
                                            Image(image: AssetImage('assets/azerbaijan.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Bahrain' ? 
                                            Image(image: AssetImage('assets/bahrain.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Bangladesh' ? 
                                            Image(image: AssetImage('assets/bangladesh.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Barbados' ? 
                                            Image(image: AssetImage('assets/barbados.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Belarus' ? 
                                            Image(image: AssetImage('assets/belarus.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Belgium' ? 
                                            Image(image: AssetImage('assets/belgium.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Belize' ? 
                                            Image(image: AssetImage('assets/belize.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Benin' ? 
                                            Image(image: AssetImage('assets/benin.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Bermuda' ? 
                                            Image(image: AssetImage('assets/bermuda.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Bhutan' ? 
                                            Image(image: AssetImage('assets/bhutan.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Bolivia' ? 
                                            Image(image: AssetImage('assets/bolivia.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Bosnia' ? 
                                            Image(image: AssetImage('assets/bosnia.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Botswana' ? 
                                            Image(image: AssetImage('assets/botswana.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Bulgaria' ? 
                                            Image(image: AssetImage('assets/bulgaria.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Burkina-Faso' ? 
                                            Image(image: AssetImage('assets/burkina-faso.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Burundi' ? 
                                            Image(image: AssetImage('assets/burundi.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Cambodia' ? 
                                            Image(image: AssetImage('assets/cambodia.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Cameroon' ? 
                                            Image(image: AssetImage('assets/cameroon.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Canada' ? 
                                            Image(image: AssetImage('assets/canada.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Chile' ? 
                                            Image(image: AssetImage('assets/chile.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'China' ? 
                                            Image(image: AssetImage('assets/china.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Chinese-Taipei' ? 
                                            Image(image: AssetImage('assets/taiwan.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Colombia' ? 
                                            Image(image: AssetImage('assets/colombia.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Congo-DR' ? 
                                            Image(image: AssetImage('assets/congo-dr.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Costa-Rica' ? 
                                            Image(image: AssetImage('assets/costa-rica.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Croatia' ? 
                                            Image(image: AssetImage('assets/croatia.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Curacao' ? 
                                            Image(image: AssetImage('assets/curacao.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Cyprus' ? 
                                            Image(image: AssetImage('assets/cyprus.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Czech-Republic' ? 
                                            Image(image: AssetImage('assets/czech-republic.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Denmark' ? 
                                            Image(image: AssetImage('assets/denmark.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Ecuador' ? 
                                            Image(image: AssetImage('assets/ecuador.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Egypt' ? 
                                            Image(image: AssetImage('assets/egypt.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'El-Salvador' ? 
                                            Image(image: AssetImage('assets/el-salvador.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Estonia' ? 
                                            Image(image: AssetImage('assets/estonia.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Ethiopia' ? 
                                            Image(image: AssetImage('assets/ethiopia.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Faroe-Islands' ? 
                                            Image(image: AssetImage('assets/faroe-islands.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Fiji' ? 
                                            Image(image: AssetImage('assets/fiji.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Finland' ? 
                                            Image(image: AssetImage('assets/finland.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Georgia' ? 
                                            Image(image: AssetImage('assets/georgia.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Ghana' ? 
                                            Image(image: AssetImage('assets/ghana.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Greece' ? 
                                            Image(image: AssetImage('assets/greece.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Guadeloupe' ? 
                                            Image(image: AssetImage('assets/guadeloupe.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Guatemala' ? 
                                            Image(image: AssetImage('assets/Guatemala.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Guinea' ? 
                                            Image(image: AssetImage('assets/guinea.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Haiti' ? 
                                            Image(image: AssetImage('assets/haiti.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Honduras' ? 
                                            Image(image: AssetImage('assets/honduras.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Hong-Kong' ? 
                                            Image(image: AssetImage('assets/hong-kong.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Hungary' ? 
                                            Image(image: AssetImage('assets/hungary.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Iceland' ? 
                                            Image(image: AssetImage('assets/iceland.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'India' ? 
                                            Image(image: AssetImage('assets/india.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Indonesia' ? 
                                            Image(image: AssetImage('assets/indonesia.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Iran' ? 
                                            Image(image: AssetImage('assets/iran.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Ireland' ? 
                                            Image(image: AssetImage('assets/irland.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Israel' ? 
                                            Image(image: AssetImage('assets/israel.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Ivory-Coast' ? 
                                            Image(image: AssetImage('assets/ivory-coast.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Jamaica' ? 
                                            Image(image: AssetImage('assets/jamaica.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Japan' ? 
                                            Image(image: AssetImage('assets/japan.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Jordan' ? 
                                            Image(image: AssetImage('assets/jordan.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Kazakhstan' ? 
                                            Image(image: AssetImage('assets/kazakhstan.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Kenya' ? 
                                            Image(image: AssetImage('assets/kenya.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Kosovo' ? 
                                            Image(image: AssetImage('assets/kosovo.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Kuwait' ? 
                                            Image(image: AssetImage('assets/kuwait.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Kyrgyzstan' ? 
                                            Image(image: AssetImage('assets/kyrgyzstan.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Latvia' ? 
                                            Image(image: AssetImage('assets/latvia.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Lebanon' ? 
                                            Image(image: AssetImage('assets/lebanon.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Lithuania' ? 
                                            Image(image: AssetImage('assets/lithuania.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Luxembourg' ? 
                                            Image(image: AssetImage('assets/luxembourg.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Macedonia' ? 
                                            Image(image: AssetImage('assets/macedonia.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Malawi' ? 
                                            Image(image: AssetImage('assets/malawi.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Malaysia' ? 
                                            Image(image: AssetImage('assets/malaysia.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Mali' ? 
                                            Image(image: AssetImage('assets/mali.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Malta' ? 
                                            Image(image: AssetImage('assets/malta.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Mexico' ? 
                                            Image(image: AssetImage('assets/mexico.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Moldova' ? 
                                            Image(image: AssetImage('assets/moldova.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Montenegro' ? 
                                            Image(image: AssetImage('assets/montenegro.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Morocco' ? 
                                            Image(image: AssetImage('assets/morocco.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Myanmar' ? 
                                            Image(image: AssetImage('assets/myanmar.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Nepal' ? 
                                            Image(image: AssetImage('assets/nepal.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'New-Zealand' ? 
                                            Image(image: AssetImage('assets/new-zealand.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Nicaragua' ? 
                                            Image(image: AssetImage('assets/nicaragua.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Northern-Ireland' ? 
                                            Image(image: AssetImage('assets/northern-ireland.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Nigeria' ? 
                                            Image(image: AssetImage('assets/nigeria.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Norway' ? 
                                            Image(image: AssetImage('assets/norway.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Oman' ? 
                                            Image(image: AssetImage('assets/oman.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Palestine' ? 
                                            Image(image: AssetImage('assets/palestine.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Panama' ? 
                                            Image(image: AssetImage('assets/panama.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Paraguay' ? 
                                            Image(image: AssetImage('assets/paraguay.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Peru' ? 
                                            Image(image: AssetImage('assets/peru.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Poland' ? 
                                            Image(image: AssetImage('assets/poland.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Qatar' ? 
                                            Image(image: AssetImage('assets/qatar.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Romania' ? 
                                            Image(image: AssetImage('assets/romania.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Russia' ? 
                                            Image(image: AssetImage('assets/russia.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Rwanda' ? 
                                            Image(image: AssetImage('assets/rwanda.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'San-Marino' ? 
                                            Image(image: AssetImage('assets/san-marino.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Saudi-Arabia' ? 
                                            Image(image: AssetImage('assets/saudi-arabia.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Scotland' ? 
                                            Image(image: AssetImage('assets/scotland.png'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Senegal' ? 
                                            Image(image: AssetImage('assets/senegal.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Serbia' ? 
                                            Image(image: AssetImage('assets/serbia.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Singapore' ? 
                                            Image(image: AssetImage('assets/singapore.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Slovakia' ? 
                                            Image(image: AssetImage('assets/slovakia.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'Slovenia' ? 
                                            Image(image: AssetImage('assets/slovenia.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'South-Africa' ? 
                                            Image(image: AssetImage('assets/south-africa.jpg'), width: 20.0, height: 20.0,) :
                                            element['league']['country'] == 'South-Korea' ? 
                                            Image(image: AssetImage('assets/south-korea.jpg'), width: 20.0, height: 20.0,) :
                                            SizedBox(width: 10.0,),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          element['league']['name'],
                          style: TextStyle(
                              color: Color.fromRGBO(222, 177, 92, 1),
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ) : Container(),
                  ),
                
              indexedItemBuilder: (context, element, index) {

                if(favorites != null){
                  favorites.forEach((favorite) {
                  if(favorite.fixtureId.toString() == element['fixture_id'].toString()){
                    
                      element['isFavorite'] = true;
                   
                  }
                  });
                }


                if(predictions != null) {
                  

                predictions.forEach((prediction) {
                  //getPredictedFixtures(prediction.fixtureId);
                  

                  if(prediction.fixtureId.toString() == element['fixture_id'].toString()){
                    //print(prediction);
                    
                    element['homeTeamPrediction'] = prediction.homeTeamPrediction.toString();
                    element['awayTeamPrediction'] = prediction.awayTeamPrediction.toString();

                    /*predictedFixture = PredictedFixture(
                    homeTeamScore: element['goalsHomeTeam'],
                    awayTeamScore: element['goalsAwayTeam'],
                    matchStatus: element['statusShort'],
                    fixtureId: prediction.fixtureId,
                  );*/
                  } 
                 });
                }
                

                return element['popularity'] != '600'?  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/statistics/${element['fixture_id'].toString()}');
                      
                      /*Navigator.push(context, new MaterialPageRoute(builder: 
                                      (context)=> Statistics(homeTeamId : element['homeTeam']['team_id'].toString(),
                                      awayTeamId: element['awayTeam']['team_id'].toString(),
                                      fixtureId : element['fixture_id'].toString(),
                                      homeTeamName: element['homeTeam']['team_name']
                                      , awayTeamName: element['awayTeam']['team_name'],
                                      homeTeamLogo: element['homeTeam']['logo'].toString(),
                                      awayTeamLogo: element['awayTeam']['logo'].toString(),
                                      goalsHomeTeam: element['goalsHomeTeam'].toString(),
                                      goalsAwayTeam: element['goalsAwayTeam'].toString(),
                                      homeTeamPredictionn: element['homeTeamPrediction'].toString(),
                                      awayTeamPredictionn:element['awayTeamPrediction'].toString(),
                                      statusShort : element['statusShort'],
                                      )),);*/
                                      
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        borderOnForeground: true,
                        shadowColor: Color.fromRGBO(224, 176, 92, 1),
                        margin: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 0.0),
                        color: Color.fromRGBO(41, 48, 67, 1),
                        child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Text(element['statusShort'],style: TextStyles.navTitle,),
                                SizedBox(width: 20,),
                                Flexible(
                                                                  child: Row(
                                    children: [
                                      Flexible(
                                          child: Column(
                                          children: <Widget>[
                                            
                                          Container(
                                          height: 20.0,
                                          width: 20.0,
                                          child: element['homeTeam']['logo'] == 'https://media.api-sports.io/football/teams/15289.png'
                                          ? Image.network('https://p7.hiclipart.com/preview/681/999/718/american-football-golden-football.jpg') 
                                          : Image.network(element['homeTeam']['logo']),        
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                          height: 20.0,
                                          width: 20.0,
                                          child: element['awayTeam']['logo'] == 'https://media.api-sports.io/football/teams/15289.png'
                                          ? Image.network('https://p7.hiclipart.com/preview/681/999/718/american-football-golden-football.jpg') 
                                          : Image.network(element['awayTeam']['logo']),                      
                                          ),
                                          ],
                                          ),
                                      ),
                                      SizedBox(width: 10),
                                      Flexible(
                                      flex: 2,
                                    child: Column(
                                      children: [
                                      
                                      Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                      element['homeTeam']['team_name'] ==
                                                              'null'
                                                          ? ' '
                                                          : element['homeTeam']['team_name'],
                                                      style: TextStyle(
                                                        color:
                                                            Color.fromRGBO(222, 177, 92, 1),
                                                        fontSize: 12.0
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                        ),
                                      ),
                                                SizedBox(height: 10,),
                                                Container(
                                                  child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                      element['awayTeam']['team_name'] ==
                                                              'null'
                                                          ? ' '
                                                          : element['awayTeam']['team_name'],
                                                          
                                                      style: TextStyle(
                                                        
                                                        color:
                                                            Color.fromRGBO(222, 177, 92, 1),
                                                        fontSize: 12.0,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                    ],),),
                                    ],
                                  ),
                                ),
                                
                                    
                                    Flexible(
                                                                          child: Row(
                                        children: [
                                          Flexible(
                                          flex: 2,
                                          child: Column(
                                            children: [
                                            Container(
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                                                              child: Text(
                                                            element['goalsHomeTeam'].toString() ==
                                                                    'null'
                                                                ? ' '
                                                                : element['goalsHomeTeam']
                                                                    .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  Color.fromRGBO(222, 177, 92, 1),
                                                              fontSize: 12.0
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                              ),
                                            ),
                                                      SizedBox(height: 10,),
                                                      Container(
                                                        child: Align(
                                                            alignment: Alignment.centerRight,                                                     child: Text(
                                                            element['goalsAwayTeam'].toString() ==
                                                                    'null'
                                                                ? ' '
                                                                : element['goalsAwayTeam']
                                                                    .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  Color.fromRGBO(222, 177, 92, 1),
                                                              fontSize: 12.0
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),

                                            ],),
                                          ),
                                          SizedBox(width: 10),
                                          Flexible(
                                    child: Column(
                                      children: [
                                        Text(element['homeTeamPrediction'], style: TextStyle(color: Colors.grey, fontSize: 10.0),
                                                ),
                                        SizedBox(height: 10,),
                                        Text(element['awayTeamPrediction'],style: TextStyle(color: Colors.grey, fontSize: 10.0),
                                                ),
                                      ],),
                                    ),
                                    
                                        ],
                                      ),
                                    ),
                                Flexible(
                                                                  child: Container(child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(element['statusShort'],style: TextStyles.navTitle,))),
                                ),
                                Consumer<AppUser>(
                                  
                                  builder: (_, user,__) {
                                   bool isSaved = savedIds.contains(element['fixture_id'].toString());
                                   print(savedIds.toString());
                                     
                                    return 
                                     IconButton(icon: 
                                     
                                     Icon(
                                      /*mapData != null && mapData.containsKey(element['fixture_id'].toString())*/
                                      element['isFavorite'] == true ?
                                      Icons.star : Icons.star_border, color: AppColors.notshinygold,),
                                     onPressed: (){
                                      
                                        //print(appUser.userId);
                                        
                                       
                                       // if(mapData != null && mapData.containsKey(element['fixture_id'])){
                                       //   _db.collection('users').doc(user.userId)
                                       //   .collection('Favorites').doc(element['fixture_id'].toString())
                                       //   .update({element['fixture_id'].toString(): FieldValue.delete});
                                       // }  else {
                                       setState(() {
                                         if( element['isFavorite'] == true){
                                            print('favorite removed from favorites');
                                         } else {
                                            predictionBloc.saveFavorite(
                                            element['homeTeam']['team_name'], 
                                            element['awayTeam']['team_name'],
                                            element['statusShort'],
                                            element['fixture_id'].toString(), 
                                            element['homeTeamPrediction'], 
                                            element['awayTeamPrediction'], 
                                            element['goalsHomeTeam'].toString(), 
                                            element['goalsAwayTeam'].toString(), 
                                            true,
                                            user.userId);

                                         }

                                       });
                                       
                                       // }
                                       
                                       
                                     });
                                     
                                  }
                                ),
                              ],
                            )))): Container();
                            
              })
        
    )));
        
    
     
  }
}
