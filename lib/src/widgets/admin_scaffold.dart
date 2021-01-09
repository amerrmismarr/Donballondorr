import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/widgets/info.dart';
import 'package:Donballondor/src/widgets/livescores.dart';
import 'package:Donballondor/src/widgets/profile.dart';
import 'package:flutter/cupertino.dart';

abstract class AdminScaffold {

  static CupertinoTabScaffold get cupertinoTabScaffold {
    return CupertinoTabScaffold (
      tabBar: _cupertinoTabBar,
      tabBuilder: (context, index){
        return _pageSelection(index);
      },
    );
  }

  static get _cupertinoTabBar {
    return CupertinoTabBar(  
      backgroundColor: AppColors.notshinygold,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.create), label: 'Products'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart), label: 'Orders'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: 'Profile'),


      ],
    );
  }

  static Widget _pageSelection(int index){
    if(index == 0){
      return LiveScores();
    }

    if(index == 1){
      return Orders();
    }

    
      return Profile();
    
  }
}