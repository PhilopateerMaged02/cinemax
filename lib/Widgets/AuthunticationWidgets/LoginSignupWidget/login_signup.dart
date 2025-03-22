import 'package:cinemax/Shared/components.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Widgets/AuthunticationWidgets/LoginWidget/login_screen.dart';
import 'package:cinemax/Widgets/AuthunticationWidgets/SignupWidget/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginSignup extends StatelessWidget {
  const LoginSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text('sadasdsd'),
          ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/images/Logo.svg", // Correct way to load an SVG
                width: 150, // Adjust size as needed
                height: 150,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Enter your registered",
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                "Email Address to Sign Up",
                style: TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: buildDefaultButton(
                    color: primaryColor,
                    text: "Sign Up",
                    onPressed: () {
                      navigateTo(context, SignupScreen());
                    },
                    height: 56,
                    width: 300),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "I already have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateTo(context, LoginScreen());
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1,
                      width: 40,
                      color: Colors.grey[800],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "Or Sign up with",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 40,
                      color: Colors.grey[800],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/Google.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/Apple.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/Facebook.png"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
