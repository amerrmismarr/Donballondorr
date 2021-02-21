import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final String userId;
  final String email;
  int score = 0;

  AppUser({
    this.email, this.userId, this.score
  });
  

  Map<String, dynamic> toMap(){
    return {
      'userId' : userId,
      'email' : email,
      'score' : 0,
    };
  }

  AppUser.fromFireStore(Map<String,dynamic> firestore)

  : userId = firestore['userId'],
  email = firestore['email'],
  score = firestore['score'];




  
}