import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/styles/themes.dart';
import 'package:Donballondor/src/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

abstract class AppNavBar {
  
  static CupertinoSliverNavigationBar cupertinoNavBar(
      {String title, BuildContext buildContext}) {
    return CupertinoSliverNavigationBar(
      largeTitle: Text(title, style: TextStyles.navTitle),
      backgroundColor: Colors.transparent,
      border: null,
    );
  }

  static SliverAppBar materialSliverBar(
      {@required String title, TabBar tabBar}) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: true,
      title: Center(
          child: Text(
        title,
        style: TextStyles.materialNavTitle,
      )),
      backgroundColor: AppColors.lightblue,
      bottom: tabBar,
    );
  }

  static SliverAppBar materialStatisticsSliverAppBar(
      {String homeTeamName,
      String homeTeamScore,
      String awayTeamName,
      String awayTeamScore,
      TabBar tabBar}) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: true,
      backgroundColor: AppColors.notshinygold,
      bottom: tabBar,
      expandedHeight: 200.0,
      

      
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: SizedBox(
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
              children: <Widget>[
               SizedBox(width: 30,),

                Container(
                  height: 80,
                  width: 80,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Text(
                        homeTeamName,
                        style: TextStyle(color: AppColors.notshinygold,fontSize: 10),
                      ),
                      homeTeamScore != 'null' ?Text(
                    homeTeamScore.toString(),
                    style: TextStyles.body,
                  ) : Text(
                        ' ',
                        style: TextStyles.body,
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 30,),
                
                
                Container(
                  height: 80,
                  width: 80,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Text(
                    awayTeamName,
                    style: TextStyle(color: AppColors.notshinygold,fontSize: 10),
                  ),
                      awayTeamScore == 'null' ? Text(
                        ' ',
                        style: TextStyles.body,
                      ) :Text(
                        awayTeamScore.toString(),
                        style: TextStyles.body,
                      ),
                      
                    ],
                  ),
                ),

                

              ],

      ),
              
              

            ],
          ),
        ),
        background: Image.asset('assets/stadium.jpg', fit: BoxFit.cover),
      ),
    );
  }

  static Material bottomNavBar({@required TabBar tabbar}) {
    CustomTheme customTheme = CustomTheme();
    return Material(color: 
    customTheme.isDarkMode == true ?
    AppColors.notshinygold : Colors.teal, child: tabbar);
  }
}
