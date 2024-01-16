import 'dart:async';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/styles/themes.dart';
import 'package:Donballondor/src/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Head2Head extends StatefulWidget {

  String homeTeamId ;
  String awayTeamId;

  Head2Head({this.homeTeamId, this.awayTeamId});
  @override
  _Head2HeadState createState() => _Head2HeadState(homeTeamId, awayTeamId);
}

class _Head2HeadState extends State<Head2Head> {

  String homeTeamId;
  String awayTeamId;

  _Head2HeadState(this.homeTeamId, this.awayTeamId);


  var loading = false;
  StreamController _streamController = StreamController();
  Stream get _stream => _streamController.stream;

  Head2Head head2head;

  String formattedDate;
  List<dynamic> data;
  List<dynamic> data2;
  List<dynamic> data3;
  List<dynamic> data4;
  List<dynamic> data5;
  final listt = new List.generate(10, (i) => 'item ${i + 1}');

  String changingURL;

  int premierLeagueId = 565;

  CustomTheme customTheme = CustomTheme();

  Future getJsonData(String homeTeamId, String awayTeamId) async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }

    changingURL =
        'https://api-football-v1.p.rapidapi.com/v2/fixtures/h2h/' + homeTeamId + '/' + awayTeamId;
    //_streamController.add(changingURL);
    var response = await http.get(Uri.parse(changingURL), headers: {
      'Accept': 'application/json',
      "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
      "x-rapidapi-key": "API_KEY",
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      data = map['api']['fixtures'];
     
      //data4 = data2 + data3;

      _streamController.add(data);

      // _streamController.add(fixtureGroup);
      //print(data);

      //print(data);

      
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    var outputFormat = DateFormat("yyyy-MM-dd");
    formattedDate = outputFormat.format(DateTime.now());
    getJsonData(homeTeamId, awayTeamId);

    print('home' + homeTeamId + 'away' +  awayTeamId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //print(snapshot.data);
            return Container(
              //color: Color.fromRGBO(13, 18, 38, 1),
              child: 
                  /*Container(
                      color:customTheme.isDarkMode == true ? AppColors.darkblue : Colors.teal,
                      padding: EdgeInsets.all(10.0),
                      height: 50.0,
                      child: Center(
                        child: Text('HEAD TO HEAD', style: TextStyle(color: Color.fromRGBO(224, 176, 92, 1),
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                        )
                      ),
                  ),*/
                  
                  

                  
                     GroupedListView(
                                elements: snapshot.data,
                                groupBy: (element) => element['league_id'],
                                groupHeaderBuilder: (element) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      /*Container(
                                       height: 20.0,
                                       width: 20.0,
                                       child: Image.network(element['league']['logo']),
                                      ),
                                      SizedBox(width: 10,),*/
                                      Text(element['league']['name'] ,),
                                    ],
                                  ),
                                ),
                                indexedItemBuilder: (context, element, index) {
                                  DateTime dateTime = DateTime.parse(element['event_date']);
                                  return Card(
                    shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      borderOnForeground: true,
                                      shadowColor: customTheme.isDarkMode == true?
                                      Color.fromRGBO(224, 176, 92, 1) : Colors.teal,
                                      margin:
                                          EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 0.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(DateFormat('yyyy-MM-dd').format(dateTime))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                              
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Container(
                                       height: 15.0,
                                       width: 15.0,
                                       child: Image.network(element['homeTeam']['logo']),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(element['homeTeam']['team_name'])),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Container(
                                       height: 15.0,
                                       width: 15.0,
                                       child: Image.network(element['awayTeam']['logo']),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(element['awayTeam']['team_name'])),
                                    ),
                                  ],
                                ),
                                
                                
                              ],
                                                  ),
                            ),
                          Column(
                            children: [
                             Padding(
                               padding: const EdgeInsets.fromLTRB(0, 8, 15, 8),
                               child: Align(
                                  alignment: Alignment.centerRight,
                                  child: element['goalsHomeTeam'] != null ? Text(element['goalsHomeTeam'].toString())
                                  :Container()) ,
                             ),
                             Padding(
                               padding: const EdgeInsets.fromLTRB(0, 8, 15, 8),
                               child: Align(
                                  alignment: Alignment.centerRight,
                                  child: element['goalsAwayTeam'] != null ? Text(element['goalsAwayTeam'].toString())
                                  :Container()),
                             ),
                            ],
                          ),
                          
                          ],
                        ),
                      ],
                    ));
                                   
                                  
                                }),
                  );

                  /*SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int i) {
                        DateTime dateTime = DateTime.parse(snapshot.data[i]['event_date']);
                        
                      return  Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                borderOnForeground: true,
                                shadowColor: Color.fromRGBO(224, 176, 92, 1),
                                margin: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 0.0),
                                color: customTheme.isDarkMode == true ? AppColors.darkblue : Colors.teal[100],
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        5.0, 10.0, 5.0, 10.0),
                                    child: Column(
                                      children: <Widget>[

                                        Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                             
                                              
                                              
                                              Text(DateFormat("yyyy-MM-dd").format(dateTime),
                                              style: TextStyle(color: Color.fromRGBO(222, 177, 92, 1))),
                                              Text(snapshot.data[i]['league']['name'],
                                              style: TextStyle(color: Color.fromRGBO(222, 177, 92, 1),
                                                ),
                                              ),

                                              
                                            ]),
                                        SizedBox(
                                          height: 10.0,
                                        ),

                                        Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  
                                              Container(
                                                  height: 20.0,
                                                  width: 20.0,
                                                  child: Image.network(snapshot.data[i]
                                                  ['homeTeam']['logo']),
                                                ),
                                              SizedBox(
                                                width: 10.0,
                                                ),
                                              
                                              Text( snapshot.data[i]['homeTeam']['team_name'] =='null'
                                              ? ' ': snapshot.data[i]['homeTeam']['team_name'],
                                              style: TextStyle(color: Color.fromRGBO(222, 177, 92, 1),
                                                ),
                                              ),],),

                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    snapshot.data[i]['goalsHomeTeam'].toString() =='null'
                                                    ? ' ': snapshot.data[i]['goalsHomeTeam'].toString(),
                                                    style: TextStyle(color: Color.fromRGBO(222, 177, 92, 1),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(width: 25.0,)
                                                ],
                                              ),
                                            ]),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  
                                              Container(
                                                  height: 20.0,
                                                  width: 20.0,
                                                  child: Image.network(snapshot.data[i]
                                                  ['awayTeam']['logo']),
                                                ),
                                              SizedBox(
                                                width: 10.0,
                                                ),
                                              
                                              Text( snapshot.data[i]['awayTeam']['team_name'] =='null'
                                              ? ' ': snapshot.data[i]['awayTeam']['team_name'],
                                              style: TextStyle(color: Color.fromRGBO(222, 177, 92, 1),
                                                ),
                                              ),],),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    snapshot.data[i]['goalsAwayTeam'].toString() =='null'
                                                    ? ' ': snapshot.data[i]['goalsAwayTeam'].toString(),
                                                    style: TextStyle(color: Color.fromRGBO(222, 177, 92, 1),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(width: 25.0,)
                                                ],
                                              ),
                                            ]),
                                      ],
                                    )));
                          
                          
                    }, childCount: snapshot.data.length),
                  ),*/
                  
                
            
          } else {
            return Container(child: Center(child: Loading()));
          }
        });
  }
}

class CustomSliver extends SingleChildRenderObjectWidget {
  CustomSliver({Widget child, Key key}) : super(child: child, key: key);
  @override
  RenderObject createRenderObject(BuildContext context) {
    // ignore: todo
    // TODO: implement createRenderObject
    return RenderSliverTableCalendar();
  }
}

class RenderSliverTableCalendar extends RenderSliverSingleBoxAdapter {
  RenderSliverTableCalendar({
    RenderBox child,
  }) : super(child: child);

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    final SliverConstraints constraints = this.constraints;
    child.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child.size.width;
        break;
      case Axis.vertical:
        childExtent = child.size.height;
        break;
    }
    assert(childExtent != null);
    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      hitTestExtent: paintedChildSize,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
    setChildParentData(child, constraints, geometry);
    // ignore: todo
    // TODO: implement performLayout
  }
}


