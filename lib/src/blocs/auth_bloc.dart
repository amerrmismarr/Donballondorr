import 'dart:async';
import 'dart:io';

import 'package:Donballondor/src/models/user.dart';
import 'package:Donballondor/src/services/firebase_storage_service.dart';
import 'package:Donballondor/src/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

final RegExp regExpEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

class AuthBloc {
  
  final _imageURL = BehaviorSubject<String>();
  final _score = BehaviorSubject<int>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _user = BehaviorSubject<AppUser>();
  final _errorMessage = BehaviorSubject<String>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FireStoreService _fireStoreService = FireStoreService();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Get Data
  Stream<String> get imageURL => _imageURL.stream;
  Stream<int> get score => _score.stream;
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get isValid =>
      CombineLatestStream.combine2(email, password, (email, password) => true);
  Stream<AppUser> get appUser => _user.stream;
  Stream<String> get errorMessage => _errorMessage.stream;
  String get userId => _user.value.userId;
  final googleSignIn = GoogleSignIn(scopes: ['email']);

  final _picker = ImagePicker();
  final storageService = FirebaseStorageService();



  //Set Data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(int) get changeScore => _score.sink.add;
  Function(String) get changeImageUrl => _imageURL.sink.add;

  dispose() {
    _email.close();
    _password.close();
    _user.close();
    _errorMessage.close();
    _score.close();
    _imageURL.close();
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
          AppUser(
            userId: authResult.user.uid, 
            email: _email.value.trim(),
            score: 0,
            imagePath: 'https://thumbs.dreamstime.com/z/golden-profile-icon-d-illustration-73959732.jpg',
            isDarkMode: true,
            country: "country",
            name: 'name'
            );

      await _fireStoreService.addUser(user);
      _user.sink.add(user);
    } on PlatformException catch (error) {
      print(error);
      _errorMessage.sink.add(error.message);
    } on FirebaseAuthException catch (error) {
      print(error);
      _errorMessage.sink.add(error.message);
    } catch (error) {
      _errorMessage.sink.add('Sign up failed');
      print(error.toString());
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
    } on FirebaseAuthException catch (error) {
      print(error);
      _errorMessage.sink.add(error.message);
    } catch (error) {
      _errorMessage.sink.add('Sign in failed');
      print(error.toString());
    }
  }

  signInGoogle() async {

    //google login
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

        //Sign in to firebase
        final result = await _auth.signInWithCredential(credential);

        //check if user exists
       
          print(result.user.email);
            //var existingUser = await _fireStoreService.fetchUser(result.user.uid);
            var user = AppUser(
              email: result.user.email, 
              userId: result.user.uid,
              score: 0,
              imagePath: 'https://thumbs.dreamstime.com/z/golden-profile-icon-d-illustration-73959732.jpg',
              isDarkMode: true,
              country: "country",
              name: 'name'

            ); 
            await _fireStoreService.addUser(user);

            _user.sink.add(user);

        
        
          } on FirebaseAuthException catch (error) {
            print(error);
            _errorMessage.sink.add(error.message);
          } catch (error) {
          _errorMessage.sink.add('Google Authorization failed');
          print(error.toString());
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

  
  pickImage(String userId) async {
    PickedFile image;
    var firebaseUser =  _auth.currentUser;


    //get Image from device
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;
    if(permissionStatus.isGranted){
      image = await _picker.getImage(source: ImageSource.gallery);
      print(image.path);

    //upload to Firebase
    if(image != null){
      var imageUrl = await storageService
      .uploadProfileImage(File(image.path), userId)
      .then((value) {
        _db
     .collection('users')
     .doc(firebaseUser.uid)
     .update({'imagePath': value});
     _imageURL.sink.add(value);
      } );

      
      
      print(imageUrl);
    } else {
      print('No path Received');
    }
    
  } else {
    print('Grant permissions and try again');
  }


    
    
  }

  logout () async {
    await _auth.signOut();
    _user.sink.add(null);
  }

  clearErrorMessage(){
    _errorMessage.sink.add('');
  }
}
