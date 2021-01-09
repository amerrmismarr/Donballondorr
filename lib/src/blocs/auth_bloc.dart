import 'dart:async';

import 'package:Donballondor/src/models/user.dart';
import 'package:Donballondor/src/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

final RegExp regExpEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

class AuthBloc {
  final _score = BehaviorSubject<int>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _user = BehaviorSubject<AppUser>();
  final _errorMessage = BehaviorSubject<String>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FireStoreService _fireStoreService = FireStoreService();

  //Get Data
  Stream<int> get score => _score.stream;
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get isValid =>
      CombineLatestStream.combine2(email, password, (email, password) => true);
  Stream<AppUser> get appUser => _user.stream;
  Stream<String> get errorMessage => _errorMessage.stream;
  String get userId => _user.value.userId;


  //Set Data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(int) get changeScore => _score.sink.add;

  dispose() {
    _email.close();
    _password.close();
    _user.close();
    _errorMessage.close();
    _score.close();
  }

  //Transformers
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (regExpEmail.hasMatch(email.trim())) {
      sink.add(email.trim());
    } else {
      sink.addError('Must be valid email address');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 8) {
      sink.add(password.trim());
    } else {
      sink.addError('8 Charachters Minimum');
    }
  });

  //functions

  signupEmail() async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: _email.value.trim(),
        password: _password.value.trim(),
      );
      var user =
          AppUser(userId: authResult.user.uid, email: _email.value.trim());

      await _fireStoreService.addUser(user);
      _user.sink.add(user);
    } on PlatformException catch (error) {
      print(error);
      _errorMessage.sink.add(error.message);
    }
  }

  loginEmail() async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: _email.value.trim(),
        password: _password.value.trim(),
      );
      var user = await _fireStoreService.fetchUser(authResult.user.uid);
      _user.sink.add(user);
    } on PlatformException catch (error) {
      print(error);
      _errorMessage.sink.add(error.message);
    }
  }

  Future<bool> isLoggedIn() async {

    var firebaseUser =  _auth.currentUser;
    if(firebaseUser == null) return false;

    var user = await _fireStoreService.fetchUser(firebaseUser.uid);
    if(user == null) return false;

    _user.sink.add(user);
    return true;
    
  }

  logout () async {
    await _auth.signOut();
    _user.sink.add(null);
  }

  clearErrorMessage(){
    _errorMessage.sink.add('');
  }
}
