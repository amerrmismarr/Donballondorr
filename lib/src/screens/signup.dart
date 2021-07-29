import 'dart:async';

import 'package:Donballondor/src/blocs/auth_bloc.dart';
import 'package:Donballondor/src/screens/verify.dart';
import 'package:Donballondor/src/styles/base.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/widgets/alerts.dart';
import 'package:Donballondor/src/widgets/button.dart';
import 'package:Donballondor/src/widgets/social_button.dart';
import 'package:Donballondor/src/widgets/textfield.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';
class Signup extends StatefulWidget {
  
  StreamSubscription _userSubscription;
  StreamSubscription _errorMessageSubscription;
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  

   @override
  void initState() {
    final authBloc = Provider.of<AuthBloc>(context, listen: false);
    widget._userSubscription = authBloc.appUser.listen((user) {
      //if(user != null) Navigator.pushReplacementNamed(context, '/landing');
    });

    widget._errorMessageSubscription = authBloc.errorMessage.listen((errorMessage) { 
      if(errorMessage != '') {
        AppAlerts.showErrorDialog(Platform.isIOS, context, errorMessage).then((_) => authBloc.clearErrorMessage());
      }
     });
    super.initState();
  }

  @override
  void dispose() {
    widget._userSubscription.cancel();
    widget._errorMessageSubscription.cancel();
    
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {

    final authBloc = Provider.of<AuthBloc>(context);

    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: pageBody(context, authBloc)
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
          height: 30,
        ),
        Container(
          height: 100.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/PNG app.png'))),
        ),
        Center(
            child: Text(
          'Donballondor',
          style: TextStyles.body
        )),
        SizedBox(height: 20.0,),
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
            StreamBuilder<String>(
              stream: authBloc.name,
              builder: (context, snapshot) {
                return AppTextField(
                    isIOS: Platform.isIOS,
                    hintText: 'Name',
                    cupertinoIcon: IconData(0xf4c9,
                    fontFamily: CupertinoIcons.iconFont,
                    fontPackage: CupertinoIcons.iconFontPackage),
                    onChanged: authBloc.changeName, 
                    errorText: snapshot.error,
                  );
              }
            ),
              StreamBuilder<String>(
                stream: authBloc.country,
                builder: (context, snapshot) {
                  print(snapshot.data);
                  return AppButton(buttonText: snapshot.data != null ? snapshot.data : 'Select Country',
                  buttonType: ButtonType.NotShinyGold,
                          onPressed: () {
                          showCountryPicker(
                  
                  context: context,
                  //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                  exclude: <String>['KN', 'MF'],
                  //Optional. Shows phone code before the country name.
                  showPhoneCode: false,
                  onSelect: (Country country) {
                    print('Select Country: ${country.displayName}');
                    authBloc.changeCountry(country.name);
                    
                  },
                  // Optional. Sets the theme for the country list picker.
                  countryListTheme: CountryListThemeData(
                    
                    // Optional. Sets the border radius for the bottomsheet.
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                    // Optional. Styles the search field.
                    inputDecoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Start typing to search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xFF8C98A8).withOpacity(0.2),
                        ),
                      ),
                    ),));});
                }
              ),
        StreamBuilder<bool>(
            stream: authBloc.isValid,
            builder: (context, snapshot) {
              return AppButton(
                buttonText: 'Signup',
                buttonType: (snapshot.data == true)
                    ? ButtonType.NotShinyGold
                    : ButtonType.Disabled,
                    
                    onPressed: ()  {
                       authBloc.signupEmail().then((_){
                         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => VerifyScreen()));
                       });
                    }  ,
              );
            }),
        SizedBox(height: 10.0,),
        Padding(
          padding: BaseStyles.listPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            AppSocialButton(socialType: SocialType.Facebook),
            SizedBox(width: 15.0,),
            AppSocialButton(socialType: SocialType.Google),
          ],),
        ),
        Padding(
          padding: BaseStyles.listPadding,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan( 
              text: 'Already Have an Account? ',
              style: TextStyle(color: Colors.white),
              children: [
                TextSpan(
                  text: 'Login',
                  style: TextStyles.link,
                  recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.pushNamed(context, '/login')
                )
              ]
            ),
          ),
        )
      ],
    );
  }
}
