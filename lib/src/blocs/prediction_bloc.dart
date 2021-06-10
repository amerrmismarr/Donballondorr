import 'dart:async';

import 'package:Donballondor/src/models/favorites.dart';
import 'package:Donballondor/src/models/favorites2.dart';
import 'package:Donballondor/src/models/prediction.dart';
import 'package:Donballondor/src/services/firestore_service.dart';
import 'package:rxdart/rxdart.dart';

class PredictionBloc {


 final _homeTeamPrediction = BehaviorSubject<String>();
 final _awayTeamPrediction = BehaviorSubject<String>();
 final _homeTeamScore = BehaviorSubject<String>();
 final _awayTeamScore = BehaviorSubject<String>();
 final _matchStatus = BehaviorSubject<String>();
 final _fixtureId = BehaviorSubject<String>();
 final _appUserId = BehaviorSubject<String>();
 final _predictionSaved = PublishSubject<bool>();
 

 final db = FireStoreService();

 Stream<int> get homeTeamPrediction => _homeTeamPrediction.stream.transform(validateHomeTeamPrediction);
 Stream<int> get awayTeamPrediction => _awayTeamPrediction.stream.transform(validateAwayTeamPrediction);
 Stream<int> get homeTeamScore => _homeTeamScore.stream.transform(validateHomeTeamScore);
 Stream<int> get awayTeamScore => _awayTeamScore.stream.transform(validateAwayTeamScore);
 Stream<String> get fixtureId => _fixtureId.stream;
 Stream<String> get matchStatus => _matchStatus.stream;
 Stream<bool> get isValid => CombineLatestStream.combine2(homeTeamPrediction, awayTeamPrediction, (a, b) => true);
 Stream<List<Prediction>> predictionByUserId(String userId) => db.fetchPredictionsByUserId(userId);
 //Stream<List<PredictedFixture>> predictedFixturesByUserId(String userId) => db.fetchPredictedFixturesByUserId(userId);
 Stream<bool> get predictionSaved => _predictionSaved.stream;

 Function(String) get changeHomeTeamPrediction => _homeTeamPrediction.sink.add;
 Function(String) get changeAwayTeamPrediction => _awayTeamPrediction.sink.add;
 Function(String) get changeHomeTeamScore => _homeTeamScore.sink.add;
 Function(String) get changeAwayTeamScore => _awayTeamScore.sink.add;
 Function(String) get changeMatchStatus => _matchStatus.sink.add;
 Function(String) get changeAppUserId {
   print(_appUserId.value);
   return _appUserId.sink.add;
   
 } 
 Function(String) get changeFixtureId => _fixtureId.sink.add;


 dispose() {
    _homeTeamPrediction.close();
    _awayTeamPrediction.close();
    _homeTeamScore.close();
    _awayTeamScore.close();
    _matchStatus.close();
    _fixtureId.close();
    _appUserId.close();
  }





 final validateHomeTeamPrediction = StreamTransformer<String, int>.fromHandlers(
      handleData: (homeTeamPrediction, sink) {
    try {
      sink.add(int.parse(homeTeamPrediction));
    } catch (error){
      sink.addError('Must be a numner');
    }
  });

  final validateFixtureId = StreamTransformer<String, int>.fromHandlers(
      handleData: (fixtureId, sink) {
    try {
      sink.add(int.parse(fixtureId));
    } catch (error){
      sink.addError('Must be a numner');
    }
  });

  final validateAwayTeamPrediction = StreamTransformer<String, int>.fromHandlers(
      handleData: (awayTeamPrediction, sink) {
    try {
      sink.add(int.parse(awayTeamPrediction));
    } catch (error){
      sink.addError('Must be a numner');
    }
  });

  final validateHomeTeamScore = StreamTransformer<String, int>.fromHandlers(
      handleData: (homeTeamScore, sink) {
    try {
      sink.add(int.parse(homeTeamScore));
    } catch (error){
      sink.addError('Must be a numner');
    }
  });

  final validateAwayTeamScore = StreamTransformer<String, int>.fromHandlers(
      handleData: (awayTeamScore, sink) {
    try {
      sink.add(int.parse(awayTeamScore));
    } catch (error){
      sink.addError('Must be a numner');
    }
  });

 
 Future<void> savePrediction (String homeTeamPrediction, String awayTeamPrediction,
 String matchStatus, String fixtureId) async {

   

   var prediction = Prediction(
     homeTeamPrediction: int.parse(homeTeamPrediction),//int.parse(_homeTeamPrediction.value),
     awayTeamPrediction: int.parse(awayTeamPrediction),//int.parse(_awayTeamPrediction.value),
     //homeTeamScore: int.parse(_homeTeamScore.value),
     //awayTeamScore: int.parse(_awayTeamScore.value),
     matchStatus: matchStatus,
     fixtureId: fixtureId
   );

   return db.addPrediction(prediction, _appUserId.value);
   /*.then((value) => _predictionSaved.sink.add(true))
   .catchError((error) => _predictionSaved.sink.add(false));*/
 }

 Future<void> saveFavorite (String homeTeamName, String awayTeamName,
 String matchStatus, String fixtureId, String homeTeamPrediction, String awayTeamPrediction,
 String homeTeamScore, String awayTeamScore, bool isFavorite, String userId) async {

   

   var favorite = Favorite(
     homeTeamPrediction: homeTeamPrediction,
     awayTeamPrediction: awayTeamPrediction,
     homeTeamName: homeTeamName,
     awayTeamName: awayTeamName,
     homeTeamScore: homeTeamScore,
     awayTeamScore: awayTeamScore,
     matchStatus: matchStatus,
     fixtureId: fixtureId,
     isFavorite: isFavorite
   );

   return db.addFavorite(favorite, userId);
   /*.then((value) => _predictionSaved.sink.add(true))
   .catchError((error) => _predictionSaved.sink.add(false));*/
 }

 Future<void> saveFavorite2 (String fixtureId, String userId) async {

   

   var favorite2 = Favorite2(
     
     fixtureId: fixtureId,
     
   );

   return db.addFavorite2(favorite2, userId);
   /*.then((value) => _predictionSaved.sink.add(true))
   .catchError((error) => _predictionSaved.sink.add(false));*/
 }


  Future<void> savePredictedFixture () async {

   

   var prediction = Prediction(
     homeTeamPrediction: int.parse(_homeTeamPrediction.value),
     awayTeamPrediction: int.parse(_awayTeamPrediction.value),
     //homeTeamScore: int.parse(_homeTeamScore.value),
     //awayTeamScore: int.parse(_awayTeamScore.value),
     matchStatus: _matchStatus.value,
     fixtureId: _fixtureId.value,
   );

   return db.addPrediction(prediction, _appUserId.value).then((value) => _predictionSaved.sink.add(true))
   .catchError((error) => _predictionSaved.sink.add(false));
 }

 

}