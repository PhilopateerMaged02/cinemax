import 'package:cinemax/Shared/components/default_button.dart';
import 'package:cinemax/Shared/components/default_text_form_field.dart';
import 'package:cinemax/Shared/components/navigation.dart';
import 'package:cinemax/Shared/components/toust.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Widgets/AuthunticationWidgets/LoginWidget/login_screen.dart';
import 'package:cinemax/Widgets/AuthunticationWidgets/SignupWidget/cubit/cubit.dart';
import 'package:cinemax/Widgets/AuthunticationWidgets/SignupWidget/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var fullNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  SignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cinemaxRegisterCubit(),
      child: BlocConsumer<cinemaxRegisterCubit, cinemaxRegisterStates>(
        listener: (BuildContext context, state) {
          if (state is cinemaxRegisterSuccessState) {
            fullName = fullNameController.text;
            showToust(
                message: "Signed-up Successfully", state: ToastStates.SUCCESS);
            navigateTo(context, LoginScreen());
          } else if (state is cinemaxRegisterErrorState) {
            showToust(
                message: "Email or Password is wrong",
                state: ToastStates.ERROR);
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
                          "Let’s get started",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        "The latest movies and series",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "are here",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
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
                              return null;
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
                              return null;
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
                                return null;
                              },
                              text: "Password",
                              prefix: Icons.password,
                              suffix: cinemaxRegisterCubit.get(context).suffix1,
                              isObscure:
                                  cinemaxRegisterCubit.get(context).visibility1,
                              onSuffix: () {
                                cinemaxRegisterCubit
                                    .get(context)
                                    .changeVisibility1();
                              })),
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
                        child: ConditionalBuilder(
                          condition: state is! cinemaxRegisterLoadingState,
                          builder: (BuildContext context) {
                            return buildDefaultButton(
                                color: primaryColor,
                                text: "Sign Up",
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cinemaxRegisterCubit.get(context).Register(
                                        email: emailController.text,
                                        name: fullNameController.text,
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
