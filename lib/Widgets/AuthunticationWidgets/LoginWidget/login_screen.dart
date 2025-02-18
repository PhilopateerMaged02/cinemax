import 'package:cinemax/Shared/components.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/cubit.dart';
import 'package:cinemax/Widgets/AuthunticationWidgets/LoginWidget/cubit/cubit.dart';
import 'package:cinemax/Widgets/AuthunticationWidgets/LoginWidget/cubit/states.dart';
import 'package:cinemax/Widgets/Layout/cinemaxLayout.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  //var fullNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cinemaxLoginCubit(),
      child: BlocConsumer<cinemaxLoginCubit, cinemaxLoginStates>(
        listener: (BuildContext context, state) {
          if (state is cinemaxLoginSuccessState) {
            showToust(
                message: "signed-in successfully", state: ToastStates.SUCCESS);
            navigateTo(context, Cinemaxlayout());
          } else if (state is cinemaxLoginErrorState) {
            showToust(
                message: "Failed in signing-in", state: ToastStates.ERROR);
          }
        },
        builder: (BuildContext context, state) {
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
                          "Hi, ${fullName}",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        "Welcome! Please enter",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "your details.",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
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
                              onSuffix: () {
                                cinemaxLoginCubit
                                    .get(context)
                                    .changeVisibility1();
                              },
                              isObscure:
                                  cinemaxLoginCubit.get(context).visibility1,
                              suffix: cinemaxLoginCubit.get(context).suffix1)),
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
                        child: ConditionalBuilder(
                          condition: state is! cinemaxLoginLoadingState,
                          builder: (BuildContext context) {
                            return buildDefaultButton(
                                text: "Login",
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cinemaxLoginCubit.get(context).Login(
                                        email: emailController.text,
                                        password: passController.text);
                                  }
                                },
                                height: 56,
                                width: 320);
                          },
                          fallback: (BuildContext context) {
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
