import 'package:cinemax/Shared/components.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/cubit.dart';
import 'package:cinemax/Shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget
{
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final repeatNewPasswordController = TextEditingController(); 
  final formKey = GlobalKey<FormState>();
  ChangePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) 
  {
    return BlocConsumer<cinemaxCubit,cinemaxStates>(
      listener: (BuildContext context, cinemaxStates state) {  },
      builder: (BuildContext context, cinemaxStates state) 
      {
        return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Chnage Password",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
             leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image(image: AssetImage("assets/images/Back.png"))),
          ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                spacing: 30,
                children: [
                  defaultFormField(controller: currentPasswordController,
                   input: TextInputType.text, text: "Current Password", prefix: Icons.password,
                   onValidator: (value) {
                    return "Current Password must not be empty";
                   },
                   ),
                    defaultFormField(controller: newPasswordController,
                   input: TextInputType.text, text: "New Password", prefix: Icons.password
                   ,
                   onValidator: (value) {
                    return "New Password must not be empty";
                   },
                   ),
                    defaultFormField(controller:repeatNewPasswordController,
                   input: TextInputType.text, text: "Re-Enter New Password", prefix: Icons.password
                   ,
                   onValidator: (value) {
                    return "Repeat New Password must not be empty";
                   },
                   ),
                   ConditionalBuilder(
                     condition: state is! cinemaxUpdateUserPasswordLoadingState,
                     builder: (BuildContext context)
                      { 
                        return buildDefaultButton(text: "Change Password", onPressed: ()
                        {
                            if (formKey.currentState!.validate()) 
                            {
                              if(newPasswordController.text == repeatNewPasswordController.text)
                          {
                            if(newPasswordController.text.length >= 8)
                            {
                               cinemaxCubit.get(context).updatePassword(currentPasswordController.text,
                           newPasswordController.text);
                            }
                            else
                            {
                              showToust(message: "New Password less than 8 characters", state: ToastStates.ERROR);
                            }
                          }
                          else
                          {
                            showToust(message: "Make sure you repeated new password right", state:ToastStates.ERROR);
                          }
                            }
                        }, 
                     height: 50, width: double.infinity, color: primaryColor);
                       },
                     fallback: (BuildContext context) { 
                      return Center(child: CircularProgressIndicator(color: primaryColor,));
                      },
                   ),
                ],
              ),
            ),
          ),
        ),
      ); 
        },
    );
  }
}