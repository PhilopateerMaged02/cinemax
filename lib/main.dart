// ignore_for_file: avoid_print

import 'package:cinemax/Shared/Service/Dio/dio_helper.dart';
import 'package:cinemax/Shared/Service/SharedPrefrences/shared_prefrences.dart';
import 'package:cinemax/Shared/bloc_observer.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/cubit.dart';
import 'package:cinemax/Widgets/Splash/splash_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    runApp(MainApp(startWidget: startWidget));
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cinemaxCubit()
        ..getUserData()
        ..fetchPopularMovies()
        ..fetchUpComingMovies()
        ..getWatchlistDetails(),
      child: MaterialApp(
        home: SplashScreen(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
