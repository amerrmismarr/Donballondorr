import 'package:Donballondor/src/styles/colors.dart';
import 'package:flutter/material.dart';

abstract class BaseStyles{

  static double get borderRadius => 25.0;

  static double get borderWidth => 2.0;

  static double get listFieldHorizontal => 25.0;

  static double get listFieldVertical => 8.0;

  static double get animationOffset => 2.0;

  static EdgeInsets get listPadding {
    return EdgeInsets.symmetric(horizontal: listFieldHorizontal, vertical: listFieldVertical);
  }

  static List<BoxShadow> get boxShawdow{
    return [
      BoxShadow(
        color: AppColors.notshinygold.withOpacity(.5),
        offset: Offset(1.0,2.0),
        blurRadius: 2.0
      )
    ];
  }

  static List<BoxShadow> get boxShawdowPressed {
    return [
      BoxShadow(
        color: AppColors.notshinygold.withOpacity(.5),
        offset: Offset(1.0,1.0),
        blurRadius: 1.0
      )
    ];
  }
}