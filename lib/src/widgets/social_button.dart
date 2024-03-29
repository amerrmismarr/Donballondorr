import 'package:Donballondor/src/styles/base.dart';
import 'package:Donballondor/src/styles/buttons.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppSocialButton extends StatelessWidget {
  final SocialType socialType;
  final VoidCallback onPressed; 

  AppSocialButton({@required this.socialType, this.onPressed});
  @override
  Widget build(BuildContext context) {
    Color buttonColor;
    Color iconColor;
    IconData icon;

    switch (socialType) {
      case SocialType.Facebook:
        iconColor = Colors.white;
        buttonColor = AppColors.facebook;
        icon = FontAwesomeIcons.facebookF;
        break;
      case SocialType.Google:
        iconColor = Colors.white;
        buttonColor = AppColors.google;
        icon = FontAwesomeIcons.google;
        break;
      default:
        iconColor = Colors.white;
        buttonColor = AppColors.facebook;
        icon = FontAwesomeIcons.facebookF;
    }
    return GestureDetector(
          onTap: onPressed,
          child: Container(
            height: ButtonStyles.buttonHeight,
            width: ButtonStyles.buttonHeight,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
              boxShadow: BaseStyles.boxShawdow,
            ),
            child: Icon(
              icon,
              color: iconColor,
            )),
    );
    
  }
}

enum SocialType { Facebook, Google }
