import 'package:Donballondor/src/app.dart';
import 'package:Donballondor/src/blocs/prediction_bloc.dart';
import 'package:Donballondor/src/models/user.dart';
import 'package:Donballondor/src/services/api_service.dart';
import 'package:Donballondor/src/services/firestore_service.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/widgets/livescores_list.dart';
import 'package:Donballondor/src/widgets/loading.dart';
import 'package:Donballondor/src/widgets/profile.dart';
import 'package:Donballondor/src/widgets/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:table_calendar/table_calendar.dart';

class ProfileProvider extends StatefulWidget {
  @override
  _ProfileProviderState createState() => _ProfileProviderState();
}

class _ProfileProviderState extends State<ProfileProvider> {
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

    return StreamProvider(
      create: (conxtext) => db.fetchPredictionsByUserId(appUser.userId),
      child: StreamProvider(
          create: (context) => db.fetchFavoritesByUserId(appUser.userId),
          child: Container(
              child: RefreshIndicator(
                  color: AppColors.notshinygold,
                  backgroundColor: AppColors.darkblue,
                  onRefresh: _getData,
                  child: Profile()))),
    );
  }
}
