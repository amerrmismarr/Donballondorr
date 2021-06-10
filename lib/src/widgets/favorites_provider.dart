import 'package:Donballondor/src/app.dart';
import 'package:Donballondor/src/blocs/prediction_bloc.dart';
import 'package:Donballondor/src/models/user.dart';
import 'package:Donballondor/src/screens/loginToProfile.dart';
import 'package:Donballondor/src/services/api_service.dart';
import 'package:Donballondor/src/services/firestore_service.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/widgets/favorite_fixtures.dart';
import 'package:Donballondor/src/widgets/livescores_list.dart';
import 'package:Donballondor/src/widgets/loading.dart';
import 'package:Donballondor/src/widgets/loginToFavorites.dart';
import 'package:Donballondor/src/widgets/profile.dart';
import 'package:Donballondor/src/widgets/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:table_calendar/table_calendar.dart';

class FavoritesProvider extends StatefulWidget {
  @override
  _FavoritesProviderState createState() => _FavoritesProviderState();
}

class _FavoritesProviderState extends State<FavoritesProvider> {
  @override
  void initState() {
    Profile profile = Provider.of<Profile>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: pageBody(),
    );
  }

  Future<void> _getData() async {
    setState(() {
      
    });
  }

  Widget pageBody() {
    final db = FireStoreService();
    final appUser = Provider.of<AppUser>(context);

    return  appUser != null ? StreamProvider(
      create: (context) => db.fetchPredictionsByUserId(appUser.userId),
      child: StreamProvider(
          create: (context) => db.fetchFavoritesByUserId(appUser.userId),
          child: Container(
              child:  FavoriteFixtures())),
    ) : Center(child: Text('Log in to view your favorite matches',style: TextStyles.body),);
  }
}
