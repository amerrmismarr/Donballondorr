import 'dart:async';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/styles/themes.dart';
import 'package:Donballondor/src/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
// ignore: unused_import
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Lineups extends StatefulWidget {
  String fixtureId;
  String homeTeamName;
  String awayTeamName;
  String homeTeamLogo;
  String awayTeamLogo;

  Lineups(
      {this.fixtureId,
      this.homeTeamName,
      this.awayTeamName,
      this.homeTeamLogo,
      this.awayTeamLogo});

  @override
  _LineupsState createState() => _LineupsState(
      fixtureId, homeTeamName, awayTeamName, homeTeamLogo, awayTeamLogo);
}

class _LineupsState extends State<Lineups> {
  String fixtureId;
  String homeTeamName;
  String awayTeamName;
  String homeTeamLogo;
  String awayTeamLogo;

  _LineupsState(this.fixtureId, this.homeTeamName, this.awayTeamName,
      this.homeTeamLogo, this.awayTeamLogo);

  var loading = false;
  StreamController _streamController = StreamController();
  Stream get _stream => _streamController.stream;

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

  Future getJsonData(String fixtureId) async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }

    changingURL =
        'https://api-football-v1.p.rapidapi.com/v2/lineups/' + fixtureId;
    //_streamController.add(changingURL);
    var response = await http.get(Uri.parse(changingURL), headers: {
      'Accept': 'application/json',
      "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
      "x-rapidapi-key": "API_KEY",
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      //print(map);
      //data = map['api']['lineUps']['']['startXI'];

      //data4 = data2 + data3;

      _streamController.add(map);

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
    getJsonData(fixtureId);
    print(fixtureId);
    print(homeTeamName);
    print(awayTeamName);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data['api']['results'] != 0 &&
              snapshot.data.length != 0) {
            //print(snapshot.data);
            return Container(
              color: customTheme.isDarkMode == true ? AppColors.darkblue : Colors.teal[100],
              child: CustomScrollView(
                slivers: <Widget>[
                  CustomSliver(
                      child: Container(
                    color: customTheme.isDarkMode == true ? AppColors.darkblue : Colors.teal,
                    padding: EdgeInsets.all(10.0),
                    height: 50.0,
                    child: Center(
                        child: Text(
                      'LINE UPS',
                      style: TextStyle(
                          color: Color.fromRGBO(224, 176, 92, 1),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    )),
                  )),
                  
                  CustomSliver(
                    child: SizedBox(
                      height: 20.0,
                    ),
                  ),
                  CustomSliver(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        height: 50.0,
                        width: 200.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 20.0,
                              width: 20.0,
                              child: Image.network(homeTeamLogo),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            homeTeamName != null ? Text(
                              homeTeamName,
                              style:customTheme.isDarkMode == true ? TextStyles.navTitle : TextStyles.navTitleLight
                            ) : Container(),

                            snapshot.data['api']['lineUps'][homeTeamName]['coach'] != null ? 
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Coach:' + ' ' +
                                snapshot.data['api']['lineUps'][homeTeamName]['coach'],
                                style: customTheme.isDarkMode == true ? TextStyles.body : TextStyles.bodyLight),
                            ) : Container()
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int i) {
                      return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          borderOnForeground: true,
                          shadowColor: Color.fromRGBO(224, 176, 92, 1),
                          margin: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 0.0),
                          color: customTheme.isDarkMode == true ? AppColors.lightblue : Colors.teal,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  5.0, 10.0, 5.0, 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  snapshot.data['api']['lineUps'][homeTeamName]['startXI'][i]['player'] != null 
                                  ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.data['api']['lineUps']
                                          [homeTeamName]['startXI'][i]['player'],
                                      style: TextStyle(
                                        color: Color.fromRGBO(222, 177, 92, 1),
                                      ),
                                    ),
                                  ) : Container(),
                                  snapshot.data['api']['lineUps']
                                          [homeTeamName]['startXI'][i]['pos'] != null ?Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                      snapshot.data['api']['lineUps']
                                            [homeTeamName]['startXI'][i]['pos'] == 'G' ?
                                      'GK' :
                                      snapshot.data['api']['lineUps']
                                            [homeTeamName]['startXI'][i]['pos'],
                                      style: TextStyle(
                                        color: Color.fromRGBO(222, 177, 92, 1),
                                      )),
                                          ) : Container(),
                                ],
                              )));
                    },
                        childCount: snapshot
                            .data['api']['lineUps'][homeTeamName]['startXI']
                            .length),
                  ),
                  CustomSliver(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        height: 50.0,
                        width: 200.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 20.0,
                              width: 20.0,
                              child: Image.network(awayTeamLogo),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              awayTeamName,
                              style: customTheme.isDarkMode == true ? TextStyles.navTitle : TextStyles.navTitleLight
                            ),

                            snapshot.data['api']['lineUps'][awayTeamName]['coach'] != null ?
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Coach:' + ' ' +
                                snapshot.data['api']['lineUps'][awayTeamName]['coach'],
                                style: customTheme.isDarkMode == true ? TextStyles.body : TextStyles.bodyLight),
                            ) : Container()
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int i) {
                      return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          borderOnForeground: true,
                          shadowColor: Color.fromRGBO(224, 176, 92, 1),
                          margin: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 0.0),
                          color: customTheme.isDarkMode == true ? AppColors.lightblue : Colors.teal,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  5.0, 10.0, 5.0, 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                   snapshot.data['api']['lineUps']
                                        [awayTeamName]['startXI'][i]['player'] != null ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                    snapshot.data['api']['lineUps']
                                              [awayTeamName]['startXI'][i]['player'],
                                    style: TextStyle(
                                      color: Color.fromRGBO(222, 177, 92, 1),
                                    ),
                                  ),
                                            ],
                                          ),
                                        ) : Container(),
                                  snapshot.data['api']['lineUps']
                                          [awayTeamName]['startXI'][i]['pos'] != null ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                      snapshot.data['api']['lineUps']
                                            [awayTeamName]['startXI'][i]['pos'] == 'G' ?
                                      'GK' :
                                      snapshot.data['api']['lineUps']
                                            [awayTeamName]['startXI'][i]['pos'],
                                      style: TextStyle(
                                        color: Color.fromRGBO(222, 177, 92, 1),
                                      )),
                                          ) : Container(),
                                ],
                              )));
                    },
                        childCount: snapshot
                            .data['api']['lineUps'][awayTeamName]['startXI']
                            .length),
                  ),
                ],
              ),
            );
          } else {
            return Container(child: Center(child:
             Padding(
               padding: const EdgeInsets.all(80.0),
               child: Loading(),
             )));
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
