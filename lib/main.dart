// ignore_for_file: avoid_print, depend_on_referenced_packages, library_private_types_in_public_api

import 'package:cinemax/Shared/Service/Dio/dio_helper.dart';
import 'package:cinemax/Shared/Service/SharedPrefrences/shared_prefrences.dart';
import 'package:cinemax/Shared/bloc_observer.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/cubit.dart';
import 'package:cinemax/Widgets/Splash/splash_screen.dart';
import 'package:cinemax/generated/l10n.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefrencesSingleton.init();
  Widget startWidget = SplashScreen();
  DioHelper.initDio();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider("recaptcha-public-key"),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.deviceCheck,
  );
  uId = SharedPrefrencesSingleton.getData(key: 'uId');
  Bloc.observer = MyBlocObserver();
  print('🔥 Firebase initialized successfully!');
  print('🔥' "$uId");

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MainApp(startWidget: startWidget,));
  });
}

class MainApp extends StatefulWidget {
  final Widget startWidget;
  const MainApp({super.key, required this.startWidget});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MainAppState? state = context.findAncestorStateOfType<_MainAppState>();
    state?.setLocale(newLocale);
  }

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Locale _locale = const Locale('en'); 

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

   @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cinemaxCubit()
        ..getUserData()
        ..fetchPopularMovies()
        ..fetchUpComingMovies()
        ..getWatchlistDetails(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cinemax',
        theme: ThemeData.dark(),
        locale: _locale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
           GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: widget.startWidget,
      ),
    );
  }
}
