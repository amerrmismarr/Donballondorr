import 'package:Donballondor/src/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class TextStyles {
  static TextStyle get title {
    return GoogleFonts.poppins(
        textStyle: TextStyle(
            color: AppColors.notshinygold,
            fontWeight: FontWeight.bold,
            fontSize: 40.0));
  }

  static TextStyle get subTitle {
    return GoogleFonts.economica(
        textStyle: TextStyle(
            color: AppColors.notshinygold,
            fontWeight: FontWeight.bold,
            fontSize: 30.0));
  }

  static TextStyle get navTitle {
    return GoogleFonts.poppins(
        textStyle: TextStyle(
            color: AppColors.notshinygold, fontWeight: FontWeight.bold));
  }

  static TextStyle get materialNavTitle {
    return GoogleFonts.poppins(
        textStyle: TextStyle(color: AppColors.notshinygold, fontWeight: FontWeight.bold));
  }

  static TextStyle get body {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColors.notshinygold, fontSize: 16.0));
  }

  static TextStyle get suggestion {
    return GoogleFonts.roboto(
        textStyle:
            TextStyle(color: AppColors.notshinygoldlight, fontSize: 14.0));
  }

  static TextStyle get error {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: Colors.red, fontSize: 12.0));
  }

  static TextStyle get buttonTextDark {
    return GoogleFonts.roboto(
        textStyle: TextStyle(
            color: AppColors.darkblue,
            fontSize: 17.0,
            fontWeight: FontWeight.bold));
  }

  static TextStyle get buttonTextLight {
    return GoogleFonts.roboto(
        textStyle: TextStyle(
            color: AppColors.notshinygold,
            fontSize: 17.0,
            fontWeight: FontWeight.bold));
  }

  static TextStyle get link {
    return GoogleFonts.roboto(
        textStyle: TextStyle(
            color: AppColors.notshinygold,
            fontSize: 16.0,
            fontWeight: FontWeight.bold));
  }
}
