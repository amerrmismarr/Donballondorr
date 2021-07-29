import 'dart:async';
import 'dart:io';

import 'package:Donballondor/src/blocs/auth_bloc.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/styles/themes.dart';
import 'package:Donballondor/src/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  

  
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  CustomTheme customTheme = CustomTheme();

  @override
  void initState() {
    print(customTheme.isDarkMode);
    super.initState();
  }

  @override
  void dispose() {
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Switch between dark and light mode'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_4_rounded),
            onPressed: () {
              currentTheme.toggleTheme();
            },
          )
        ],
      ),

      body: ListView(
        children: [
          SizedBox(
          height: 100,
        ),
        Container(
          height: 100.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/PNG app.png'))),
        ),
        Center(
            child: Text(
          'Donballondor',
          style: TextStyles.body
        )),
        SizedBox(height: 20.0,),
        AppTextField(
                isIOS: Platform.isIOS,
                hintText: 'Name',
                cupertinoIcon: IconData(0xf4c9,
                fontFamily: CupertinoIcons.iconFont,
                fontPackage: CupertinoIcons.iconFontPackage), 
              ),
        AppTextField(
                isIOS: Platform.isIOS,
                hintText: 'Country',
                cupertinoIcon: IconData(0xf4c9,
                fontFamily: CupertinoIcons.iconFont,
                fontPackage: CupertinoIcons.iconFontPackage), 
              ),

        IconButton(
              icon: Icon(Icons.logout),
              color: AppColors.notshinygold,
              onPressed:(){
              authBloc.logout();
              Navigator.pushReplacementNamed(context, '/landing');
            } , )
      
        ],
              
      ),
      
    );
  }

  
}