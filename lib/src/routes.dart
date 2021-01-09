import 'package:Donballondor/src/screens/landing.dart';
import 'package:Donballondor/src/screens/login.dart';
import 'package:Donballondor/src/screens/signup.dart';
import 'package:Donballondor/src/screens/admin.dart';
import 'package:Donballondor/src/screens/statistics.dart';
import 'package:Donballondor/src/widgets/info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static MaterialPageRoute materialRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/landing':
        return MaterialPageRoute(builder: (context) => Landing());
      case '/signup':
        return MaterialPageRoute(builder: (context) => Signup());
      case '/login':
        return MaterialPageRoute(builder: (context) => Login());
      case '/admin':
        return MaterialPageRoute(builder: (context) => Admin());
      case '/statistics':
        return MaterialPageRoute(
            builder: (context) => Statistics(
             
                  /*homeTeamId: args,
                  awayTeamId: args,
                  fixtureId: args,
                  homeTeamName: args,
                  awayTeamName: args,
                  homeTeamLogo: args,
                  awayTeamLogo: args,
                  goalsHomeTeam: args,
                  goalsAwayTeam: args,
                  statusShort: args,*/
                ));
      default:
        var routeArray = settings.name.split('/');
        if (settings.name.contains('/statistics/')){
          return MaterialPageRoute(builder: (context) => Orders(fixtureId : routeArray[2],));
        }
        return MaterialPageRoute(builder: (context) => Login());
    }
  }

  static CupertinoPageRoute cupertinoRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/landing':
        return CupertinoPageRoute(builder: (context) => Landing());
      case '/signup':
        return CupertinoPageRoute(builder: (context) => Signup());
      case '/login':
        return CupertinoPageRoute(builder: (context) => Login());
      case '/admin':
        return CupertinoPageRoute(builder: (context) => Admin());
      case '/statistics':
        return CupertinoPageRoute(builder: (context) => Statistics());
      default:
        return CupertinoPageRoute(builder: (context) => Login());
    }
  }
}
