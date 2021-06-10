import 'package:flutter/foundation.dart';

class Favorite2 {
  
  final String fixtureId;
  

  Favorite2(
      { this.fixtureId});

  Map<String, dynamic> toMap() {
    return {
      
      fixtureId : true,
      
    };
  }

  Favorite2.fromFirestore(Map<String, dynamic> firestore)
      : 
        
        fixtureId = firestore['fixtureId'];
        

}
