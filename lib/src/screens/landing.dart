import 'dart:async';

import 'package:Donballondor/src/blocs/auth_bloc.dart';
import 'package:Donballondor/src/models/user.dart';
import 'package:Donballondor/src/screens/verify.dart';
import 'package:Donballondor/src/services/firestore_service.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/widgets/admin_scaffold.dart';
import 'package:Donballondor/src/widgets/favorite_fixtures.dart';
import 'package:Donballondor/src/widgets/favorites_provider.dart';
import 'package:Donballondor/src/widgets/grouped_countries.dart';
import 'package:Donballondor/src/widgets/instructions.dart';
import 'package:Donballondor/src/widgets/leaderboard.dart';
import 'package:Donballondor/src/widgets/loading.dart';
import 'package:Donballondor/src/widgets/loginToFavorites.dart';
import 'package:Donballondor/src/widgets/navbar.dart';
import 'package:Donballondor/src/widgets/info.dart';
import 'package:Donballondor/src/widgets/livescores.dart';
import 'package:Donballondor/src/widgets/profile.dart';
import 'package:Donballondor/src/widgets/profile_provider.dart';
import 'package:Donballondor/src/widgets/settings.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';

import 'login.dart';

class Landing extends StatefulWidget {
  StreamSubscription _userSubscription;
  @override
  _LandingState createState() => _LandingState();

  static TabBar get tabBar {
    return TabBar(
        //indicatorColor: AppColors.lightblue,
        //labelColor: AppColors.lightblue,
        tabs: <Widget>[
          new Tab(icon: new Icon(Icons.info)),
          new Tab(icon: new Icon(Icons.person)),
          new Tab(icon: new Icon(Icons.sports_soccer)),
          new Tab(icon: new Icon(Icons.favorite)),
          new Tab(icon: new Icon(Icons.leaderboard)),
          new Tab(icon: new Icon(Icons.settings))
        ]);
  }
}

class _LandingState extends State<Landing> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var authBloc = Provider.of<AuthBloc>(context, listen: false);
      widget._userSubscription = authBloc.appUser.listen((user) {
        /*if (user == null)
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/landing', (route) => false);*/
      });
    });
    controller = new TabController(vsync: this, length: 6, initialIndex: 2);

    super.initState();
  }

  @override
  void dispose() {
    if (widget._userSubscription != null) {
      widget._userSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isLoggedIn = Provider.of<bool>(context);
    final db = FireStoreService();
    final appUser = Provider.of<AppUser>(context);
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  AppNavBar.cupertinoNavBar(
                      title: 'Live Scores', buildContext: context)
                ];
              },
              body: AdminScaffold.cupertinoTabScaffold));
    } else {
      return DefaultTabController(
        initialIndex: 2,
        length: 6,
        child: appUser != null ? StreamProvider(
          create: (context) => db.fetchFavoritesByUserId(appUser.userId),
          builder: (context, snapshot) {
            return Scaffold(
              bottomNavigationBar: AppNavBar.bottomNavBar(tabbar :Landing.tabBar),
              body: new TabBarView(
                  children: <Widget>[
                    Instructions(),
                    ProfileProvider(),
                    LiveScores(),
                    FavoriteFixtures(),
                    LeaderBoard(),
                    SettingsScreen()
                  ],
                ),
              );
          }
        ) : Scaffold(
              bottomNavigationBar: AppNavBar.bottomNavBar(tabbar :Landing.tabBar),
              body: new TabBarView(
                  children: <Widget>[
                    Instructions(),
                    ProfileProvider(),
                    LiveScores(),
                    FavoritesProvider(), 
                    LeaderBoard(),
                    SettingsScreen()
                  ],
                ),
              ),
        
      );
    }
  }
}
