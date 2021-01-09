import 'dart:async';

import 'package:Donballondor/src/blocs/auth_bloc.dart';
import 'package:Donballondor/src/styles/tabbar.dart';
import 'package:Donballondor/src/widgets/admin_scaffold.dart';
import 'package:Donballondor/src/widgets/navbar.dart';
import 'package:Donballondor/src/widgets/info.dart';
import 'package:Donballondor/src/widgets/livescores.dart';
import 'package:Donballondor/src/widgets/profile.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class Admin extends StatefulWidget{
  StreamSubscription _userSubscription;
  @override
  _AdminState createState() => _AdminState();

  static TabBar get vendorTabBar {
    return TabBar(
      unselectedLabelColor: TabBarStyles.unselectedLabelColor,
      labelColor: TabBarStyles.labelColor,
      indicatorColor: TabBarStyles.indicatorColor,
      tabs: <Widget>[

        Tab(icon: Icon(Icons.list)),
        Tab(icon: Icon(Icons.shopping_cart)),
        Tab(icon: Icon(Icons.person)),
      ],
    );
  }
}

class _AdminState extends State<Admin> {

  @override
  void initState() {
  Future.delayed(Duration.zero, (){
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    widget._userSubscription = authBloc.appUser.listen((user) { 
      if(user == null) Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    });
  });
    super.initState();
  }

  @override
  void dispose() {
    if(widget._userSubscription != null){
    widget._userSubscription.cancel();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    if(Platform.isIOS){
      return CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return <Widget> [
              AppNavBar.cupertinoNavBar(title: 'Admin', buildContext: context)
            ];
          },
          body: AdminScaffold.cupertinoTabScaffold
      ));

    } else {
      return DefaultTabController( 
        length: 3,
        child: Scaffold( 
          body: NestedScrollView( 
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
              return <Widget> [
                AppNavBar.materialSliverBar(title: 'Admin', ),
                
              ];
              
            },
            body: TabBarView(
              children: <Widget> [
                LiveScores(),
                Orders(),
                Profile(),
            ],),
          ),
        ),
      );
    }
  }
}