import 'package:cinemax/Shared/components/navigation.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Widgets/AuthunticationWidgets/LoginSignupWidget/login_signup.dart';
import 'package:cinemax/Widgets/Layout/cinemaxLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    executeSpalshScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        "assets/images/Logo.svg", // Correct way to load an SVG
        width: 200, // Adjust size as needed
        height: 200,
      ),
    );
  }

  void executeSpalshScreen(context) {
    //bool key = SharedPrefrencesSingleton.getBool(keyIsOnBoardingSeen);
    Future.delayed(const Duration(seconds: 3), () {
      // if (key != false && uId == null) {
      //   Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => LoginScreen()),
      //     (route) => false,
      //   );
      // } else if (key != false && uId != null) {
      //   navigateToandKill(context, FruitappLayout());
      // } else if (key == false && uId == null) {
      //   Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => OnboardingScreen()),
      //     (route) => false,
      //   );
      // }
      if (uId == null) {
        navigateToandKill(context, LoginSignup());
      } else {
        navigateToandKill(context, Cinemaxlayout());
      }
    });
  }
}
