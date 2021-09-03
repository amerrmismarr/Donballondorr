import 'package:Donballondor/src/app.dart';
import 'package:Donballondor/src/blocs/prediction_bloc.dart';
import 'package:Donballondor/src/models/user.dart';
import 'package:Donballondor/src/services/api_service.dart';
import 'package:Donballondor/src/services/firestore_service.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/styles/themes.dart';
import 'package:Donballondor/src/widgets/afterTomorrowFixtures.dart';
import 'package:Donballondor/src/widgets/beforeYesterdayFixtures.dart';
import 'package:Donballondor/src/widgets/calendar_view.dart';
import 'package:Donballondor/src/widgets/liveFixtures.dart';
import 'package:Donballondor/src/widgets/livescores_list.dart';
import 'package:Donballondor/src/widgets/loading.dart';
import 'package:Donballondor/src/widgets/match_info.dart' ;
import 'package:Donballondor/src/widgets/profile.dart' ;
import 'package:Donballondor/src/widgets/table_calendar.dart';
import 'package:Donballondor/src/widgets/today_fixtures.dart';
import 'package:Donballondor/src/widgets/tomorrowFixtures.dart';
import 'package:Donballondor/src/widgets/yesterdayFixtures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:table_calendar/table_calendar.dart';



class LiveScores extends StatefulWidget {
  @override
  _LiveScoresState createState() => _LiveScoresState();
}

class _LiveScoresState extends State<LiveScores> with SingleTickerProviderStateMixin {
  String formattedDate;

  String nameOfToday;
  String nameOfYesterday;
  String nameOfBeforeYesterday;
  String nameOfTomorrow;
  String nameOfAfterTomorrow;

  String nameOfTodayMonth;
  String nameOfYesterdayMonth;
  String nameOfBeforeYesterdayMonth;
  String nameOfTomorrowMonth;
  String nameOfAfterTomorrowMonth;
  

  CalendarController controller;
  TabController tabController;
  
  CustomTheme customTheme = CustomTheme();
  @override
  void initState() {

    tabController = new TabController(vsync: this, length: 7, initialIndex: 3);


    ApiService apiService = Provider.of<ApiService>(context, listen: false);
    
    controller = CalendarController();
    var outputFormat = DateFormat("yyyy-MM-dd");
    formattedDate = outputFormat.format(DateTime.now());
    apiService.getFixtures(formattedDate, context);
    print(formattedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context);
    final predictionBloc = PredictionBloc();
    DateTime now = DateTime.now();
    
    //var dayNameFormat = DateFormat.ABBR_WEEKDAY;
    nameOfToday = DateFormat(DateFormat.ABBR_WEEKDAY).format(DateTime(now.year, now.month, now.day));
    nameOfYesterday = DateFormat(DateFormat.ABBR_WEEKDAY).format(DateTime(now.year, now.month, now.day - 1));
    nameOfBeforeYesterday = DateFormat(DateFormat.ABBR_WEEKDAY).format(DateTime(now.year, now.month, now.day - 2));
    nameOfTomorrow = DateFormat(DateFormat.ABBR_WEEKDAY).format(DateTime(now.year, now.month, now.day + 1));
    nameOfAfterTomorrow = DateFormat(DateFormat.ABBR_WEEKDAY).format(DateTime(now.year, now.month, now.day + 2));
    //print(nameOfToday);
    nameOfTodayMonth = DateFormat(DateFormat.ABBR_MONTH).format(DateTime(now.year, now.month, now.day));
    nameOfYesterdayMonth = DateFormat(DateFormat.ABBR_MONTH).format(DateTime(now.year, now.month, now.day - 1));
    nameOfBeforeYesterdayMonth = DateFormat(DateFormat.ABBR_MONTH).format(DateTime(now.year, now.month, now.day - 2));
    nameOfTomorrowMonth = DateFormat(DateFormat.ABBR_MONTH).format(DateTime(now.year, now.month, now.day + 1));
    nameOfAfterTomorrowMonth = DateFormat(DateFormat.ABBR_MONTH).format(DateTime(now.year, now.month, now.day + 2));
    print(nameOfTodayMonth);

    


    




    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: pageBody(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          flexibleSpace: SafeArea(
            child: new TabBar(
             isScrollable: true,
            indicatorColor: customTheme.isDarkMode == true ? AppColors.notshinygold : Colors.white,
            labelColor: customTheme.isDarkMode == true ? AppColors.notshinygold : Colors.white,
            controller: tabController,
                          tabs: <Widget>[
                            new Tab(icon: Icon(Icons.live_tv) ),
                            
                            new Tab(child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(nameOfBeforeYesterday + "\n" + 
                                (DateTime.now().subtract(Duration(days: 2)).day).toString() + " " + nameOfBeforeYesterdayMonth
                                , textAlign: TextAlign.center,
                                ),
                            ),
                            ),
                            new Tab(child: Text(nameOfYesterday + "\n" + 
                              (DateTime.now().subtract(Duration(days: 1)).day).toString() + " " + nameOfBeforeYesterdayMonth
                              , textAlign: TextAlign.center,
                              ),
                            ),
                            new Tab(child: Text("Today" + "\n" + 
                              (DateTime.now().day ).toString() + " " + nameOfTodayMonth
                              , textAlign: TextAlign.center,
                              ),
                            ),
                            new Tab(child: Text(nameOfTomorrow + "\n" + 
                              (DateTime.now().add(Duration(days: 1)).day).toString() + " " + nameOfTomorrowMonth
                              , textAlign: TextAlign.center,),
                            ),
                            new Tab(child: Text(nameOfAfterTomorrow + "\n" + 
                              (DateTime.now().add(Duration(days: 2)).day).toString() + " " + nameOfAfterTomorrowMonth
                              , textAlign: TextAlign.center,
                              ),
                            ),
                          
                            new Tab(icon: Icon(Icons.calendar_today) ),
          
                            
          
                            
                            
                          ]),
          ),
          
          
          //backgroundColor: AppColors.lightblue,
        ),
        body: pageBody(),
      );
    }
  }

  Future<void> _getData() async {
    setState(() {
      apiService.getFixtures(formattedDate, context);
    });
  }

  Widget pageBody() {
    final db = FireStoreService();
    final appUser = Provider.of<AppUser>(context);

    return  TabBarView(controller: tabController, children: <Widget>[
                      new LiveFixtures(),
                      new BeforeYesterdayFixtures(),
                      new YesterdayFixtures(),
                      new TodayFixtures(),
                      new TomorrowFixtures(),
                      new AfterTomorrowFixtures(),
                      new CalendarView(),
                    ]);
                  


    /*return StreamProvider(
      create: (conxtext) => db.fetchPredictionsByUserId(appUser.userId) ,
          child: StreamProvider(
            create: (context) => db.fetchFavoritesByUserId(appUser.userId),
                      child: ListView(
              children: [
                tableCalendar(),
                StreamBuilder<List<dynamic>>(
                    stream: apiService.fixtures,
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
          
      
    );*/
  }

  Widget tableCalendar(){

    return TableCalendar(
      //initialSelectedDay: DateTime.utc(2021),
            calendarController: controller,
            initialCalendarFormat: CalendarFormat.week,
            calendarStyle: CalendarStyle(
              markersMaxAmount: 0,
              todayStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            headerStyle: HeaderStyle(
              titleTextStyle: TextStyle(color: AppColors.notshinygold),
              centerHeaderTitle: true,
              formatButtonDecoration: BoxDecoration(
                  color: AppColors.notshinygold,
                  borderRadius: BorderRadius.circular(25.0)),
              formatButtonTextStyle: TextStyle(color: AppColors.darkblue),
              formatButtonShowsNext: false,
            ),
            onDaySelected: (date, events, event) {
              var outputFormat = DateFormat("yyyy-MM-dd");
              formattedDate = outputFormat.format(date);
              print(formattedDate);
              apiService.getFixtures(formattedDate, context);
            },
            builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(224, 176, 92, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        color: Color.fromRGBO(13, 18, 38, 1),
                      ),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(228, 188, 112, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        color: Color.fromRGBO(13, 18, 38, 1),
                      ),
                    )),
                dayBuilder: (context, date, events) {
                  return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                            color: Color.fromRGBO(224, 176, 92, 1),
                            fontWeight: FontWeight.bold),
                      ));
                }),
          );

  }
}
