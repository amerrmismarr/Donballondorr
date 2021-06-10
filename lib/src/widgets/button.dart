import 'package:Donballondor/src/styles/base.dart';
import 'package:Donballondor/src/styles/buttons.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/styles/themes.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final String buttonText;
  final ButtonType buttonType;
  final void Function() onPressed;

  AppButton({
    @required this.buttonText,
    this.buttonType,
    this.onPressed
    
  });

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {

  bool pressed = false;
  CustomTheme customTheme = CustomTheme();


  @override
  Widget build(BuildContext context) {

    TextStyle fontStyle;
    Color buttonColor;
    switch (widget.buttonType){
      case ButtonType.DarkBlue:
      fontStyle = TextStyles.buttonTextLight;
      buttonColor = AppColors.darkblue;
      break;
      case ButtonType.Disabled:
      fontStyle = TextStyles.buttonTextLight;
      buttonColor = customTheme.isDarkMode == true ? AppColors.lightblue : Colors.teal[200];
      break;
      case ButtonType.NotShinyGold:
      fontStyle = TextStyles.buttonTextDark;
      buttonColor = AppColors.notshinygold;
      break;
      default:
      fontStyle = TextStyles.buttonTextDark;
      buttonColor = AppColors.notshinygold;

    }
    return AnimatedContainer(
      padding: EdgeInsets.only(
        top:(pressed) ? BaseStyles.listFieldVertical + BaseStyles.animationOffset :BaseStyles.listFieldVertical,
        bottom:(pressed) ? BaseStyles.listFieldVertical - BaseStyles.animationOffset : BaseStyles.listFieldVertical,
        left: BaseStyles.listFieldHorizontal,
        right: BaseStyles.listFieldHorizontal

      ),
      child: GestureDetector(
              child: Container(
          height: ButtonStyles.buttonHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
            boxShadow: pressed ? BaseStyles.boxShawdowPressed : BaseStyles.boxShawdow,
          ),
          child: Center(
            child: Text(
              widget.buttonText,
              style: fontStyle,
            ),
          ),
        ),
        onTapDown: (details){
          setState(() {
            if(widget.buttonType != ButtonType.Disabled) pressed = !pressed;
          });
        },
        onTapUp: (details){
          setState(() {
            if(widget.buttonType != ButtonType.Disabled) pressed = !pressed;
          });
        },
        onTap: (){
          if(widget.buttonType != ButtonType.Disabled){
            widget.onPressed();
          }
        },
      ),
      duration: Duration(microseconds: 20),
    );
  }
}

enum ButtonType{ NotShinyGold, Disabled, DarkBlue}

