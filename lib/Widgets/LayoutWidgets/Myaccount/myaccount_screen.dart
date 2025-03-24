import 'package:cinemax/Shared/components.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/cubit.dart';
import 'package:cinemax/Shared/cubit/states.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Myaccount/EditProfile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyaccountScreen extends StatelessWidget {
  const MyaccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cinemaxCubit, cinemaxStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Profile",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[800]!),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                cinemaxCubit.get(context).userModel!.image),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cinemaxCubit.get(context).userModel!.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 19),
                                ),
                                Text(
                                  cinemaxCubit.get(context).userModel!.email,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                navigateTo(context, EditProfileScreen());
                              },
                              icon: Icon(
                                size: 40,
                                Icons.edit_note,
                                color: primaryColor,
                              ))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[800]!),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Text(
                              "Account",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 19),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 8, bottom: 20, right: 16),
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey[900],
                                    child: Icon(
                                      Icons.lock,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "Change Password",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: primaryColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[800]!),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Text(
                              "General",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 19),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey[900],
                                    child: Icon(
                                      Icons.pie_chart_outline_outlined,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Language"),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: primaryColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Container(
                              width: 200,
                              height: 1,
                              color: Colors.grey[800],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 8, bottom: 20, right: 16),
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey[900],
                                    child: Icon(
                                      Icons.shield,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "Legal and Policies",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: primaryColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Container(
                              width: 200,
                              height: 1,
                              color: Colors.grey[800],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 8, bottom: 20, right: 16),
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey[900],
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "Clear Cache",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: primaryColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Container(
                              width: 200,
                              height: 1,
                              color: Colors.grey[800],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 8, bottom: 20, right: 16),
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey[900],
                                    child: Icon(
                                      Icons.info,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "About Us",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: primaryColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildDefaultButton(
                      text: "Sign out",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Are you sure?",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 40),
                                            child: buildDefaultButton(
                                                text: "Sure",
                                                onPressed: () {
                                                  cinemaxCubit
                                                      .get(context)
                                                      .signOut(context);
                                                },
                                                height: 50,
                                                width: 100,
                                                color: primaryColor),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 40),
                                            child: buildDefaultButton(
                                                text: "Cancel",
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                height: 50,
                                                width: 100,
                                                color: Colors.black12),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      height: 50,
                      width: double.infinity,
                      color: Colors.black12)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
