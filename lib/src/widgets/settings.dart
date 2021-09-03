import 'dart:async';
import 'dart:io';

import 'package:Donballondor/src/blocs/auth_bloc.dart';
import 'package:Donballondor/src/models/user.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/styles/themes.dart';
import 'package:Donballondor/src/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  CustomTheme customTheme = CustomTheme();
  var url = 'https://instagram.com/donballondor?utm_medium=copy_link';

  Future<bool> _getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeMode = prefs.getBool('themeMode');
    if (themeMode == null) {
      return true;
    }

    return themeMode;
  }

  Future<void> _resetTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('themeMode', true);
  }

  @override
  void initState() {
    print(customTheme.isDarkMode);
    //setThemeMode();
    super.initState();
  }

  Future<void> shareOnInstagram(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          //universalLinksOnly: true,
          forceSafariVC: true,
          forceWebView: false,
          headers: <String, String>{'header_key': 'header_value'});
    } else {
      throw 'There was a problem with $url';
    }
  }

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: customTheme.isDarkMode == true
                ? AppColors.lightblue
                : Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
                child: Column(
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Frequently asked questions',
                      style: TextStyle(
                        color: AppColors.notshinygold,
                        fontSize: 20,
                      )),
                )),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'How can I predict a score?',
                    style: TextStyle(color: AppColors.notshinygold),
                  ),
                )),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Simply tap on the match that you want to predict and then click on the Predict button, you will see a pop up where you can enter your predictions for both teams submit them.',
                    style: TextStyle(color: AppColors.notshinygold),
                  ),
                )),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: customTheme.isDarkMode == true
                        ? AppColors.notshinygold
                        : Colors.white,
                  ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'How is the score calculated?',
                    style: TextStyle(color: AppColors.notshinygold),
                  ),
                )),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'If you predict the exact score you will get 50 points and if you predict only the outcome (who won or lost the match) you will get 25 points. However, if you predict the score wrongly you will lose 25 points.',
                    style: TextStyle(color: AppColors.notshinygold),
                  ),
                )),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: customTheme.isDarkMode == true
                        ? AppColors.notshinygold
                        : Colors.white,
                  ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'What will I get if I win?',
                    style: TextStyle(color: AppColors.notshinygold),
                  ),
                )),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'The winner with the highest score at the end of the month will win up to 200 USD',
                    style: TextStyle(color: AppColors.notshinygold),
                  ),
                )),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: customTheme.isDarkMode == true
                        ? AppColors.notshinygold
                        : Colors.white,
                  ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'How will I get the prize?',
                    style: TextStyle(color: AppColors.notshinygold),
                  ),
                )),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'We will contact you via email in order to get your bank or paypal data so that we can transfer the money to your account.',
                    style: TextStyle(color: AppColors.notshinygold),
                  ),
                )),
              ],
            )),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appUser = Provider.of<AppUser>(context);
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 100,
          ),
          Container(
            height: 100.0,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage('assets/PNG app.png'))),
          ),
          Center(child: Text('Donballondor', style: TextStyles.body)),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                'Switch between dark and light mode',
                style: TextStyle(
                    color: customTheme.isDarkMode == true
                        ? AppColors.notshinygold
                        : Colors.black,
                    fontSize: 15),
              )),
            ),
          ),
          IconButton(
            color: customTheme.isDarkMode == true
                ? AppColors.notshinygold
                : Colors.black,
            icon: const Icon(Icons.brightness_4_rounded),
            onPressed: () {
              currentTheme.toggleTheme();
            },
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(8.0)),
                  backgroundColor: MaterialStateProperty.all(
                      customTheme.isDarkMode == true
                          ? AppColors.lightblue
                          : Colors.teal),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)))),
              child: Text(
                'FAQS',
                style: TextStyle(color: AppColors.notshinygold, fontSize: 30),
              ),
              onPressed: () {
                createAlertDialog(context);
              },
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                'Follow us on instagram',
                style: TextStyle(
                    color: customTheme.isDarkMode == true
                        ? AppColors.notshinygold
                        : Colors.black,
                    fontSize: 15),
              )),
            ),
          ),
          IconButton(
            color: Colors.pink,
            iconSize: 50,
            icon: FaIcon(FontAwesomeIcons.instagram),
            onPressed: () {
              shareOnInstagram(url);
            },
          ),
          SizedBox(
            height: 50.0,
          ),
          appUser != null
              ? Container(
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(8.0)),
                        backgroundColor: MaterialStateProperty.all(
                            customTheme.isDarkMode == true
                                ? AppColors.lightblue
                                : Colors.teal),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(18.0)))),
                    child: Text(
                      'Log out',
                      style: TextStyle(
                          color: AppColors.notshinygold, fontSize: 30),
                    ),
                    onPressed: () {
                      authBloc.logout();
                      Navigator.pushReplacementNamed(context, '/landing');
                    },
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
