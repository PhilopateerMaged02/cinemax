import 'package:cinemax/Shared/components.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
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
                    "Let’s get started",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  "The latest movies and series",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                Text(
                  "are here",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: defaultFormField(
                      controller: fullNameController,
                      input: TextInputType.emailAddress,
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return 'Name must not be empty';
                        }
                      },
                      text: "Full Name",
                      prefix: Icons.person,
                    )),
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
                    )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (value) {},
                        activeColor: primaryColor,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("I agree to the"),
                              GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    " Terms and Services",
                                    style: TextStyle(color: primaryColor),
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Text("and"),
                              Text(
                                " Privacy Policy",
                                style: TextStyle(color: primaryColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: buildDefaultButton(
                      text: "Sign Up",
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
