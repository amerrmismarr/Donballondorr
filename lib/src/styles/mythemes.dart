import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:flutter/material.dart';

class MyThemes{

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkblue,
    primaryColor: AppColors.lightblue,
    cardColor: AppColors.lightblue,
    textTheme: TextTheme(
      headline1: TextStyles.body,
      headline2: TextStyles.body,
      bodyText1: TextStyles.body,
      bodyText2: TextStyles.body,


    )
    
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.deepPurple,
    backgroundColor: Colors.purple,
    cardColor: Colors.purple,
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Colors.white
        )
      )
    ),
    
    textTheme: TextTheme(
      headline1: TextStyles.bodyLight,
      headline2: TextStyles.bodyLight,
      bodyText1: TextStyles.bodyLight,
      bodyText2: TextStyles.bodyLight,
      headline3: TextStyles.bodyLight,
      headline4: TextStyles.bodyLight,
      headline5: TextStyles.bodyLight,
      headline6: TextStyles.bodyLight,
      subtitle1: TextStyles.bodyLight,
      subtitle2: TextStyles.bodyLight,
      caption: TextStyles.bodyLight,
      overline: TextStyles.bodyLight,
      

    
  ));
}