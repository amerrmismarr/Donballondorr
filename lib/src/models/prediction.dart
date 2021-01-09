import 'package:flutter/foundation.dart';

class Prediction {
  final int homeTeamPrediction;
  final int awayTeamPrediction;
  final int homeTeamScore;
  final int awayTeamScore;
  final String matchStatus;
  final String fixtureId;
  final bool isCalculated;

  Prediction(
      {@required this.awayTeamPrediction,
      @required this.homeTeamPrediction,
      this.awayTeamScore,
      this.homeTeamScore,
      this.isCalculated,
      @required this.matchStatus,
      @required this.fixtureId});

  Map<String, dynamic> toMap() {
    return {
      'homeTeamPrediction': homeTeamPrediction,
      'awayTeamPrediction': awayTeamPrediction,
      'homeTeamScore': homeTeamScore,
      'awayTeamScore': awayTeamScore,
      'matchStatus': matchStatus,
      'fixtureId' : fixtureId,
      'isCalculated' : isCalculated
    };
  }

  Prediction.fromFirestore(Map<String, dynamic> firestore)
      : homeTeamPrediction = firestore['homeTeamPrediction'],
        awayTeamPrediction = firestore['awayTeamPrediction'],
        homeTeamScore = firestore['homeTeamScore'],
        awayTeamScore = firestore['awayTeamScore'],
        matchStatus = firestore['matchStatus'],
        fixtureId = firestore['fixtureId'],
        isCalculated = firestore['isCalculated'];

}
