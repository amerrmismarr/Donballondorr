import 'package:Donballondor/src/blocs/auth_bloc.dart';
import 'package:Donballondor/src/blocs/prediction_bloc.dart';
//import 'package:Donballondor/src/models/predictedFixture.dart';
import 'package:Donballondor/src/models/prediction.dart';
import 'package:Donballondor/src/models/user.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/styles/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:async';

import 'loading.dart';



class MatchInfo extends StatefulWidget {

  String fixtureId;

  MatchInfo({this.fixtureId});
  @override
  _MatchInfoState createState() => _MatchInfoState(fixtureId);
}

class _MatchInfoState extends State<MatchInfo> {

  String fixtureId;
  StreamController _streamController = StreamController();
  Stream get _stream => _streamController.stream;
  var loading = false;
  String changingURL;
  List<dynamic> data;

  CustomTheme customTheme = CustomTheme();

  _MatchInfoState(this.fixtureId);

  Future getJsonData(String fixtureId) async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }

    changingURL =
        'https://api-football-v1.p.rapidapi.com/v2/fixtures/id/' + fixtureId;
    //_streamController.add(changingURL);
    var response = await http.get(Uri.parse(changingURL), headers: {
      'Accept': 'application/json',
      "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
      "x-rapidapi-key": "9277c6f840mshffcaa155ce6daf9p1f43c7jsnff99eae70a7c",
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      //print(map);
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
    // TODO: implement initState
    getJsonData(fixtureId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
        body: pageBody(context),
      );
    
  }

  Widget pageBody(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: customTheme.isDarkMode == true ? AppColors.darkblue : Colors.teal,
        title: Center(child: Text('Match Info',style: TextStyles.navTitle,)),
        
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          
          if(snapshot.hasData){
            DateTime dateTime = DateTime.parse(snapshot.data[0]['event_date']);
            return  ListView(
              
                children: [
                  SizedBox(height: 20),
                  snapshot.data[0]['referee'] != null ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:  Text('Referee:' + ' ' +snapshot.data[0]['referee'], style: TextStyle(color: 
                    customTheme.isDarkMode == true ?  AppColors.notshinygold : Colors.black, fontSize: 15),),
                  ) : Container(),
                  snapshot.data[0]['referee'] != null ? Divider(color: 
                  customTheme.isDarkMode == true ?  AppColors.notshinygold : Colors.black,) : Container(),
                  snapshot.data[0]['venue'] != null ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Venue:' + ' ' + snapshot.data[0]['venue'], style: TextStyle(color:
                    customTheme.isDarkMode == true ?  AppColors.notshinygold : Colors.black, fontSize: 15),),
                  ) : Container(),
                  snapshot.data[0]['venue'] != null ? Divider(color: 
                  customTheme.isDarkMode == true ?  AppColors.notshinygold : Colors.black,) : Container(),
                  snapshot.data[0]['league']['name'] != null ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('League:' + ' ' + snapshot.data[0]['league']['name'], style: TextStyle(color: 
                    customTheme.isDarkMode == true ?  AppColors.notshinygold : Colors.black, fontSize:15),),
                  ) : Container(),
                  snapshot.data[0]['league']['name'] != null ? Divider(color: 
                  customTheme.isDarkMode == true ?  AppColors.notshinygold : Colors.black,) : Container(),
                  snapshot.data[0]['event_date'] != null ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Date:' + ' ' + DateFormat('dd/MM/yyy').format(dateTime), style: TextStyle(color: 
                    customTheme.isDarkMode == true ?  AppColors.notshinygold : Colors.black, fontSize: 15),),
                  ) : Container(),
                  snapshot.data[0]['event_date'] != null ? Divider(color: 
                  customTheme.isDarkMode == true ?  AppColors.notshinygold : Colors.black,) : Container(),
                  snapshot.data[0]['round'] != null ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Round:' + ' ' + snapshot.data[0]['round'], style: TextStyle(color:
                    customTheme.isDarkMode == true ?  AppColors.notshinygold : Colors.black, fontSize: 15),),
                  ) : Container(),
                  snapshot.data[0]['round'] != null ? Divider(color: 
                  customTheme.isDarkMode == true ?  AppColors.notshinygold : Colors.black,) : Container(),
                  snapshot.data[0]['status'] != null ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Status:' + ' ' + snapshot.data[0]['status'], style: TextStyle(color: 
                    customTheme.isDarkMode == true ?  AppColors.notshinygold : Colors.black, fontSize: 15),),
                  ) : Container(),
                  snapshot.data[0]['status'] != null ? Divider(color: 
                  customTheme.isDarkMode == true ?  AppColors.notshinygold : Colors.black,) : Container(),
                  snapshot.data[0]['score']['halftime'] != null ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Halftime score:' + ' ' + snapshot.data[0]['score']['halftime'], style: TextStyle(color: 
                    customTheme.isDarkMode == true ?  AppColors.notshinygold : Colors.black, fontSize: 15),),
                  ) : Container(),
                  snapshot.data[0]['score']['halftime'] != null ? Divider(color: 
                  customTheme.isDarkMode == true ?  AppColors.notshinygold : Colors.black,) : Container(),
                  snapshot.data[0]['score']['fulltime'] != null ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Fulltime score:' + ' ' + snapshot.data[0]['score']['fulltime'], style: TextStyle(color: 
                    customTheme.isDarkMode == true ?  AppColors.notshinygold : Colors.black, fontSize: 15),),
                  ) : Container(),

                ],
              );
            
            
          } else {
            return Container(child: Center(child: Container(child: Loading())));
          }
          
        }
      ),
    );
      

    
    
    
  }
}

