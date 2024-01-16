import 'dart:async';
import 'dart:io';

import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/styles/themes.dart';
import 'package:Donballondor/src/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class GroupedCountries extends StatefulWidget {
  

  
  @override
  _GroupedCountriesState createState() => _GroupedCountriesState();
}

class _GroupedCountriesState extends State<GroupedCountries> {
  CustomTheme customTheme = CustomTheme();

  List<dynamic> list;
  StreamController streamController = StreamController();
  Stream get stream => streamController.stream;

  @override
  void initState() {
    getData();
    print(customTheme.isDarkMode);
    super.initState();
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  Future getData() async {

    var response = await http.get(
        Uri.parse(
            'https://api-football-v1.p.rapidapi.com/v2/leagues'
                ),
        headers: {
          'Accept': 'application/json',
          "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
          "x-rapidapi-key":
              "API_KEY",
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);

      list = map['api']['leagues'];
      streamController.add(list);



     
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            print(snapshot.data);
            return GroupedListView(
              elements: snapshot.data,
              groupBy: (element) => element['country'],
              groupHeaderBuilder: (element) => Center(child: Text(element['country'] ,style:
              TextStyle(color: Colors.red, fontSize: 20),)),
              indexedItemBuilder: (context, element, index) {
                return element['season'].toString() == '2020' ? Card(child: Text(element['name']
                 + ' ' + element['country'] + ' ' + element['season'].toString() +
                ' ' + element['league_id'].toString(), style: TextStyles.body),)
                : Container();
              },
              );
            
          }

          return Container(child: Center(child: Text('No Data', style: TextStyles.body,),));
        } ,
      )
      
    );
  }

  
}
