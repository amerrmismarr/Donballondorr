import 'package:Donballondor/src/blocs/auth_bloc.dart';
import 'package:Donballondor/src/blocs/prediction_bloc.dart';
//import 'package:Donballondor/src/models/predictedFixture.dart';
import 'package:Donballondor/src/models/prediction.dart';
import 'package:Donballondor/src/models/user.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/styles/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:Donballondor/src/services/firestore_service.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/widgets/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';



class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}



class _LeaderBoardState extends State<LeaderBoard> {

  CustomTheme customTheme = CustomTheme();

  FireStoreService db = FireStoreService();

  List usersProfilesList = [];
  String amer;

  @override
  void initState() {
    fetchUsersList();
    super.initState();
  }

  fetchUsersList() async {
    dynamic resultant = await db.fetchUsersList();
    
    if(resultant == null) {
      print('unable to retrieve');
    } else {
      if(this.mounted){
        setState(() {
      usersProfilesList = resultant;
      usersProfilesList.sort((b,a) => a['score'].compareTo(b['score']));

      });

      }
      
      print(usersProfilesList);
    }
  }
  @override
  Widget build(BuildContext context) {
   
      return Scaffold(
        body: pageBody(context),
        appBar: AppBar(
          title: Center(child: Text('Top scorers', style: TextStyle(color: customTheme.isDarkMode == true ? AppColors.notshinygold : Colors.white),)),
          //backgroundColor: AppColors.lightblue,
        ),
      );
    
  }

  

  

  Widget pageBody(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    var appUser = Provider.of<AppUser>(context);
    //var predictions = Provider.of<List<Prediction>>(context);
    //var predictedFixtures = Provider.of<List<PredictedFixture>>(context);
    var predictionBloc = Provider.of<PredictionBloc>(context);
    FireStoreService db = FireStoreService();
    FirebaseFirestore _db = FirebaseFirestore.instance;
    
 
        return Container(
           child: ListView.builder(
             itemCount: usersProfilesList.length,
             itemBuilder: (context, index){
               return Card(
                 color: customTheme.isDarkMode == true ? 
                                              AppColors.lightblue : Colors.teal,
                 child: ListTile(
                   leading: CircleAvatar(
                     radius: 20,
                     backgroundImage: NetworkImage(usersProfilesList[index]['imagePath']),
                   ),
                   title: Text(usersProfilesList[index]['name'] + ' ' + 'from' + ' ' + usersProfilesList[index]['country'], style: TextStyle(
                     fontSize: 12,
                     color: AppColors.notshinygold),),
                   subtitle:Text(usersProfilesList[index]['email'], style: TextStyle(
                     fontSize: 10,
                     color: Colors.grey[300]),) ,
                   trailing:
                       Row(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                             index == 0 ?Icon(
                             FontAwesomeIcons.trophy,
                             color: AppColors.notshinygold,
                           ) : Container(),
                           SizedBox(width: 10,),
                           Text(usersProfilesList[index]['score'].toString() ,
                           style: TextStyle(color: customTheme.isDarkMode == true ? AppColors.notshinygold : Colors.white)
                     ,
                   ),
                         ],
                       ),
                 ),
               );
             } 
           ),
        );

  }
}

