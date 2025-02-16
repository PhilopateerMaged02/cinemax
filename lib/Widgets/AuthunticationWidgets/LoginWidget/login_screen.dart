import 'package:cinemax/Shared/components.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var fullNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image(image: AssetImage("assets/images/Back.png")),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Hi, User",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  "Welcome! Please enter",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                Text(
                  "your details.",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: defaultFormField(
                      controller: emailController,
                      input: TextInputType.emailAddress,
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return 'Email must not be empty';
                        }
                      },
                      text: "Email Address",
                      prefix: Icons.email,
                    )),
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: defaultFormField(
                        controller: passController,
                        input: TextInputType.emailAddress,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Password must not be empty';
                          }
                        },
                        text: "Password",
                        prefix: Icons.password,
                        onSuffix: () {},
                        isObscure: false,
                        suffix: Icons.remove_red_eye)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(color: primaryColor),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: buildDefaultButton(
                      text: "Login",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {}
                      },
                      height: 56,
                      width: 320),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
