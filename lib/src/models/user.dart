import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final String userId;
  final String email;
  int score = 0;
  final String imagePath;
  final bool isDarkMode;
  final String name;
  final String country;

  AppUser({
    this.email, this.userId, this.score, this.imagePath, this.isDarkMode,this.name,this.country
  });
  

  Map<String, dynamic> toMap(){
    return {
      'userId' : userId,
      'email' : email,
      'score' : 0,
      'imagePath': 'https://thumbs.dreamstime.com/z/golden-profile-icon-d-illustration-73959732.jpg',
      'isDarkMode': true,
      'country': country,
      'name': name,
    };
  }

  AppUser.fromFireStore(Map<String,dynamic> firestore)

  : userId = firestore['userId'],
  email = firestore['email'],
  score = firestore['score'],
  imagePath = firestore['imagePath'],
  isDarkMode = firestore['isDarkMode'],
  country = firestore['country'],
  name = firestore['name'];

  




  
}