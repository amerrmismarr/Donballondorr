import 'package:flutter/foundation.dart';

class Favorite {
  final String homeTeamName;
  final String awayTeamName;
  final String homeTeamPrediction;
  final String awayTeamPrediction;
  final String homeTeamScore;
  final String awayTeamScore;
  final String matchStatus;
  final String fixtureId;
  final bool isFavorite;

  Favorite(
      { this.homeTeamName,
       this.awayTeamName,
       this.homeTeamPrediction,
       this.awayTeamPrediction,
      this.awayTeamScore,
      this.homeTeamScore,
      this.isFavorite,
       this.matchStatus,
       this.fixtureId});

  Map<String, dynamic> toMap() {
    return {
      'homeTeamName': homeTeamName,
      'awayTeamName': awayTeamName,
      'homeTeamPrediction': homeTeamPrediction,
      'awayTeamPrediction': awayTeamPrediction,
      'homeTeamScore': homeTeamScore,
      'awayTeamScore': awayTeamScore,
      'matchStatus': matchStatus,
      'fixtureId' : fixtureId,
      'isFavorite' : isFavorite
    };
  }

  Favorite.fromFirestore(Map<String, dynamic> firestore)
      : 
        homeTeamName = firestore['homeTeamName'],
        awayTeamName = firestore['awayTeamName'],
        homeTeamPrediction = firestore['homeTeamPrediction'],
        awayTeamPrediction = firestore['awayTeamPrediction'],
        homeTeamScore = firestore['homeTeamScore'],
        awayTeamScore = firestore['awayTeamScore'],
        matchStatus = firestore['matchStatus'],
        fixtureId = firestore['fixtureId'],
        isFavorite = firestore['isFavorite'];

}
