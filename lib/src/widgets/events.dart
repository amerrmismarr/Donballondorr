import 'dart:async';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Events extends StatefulWidget {
  String fixtureId;

  Events({this.fixtureId});

  @override
  _EventsState createState() => _EventsState(fixtureId);
}

class _EventsState extends State<Events> {
  String fixtureId;

  _EventsState(this.fixtureId);

  var loading = false;
  StreamController _streamController = StreamController();
  Stream get _stream => _streamController.stream;

  List<dynamic> data;

  String changingURL;

  int premierLeagueId = 565;

  Future getJsonData(String fixtureId) async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }

    changingURL =
        'https://api-football-v1.p.rapidapi.com/v2/events/' + fixtureId;
    //_streamController.add(changingURL);
    var response = await http.get(Uri.encodeFull(changingURL), headers: {
      'Accept': 'application/json',
      "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
      "x-rapidapi-key": "9277c6f840mshffcaa155ce6daf9p1f43c7jsnff99eae70a7c",
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      //print(map);
      data = map['api']['events'];

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
    getJsonData(fixtureId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasData &&  snapshot.data.length != 0) {
            print(snapshot.data);
            return Column(
              children: <Widget>[
                Container(
                  color: Color.fromRGBO(41, 48, 67, 1),
                  padding: EdgeInsets.all(10.0),
                  height: 50.0,
                  child: Center(
                      child: Text(
                    'EVENTS',
                    style: TextStyle(
                        color: Color.fromRGBO(224, 176, 92, 1),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                
                Expanded(
                  child: Container(
                      color: Color.fromRGBO(13, 18, 38, 1),
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              Container(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 2,
                                        height: 5.0,
                                        color: index == 0
                                            ? Color.fromRGBO(13, 18, 38, 1)
                                            : Color.fromRGBO(222, 177, 92, 1),
                                      ),
                                      snapshot.data[index]['type'] == 'Goal'
                                          ? Row(
                                              children: [
                                                Text(
                                                  snapshot.data[index]['player']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color.fromRGBO(
                                                          222, 177, 92, 1)),
                                                ),
                                                Container(
                                                  height: 30.0,
                                                  width: 30.0,
                                                  padding: EdgeInsets.all(5),
                                                  margin: EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                    image: AssetImage(
                                                      'assets/PNG app.png',
                                                    ),
                                                  )),
                                                ),
                                                Text(
                                                  snapshot.data[index]
                                                              ['elapsed']
                                                          .toString() +
                                                      '`',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color.fromRGBO(
                                                          222, 177, 92, 1)),
                                                ),
                                              ],
                                            )
                                          : snapshot.data[index]['detail'] ==
                                                  'Yellow Card'
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      snapshot.data[index]
                                                              ['player']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Color.fromRGBO(
                                                              222, 177, 92, 1)),
                                                    ),
                                                    Container(
                                                      height: 30.0,
                                                      width: 30.0,
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      margin: EdgeInsets.only(
                                                          left: 5, right: 5),
                                                      decoration: BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                        image: AssetImage(
                                                          'assets/yellow card.png',
                                                        ),
                                                      )),
                                                    ),
                                                    Text(
                                                      snapshot.data[index]
                                                                  ['elapsed']
                                                              .toString() +
                                                          '`',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Color.fromRGBO(
                                                              222, 177, 92, 1)),
                                                    ),
                                                  ],
                                                )
                                              : snapshot.data[index]
                                                          ['detail'] ==
                                                      'Red Card'
                                                  ? Row(
                                                      children: [
                                                        Text(
                                                          snapshot.data[index][
                                                                      'elapsed']
                                                                  .toString() +
                                                              '`',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      222,
                                                                      177,
                                                                      92,
                                                                      1)),
                                                        ),
                                                        Container(
                                                          height: 30.0,
                                                          width: 30.0,
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  right: 5),
                                                          decoration:
                                                              BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                            image: AssetImage(
                                                              'assets/red card.png',
                                                            ),
                                                          )),
                                                        ),
                                                        Text(
                                                          snapshot.data[index]
                                                                  ['player']
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      222,
                                                                      177,
                                                                      92,
                                                                      1)),
                                                        ),
                                                      ],
                                                    )
                                                  : snapshot.data[index]
                                                              ['type'] ==
                                                          'subst'
                                                      ? Row(
                                                          children: [
                                                            Container(
                                                              height: 30.0,
                                                              width: 30.0,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                image:
                                                                    AssetImage(
                                                                  'assets/Sub.png',
                                                                ),
                                                              )),
                                                            ),
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  snapshot.data[
                                                                          index]
                                                                          [
                                                                          'player']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Color.fromRGBO(
                                                                          222,
                                                                          177,
                                                                          92,
                                                                          1),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  snapshot.data[
                                                                          index]
                                                                          [
                                                                          'assist']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      color: Color.fromRGBO(
                                                                          222,
                                                                          177,
                                                                          92,
                                                                          1)),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      : Container(
                                                          height: 30.0,
                                                          width: 30.0,
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  right: 5),
                                                          decoration:
                                                              BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                            image: AssetImage(
                                                              'assets/whistle.png',
                                                            ),
                                                          )),
                                                        ),
                                      Container(
                                        width: 2,
                                        height: 50,
                                        color: index == snapshot.data.length - 1
                                            ? Color.fromRGBO(13, 18, 38, 1)
                                            : Color.fromRGBO(222, 177, 92, 1),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                            ],
                          );
                        },
                      )),
                ),
              ],
            );
          } else {
            return Container(child: Center(child: Container(child: Loading())));
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
