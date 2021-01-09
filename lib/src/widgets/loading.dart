import 'package:Donballondor/src/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Shimmer.fromColors(
        baseColor: AppColors.lightblue,
        highlightColor: AppColors.notshinygold,
        child: Image.asset("assets/images/PNG app.png"),
        period: Duration(seconds: 3),
      ),
    );
  }



}
