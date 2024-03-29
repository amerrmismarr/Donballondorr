import 'package:Donballondor/src/app.dart';
import 'package:Donballondor/src/blocs/prediction_bloc.dart';
import 'package:Donballondor/src/models/user.dart';
import 'package:Donballondor/src/services/api_live_service.dart';
import 'package:Donballondor/src/services/api_service.dart';
import 'package:Donballondor/src/services/firestore_service.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/widgets/livescores_list.dart';
import 'package:Donballondor/src/widgets/loading.dart';
import 'package:Donballondor/src/widgets/match_info.dart' ;
import 'package:Donballondor/src/widgets/profile.dart' ;
import 'package:Donballondor/src/widgets/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:table_calendar/table_calendar.dart';



class LiveFixtures extends StatefulWidget {
  @override
  _LiveFixturesState createState() => _LiveFixturesState();
}

class _LiveFixturesState extends State<LiveFixtures>  {
  String formattedDate;
  CalendarController controller;
  TabController tabController;

  
  

  @override
  void initState() {



    ApiLiveService apiLiveService = Provider.of<ApiLiveService>(context, listen: false);
    
    controller = CalendarController();
    final now = DateTime.now();
    //var outputFormat = DateFormat("yyyy-MM-dd");
    //formattedDate = outputFormat.format(DateTime(now.year,now.month,now.day + 1));
    apiLiveService.getFixtures(context);
    //print(formattedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context);
    final predictionBloc = PredictionBloc();


    




    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: pageBody(),
      );
    } else {
      return Scaffold(
        
        body: pageBody(),
      );
    }
  }

  Future<void> _getData() async {
    setState(() {
      apiLiveService.getFixtures(context);
    });
  }

  Widget pageBody() {
    final db = FireStoreService();
    final appUser = Provider.of<AppUser>(context);

    
                  


    return StreamProvider(
      create: (conxtext) => db.fetchPredictionsByUserId(appUser.userId) ,
          child: StreamProvider(
            create: (context) => db.fetchFavoritesByUserId(appUser.userId),
                      child: ListView(
              children: [
                StreamBuilder<List<dynamic>>(
                    stream: apiLiveService.fixtures,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return RefreshIndicator(
                                color: AppColors.notshinygold,
                                backgroundColor: AppColors.darkblue,
                                onRefresh: _getData,
                                child: LiveScoreList(elements: snapshot.data));
                       }else {
                        return Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Center(child: Loading()));
                      }
                    }),
                SizedBox(
                  height: 10,
                )
              ],
        ),
          ),
          
      
    );
  }


}
