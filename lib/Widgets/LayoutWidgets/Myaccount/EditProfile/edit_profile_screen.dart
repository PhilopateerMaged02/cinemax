import 'package:cinemax/Shared/components.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/cubit.dart';
import 'package:cinemax/Shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image(image: AssetImage("assets/images/Back.png"))),
      ),
      body: BlocConsumer<cinemaxCubit, cinemaxStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              cinemaxCubit.get(context).userModel!.image),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        cinemaxCubit.get(context).userModel!.name,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        cinemaxCubit.get(context).userModel!.email,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: nameController,
                      input: TextInputType.text,
                      text: cinemaxCubit.get(context).userModel!.name,
                      prefix: Icons.person,
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return "Name must not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        controller: emailController,
                        input: TextInputType.emailAddress,
                        text: cinemaxCubit.get(context).userModel!.email,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return "Email must not be empty";
                          }
                          return null;
                        },
                        prefix: Icons.email),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        controller: phoneController,
                        input: TextInputType.number,
                        text: cinemaxCubit.get(context).userModel!.phone,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return "Phone must not be empty";
                          }
                          return null;
                        },
                        prefix: Icons.phone),
                    SizedBox(
                      height: 20,
                    ),
                    buildDefaultButton(
                        text: "Save Changes",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (nameController.text.isNotEmpty) {
                              cinemaxCubit
                                  .get(context)
                                  .updateUserName(nameController.text);
                            } else {
                              nameController.text =
                                  cinemaxCubit.get(context).userModel!.name;
                            }
                            if (emailController.text.isNotEmpty) {
                              cinemaxCubit
                                  .get(context)
                                  .updateUserEmail(emailController.text);
                            } else {
                              emailController.text =
                                  cinemaxCubit.get(context).userModel!.email;
                            }
                            if (phoneController.text.isNotEmpty) {
                              // cinemaxCubit
                              //     .get(context)
                              //     .updateUserName(nameController.text);
                            } else {
                              phoneController.text =
                                  cinemaxCubit.get(context).userModel!.phone;
                            }
                          }
                        },
                        height: 50,
                        width: double.infinity,
                        color: primaryColor),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
