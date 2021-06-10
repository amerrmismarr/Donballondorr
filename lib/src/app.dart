import 'package:Donballondor/src/blocs/auth_bloc.dart';
import 'package:Donballondor/src/blocs/prediction_bloc.dart';
import 'package:Donballondor/src/routes.dart';
import 'package:Donballondor/src/screens/landing.dart';
import 'package:Donballondor/src/screens/login.dart';
import 'package:Donballondor/src/services/api_live_service.dart';
import 'package:Donballondor/src/services/api_service.dart';
import 'package:Donballondor/src/styles/colors.dart';
import 'package:Donballondor/src/styles/mythemes.dart';
import 'package:Donballondor/src/styles/text.dart';
import 'package:Donballondor/src/styles/themes.dart';
import 'package:Donballondor/src/widgets/loading.dart';
import 'package:Donballondor/src/widgets/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';

final  authBloc = AuthBloc();
final apiService = ApiService();
final apiLiveService = ApiLiveService();
final profile = Profile();
final predictionBloc = PredictionBloc();

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    currentTheme.addListener(() {
      setState(() {
        
      });
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        Provider(create: (context) => authBloc,),
        Provider(create: (context) => apiService,),
        Provider(create: (context) => apiLiveService,),
        Provider(create: (context) => profile,),
        Provider(create: (context) => predictionBloc,),
        //StreamProvider(create: (context) => predictionBloc.predictionByUserId(authBloc.userId),),
        StreamProvider(create: (context) => authBloc.appUser),
        StreamProvider(create: (context) => apiService.fixtures,),
        FutureProvider(create: (context) => authBloc.isLoggedIn(),)

      ],
      child: PlatformApp());
  }

  @override
  void dispose() {
    authBloc.dispose();
    predictionBloc.dispose();
    super.dispose();
  }

  
}

class PlatformApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var isLoggedIn = Provider.of<bool>(context);

    if (Platform.isIOS) {
      return CupertinoApp(
        home: (isLoggedIn==null) ? loadingScreen(true) : (isLoggedIn == true) ? Landing() : Login() ,
        onGenerateRoute: Routes.cupertinoRoutes,
        theme: CupertinoThemeData(
          primaryColor: AppColors.darkblue,
        //scaffoldBackgroundColor: Color.fromRGBO(12, 17, 37, 1)
        textTheme: CupertinoTextThemeData(
          tabLabelTextStyle: TextStyles.suggestion
        )
        ),
      );
    } else {
      return MaterialApp(
        home: Landing()/*(isLoggedIn==null) ? loadingScreen(false) : (isLoggedIn == true) ? Landing() : Login()*/ ,
        onGenerateRoute: Routes.materialRoutes,
        themeMode: currentTheme.currentTheme,
        darkTheme: CustomTheme.darkTheme,
        theme: CustomTheme.lightTheme,
        );
      
    }
  }

  Widget loadingScreen(bool isIOS){
    return (isIOS) ? 
    CupertinoPageScaffold(child: Center(child: CupertinoActivityIndicator(),),)
    : Scaffold(body: Center(child: Loading(),),);
  }
}
