import 'dart:async';

import 'package:Donballondor/src/blocs/auth_bloc.dart';
import 'package:Donballondor/src/styles/base.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/widgets/alerts.dart';
import 'package:Donballondor/src/widgets/button.dart';
import 'package:Donballondor/src/widgets/social_button.dart';
import 'package:Donballondor/src/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class LoginToProfile extends StatefulWidget {
  StreamSubscription _userSubscription;
  StreamSubscription _errorMessageSubscription;
  @override
  _LoginToProfileState createState() => _LoginToProfileState();
}

class _LoginToProfileState extends State<LoginToProfile> {

  @override
  void initState() {
    final authBloc = Provider.of<AuthBloc>(context, listen: false);
    widget._userSubscription = authBloc.appUser.listen((user) {
      //if(user != null) Navigator.pushReplacementNamed(context, '/profile');
    });


    widget._errorMessageSubscription = authBloc.errorMessage.listen((errorMessage) { 
      if(errorMessage != '') {
        AppAlerts.showErrorDialog(Platform.isIOS, context, errorMessage).then((_) => authBloc.clearErrorMessage());
      }
     });
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    
    
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: pageBody(context, authBloc),
      );
    } else {
      return Scaffold(
        body: pageBody(context, authBloc),
      );
    }
  }

  Widget pageBody(BuildContext context, AuthBloc authBloc) {
    return ListView(
      children: [
        SizedBox(
          height: 120,
        ),
        Container(
          height: 100.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/PNG app.png'))),
        ),
        Center(child: Text('Donballondor', style: TextStyles.body)),
        SizedBox(
          height: 20.0,
        ),
        StreamBuilder<String>(
            stream: authBloc.email,
            builder: (context, snapshot) {
              return AppTextField(
                isIOS: Platform.isIOS,
                hintText: 'Email',
                cupertinoIcon: CupertinoIcons.mail_solid,
                materialIcon: Icons.email,
                textInputType: TextInputType.emailAddress,
                errorText: snapshot.error,
                onChanged: authBloc.changeEmail,
              );
            }),
        StreamBuilder<String>(
            stream: authBloc.password,
            builder: (context, snapshot) {
              return AppTextField(
                isIOS: Platform.isIOS,
                hintText: 'Password',
                cupertinoIcon: IconData(0xf4c9,
                    fontFamily: CupertinoIcons.iconFont,
                    fontPackage: CupertinoIcons.iconFontPackage),
                materialIcon: Icons.lock,
                obscureText: true,
                errorText: snapshot.error,
                onChanged: authBloc.changePassword,
              );
            }),
        StreamBuilder<bool>(
            stream: authBloc.isValid,
            builder: (context, snapshot) {
              return AppButton(
                buttonText: 'Login',
                buttonType: (snapshot.data == true)
                    ? ButtonType.NotShinyGold
                    : ButtonType.Disabled,
                    onPressed: authBloc.loginEmail,
              );
            }),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: BaseStyles.listPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSocialButton(socialType: SocialType.Facebook),
              SizedBox(
                width: 15.0,
              ),
              AppSocialButton(socialType: SocialType.Google),
            ],
          ),
        ),
        Padding(
          padding: BaseStyles.listPadding,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'New Here? ',
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                      text: 'Signup',
                      style: TextStyles.link,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushNamed(context, '/login'))
                ]),
          ),
        )
      ],
    );
  }
}
