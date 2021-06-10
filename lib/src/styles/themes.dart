import 'package:Donballondor/src/styles/colors.dart';
import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme =  true;
  bool get isDarkMode => _isDarkTheme;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.teal,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.teal[50],
      cardColor: Colors.grey[100],
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.black, fontSize: 12),
        headline2: TextStyle(color: Colors.black, fontSize: 12),
        headline3: TextStyle(color: Colors.black, fontSize: 12),
        headline4: TextStyle(color: Colors.black, fontSize: 12),
        bodyText1: TextStyle(color: Colors.black, fontSize: 12),
        bodyText2: TextStyle(color: Colors.black, fontSize: 12),
        subtitle1: TextStyle(color: Colors.black, fontSize: 12),
        subtitle2: TextStyle(color: Colors.black, fontSize: 12),
      ),
      tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Colors.white
        )
      )
    ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColors.lightblue,
      cardColor: AppColors.lightblue,
      accentColor: Colors.red,
      backgroundColor: Colors.grey,
      scaffoldBackgroundColor: AppColors.darkblue,
      textTheme: TextTheme(
        headline1: TextStyle(color: AppColors.notshinygold, fontSize: 12),
        headline2: TextStyle(color: AppColors.notshinygold, fontSize: 12),
        headline3: TextStyle(color: AppColors.notshinygold, fontSize: 12),
        headline4: TextStyle(color: AppColors.notshinygold, fontSize: 12),
        bodyText1: TextStyle(color: AppColors.notshinygold, fontSize: 12),
        bodyText2: TextStyle(color: AppColors.notshinygold, fontSize: 12),
        subtitle1: TextStyle(color: AppColors.notshinygold, fontSize: 12),
        subtitle2: TextStyle(color: AppColors.notshinygold, fontSize: 12),
        

      ),
      tabBarTheme: TabBarTheme(
      labelColor: AppColors.darkblue,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: AppColors.notshinygold
        )
      )
    ),
    );
  }
}