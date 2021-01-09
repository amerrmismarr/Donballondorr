import 'package:Donballondor/src/models/favorites.dart';
import 'package:Donballondor/src/models/prediction.dart';
import 'package:Donballondor/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addUser(AppUser user) {
    return _db.collection('users').doc(user.userId).set(user.toMap());
  }

  Future<AppUser> fetchUser(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .get()
        .then((snapshot) => AppUser.fromFireStore(snapshot.data()));
  }

  Future<void> addPrediction(Prediction prediction, String userId) {
    var options = SetOptions(merge: true);
    return _db
        .collection('users')
        .doc(userId)
        .collection('Predictions')
        .doc(prediction.fixtureId.toString())
        .set(prediction.toMap(), options);
  }

  Future<void> addFavorite(Favorite favorite, String userId) {
    var options = SetOptions(merge: true);
    return _db
        .collection('users')
        .doc(userId)
        .collection('Favorites')
        .doc(favorite.fixtureId.toString())
        .set(favorite.toMap(), options);
  }

  Future<void> addFavoriteId(String userId, String fixtureId) {
    var options = SetOptions(merge: true);
    return _db
        .collection('users')
        .doc(userId)
        .collection('FavoriteIdList')
        .doc(userId)
        .update({fixtureId : true});

  }

  

  /*Future<void> addPredictedFixture(PredictedFixture predictedFixture, String userId) {
    var options = SetOptions(merge: true);
    return _db
        .collection('users')
        .doc(userId)
        .collection('Predicted Fixtures')
        .doc(predictedFixture.fixtureId.toString())
        .set(predictedFixture.toMap(), options);
  }*/

  Future<Prediction> fetchPrediction(String fixtureId, String userId){
    return _db.collection('users').doc(userId).collection('Predictions')
    .doc(fixtureId).get().then((snapshot) => Prediction.fromFirestore(snapshot.data()));
  }

  Stream<List<Prediction>> fetchPredictionsByUserId(String userId){
    return _db.collection('users').doc(userId).collection('Predictions')
    .snapshots().map((fixtures) => fixtures.docs)
    .map((snapshot) => snapshot.map((prediction) => Prediction.fromFirestore(prediction.data()))
    .toList());
  }

  Stream<List<AppUser>> fetchUsers(){
    return _db.collection('users').snapshots()
    .map((users) => users.docs)
    .map((snapshot) => snapshot.map((user) => AppUser.fromFireStore(user.data())));
    
    /*(userId).collection('Predictions')
    .snapshots().map((fixtures) => fixtures.docs)
    .map((snapshot) => snapshot.map((prediction) => Prediction.fromFirestore(prediction.data()))
    .toList());*/
  }

  Future fetchUsersList() async {
    List usersList = []; 
    try {
      await FirebaseFirestore.instance.collection('users').get().then((querySnapshot) => {
        querySnapshot.docs.forEach((element) {
          usersList.add(element.data());
        })
      });
      return usersList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<Favorite>> fetchFavoritesByUserId(String userId){
    return _db.collection('users').doc(userId).collection('Favorites')
    .snapshots().map((favorites) => favorites.docs)
    .map((snapshot) => snapshot.map((favorite) => Favorite.fromFirestore(favorite.data()))
    .toList());
  }

  

  /*Stream<List<PredictedFixture>> fetchPredictedFixturesByUserId(String userId){
    return _db.collection('users').doc(userId).collection('Predictions')
    .snapshots().map((fixtures) => fixtures.docs)
    .map((snapshot) => snapshot.map((predictedFixture) => PredictedFixture.fromFirestore(predictedFixture.data()))
    .toList());
  }*/

}
