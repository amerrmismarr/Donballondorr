import 'dart:convert';

import 'package:Donballondor/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

const simplePeriodicTask = "SimplePeriodicTask";

void showNotification(v, flp, channelId) async {
  var android = AndroidNotificationDetails('channelId', 'channelName', 'channelDescription',
  priority: Priority.high, importance: Importance.max);

  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android: android, iOS: iOS);
  await flp.show(channelId, 'Donballondor', '$v', platform, payload: 'DBD \n $v');

}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  //await Workmanager.registerPeriodicTask('S', simplePeriodicTask,
  //existingWorkPolicy: ExistingWorkPolicy.replace,
  //frequency: Duration(minutes: 15),
  //constraints: Constraints(networkType: NetworkType.connected));
  runApp(MyApp());
}

void callbackDispatcher(){
  Workmanager.executeTask((taskName, inputData) async {

    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('app');
    var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android: android, iOS: iOS);
    flp.initialize(initSettings);
    var response = await http.get(Uri.encodeFull('https://api-football-v1.p.rapidapi.com/v2/fixtures/live'), headers: {
      'Accept': 'application/json',
      "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
      "x-rapidapi-key": "9277c6f840mshffcaa155ce6daf9p1f43c7jsnff99eae70a7c",
    });

    Map<String, dynamic> map = jsonDecode(response.body);
    print(map['api']['fixtures'][1]['homeTeam']['team_name']);


    List<dynamic> liveFixtures = map['api']['fixtures'];

    Random random = new Random();

    liveFixtures.forEach((liveFixture) {

      /*if(liveFixture['statusShort'] == '1H'){
        showNotification('Match Started!' + liveFixture['homeTeam']['team_name'] +
        ' ' + 'vs' + ' ' + liveFixture['awayTeam']['team_name'], flp,random.nextInt(1000) );
        print(liveFixture['statusShort']);

      } else if (liveFixture['statusShort'] == 'HT') {
        showNotification('Half Time!' + liveFixture['homeTeam']['team_name'] +
        ' ' + 'vs' + ' ' + liveFixture['awayTeam']['team_name'], flp,random.nextInt(1000));
        print(liveFixture['statusShort']);
      } else if (liveFixture['statusShort'] == 'FT') {
        showNotification('Match Finished!' + liveFixture['homeTeam']['team_name'] +
        ' ' + 'vs' + ' ' + liveFixture['awayTeam']['team_name'], flp,random.nextInt(1000));
        print(liveFixture['statusShort']);
      }*/
      
    });
      
      


    return Future.value(true);
  });
}

