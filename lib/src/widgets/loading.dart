import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  CustomTheme customTheme = CustomTheme();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Shimmer.fromColors(
        baseColor: customTheme.isDarkMode == true ? AppColors.lightblue : Colors.white,
        highlightColor: AppColors.notshinygold,
        child: Image.asset("assets/PNG app.png"),
        period: Duration(seconds: 3),
      ),
    );
  }



}
