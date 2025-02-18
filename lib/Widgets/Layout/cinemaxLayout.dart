import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/cubit.dart';
import 'package:cinemax/Shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cinemaxlayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cinemaxCubit, cinemaxStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return Scaffold(
          body: cinemaxCubit
              .get(context)
              .screens[cinemaxCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedIconTheme: IconThemeData(color: primaryColor),
            unselectedIconTheme: IconThemeData(color: Colors.grey),
            selectedLabelStyle: TextStyle(color: primaryColor),
            items: [
              BottomNavigationBarItem(
                icon: (cinemaxCubit.get(context).x ?? false)
                    ? Container(
                        width: MediaQuery.of(context).size.width *
                            0.22, // Dynamic width
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          border: Border.all(color: Colors.grey[900]!),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home,
                                size: 19,
                              ),
                              //SizedBox(width: 5), // Add spacing
                              Text(" Home",
                                  style: TextStyle(color: primaryColor)),
                            ],
                          ),
                        ),
                      )
                    : Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: (cinemaxCubit.get(context).y ?? false)
                    ? Container(
                        width: MediaQuery.of(context).size.width *
                            0.22, // Responsive width
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          border: Border.all(color: Colors.grey[900]!),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                size: 19,
                              ),
                              //SizedBox(width: 5),
                              Text(" Search",
                                  style: TextStyle(color: primaryColor)),
                            ],
                          ),
                        ),
                      )
                    : Icon(Icons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: (cinemaxCubit.get(context).w ?? false)
                    ? Container(
                        width: MediaQuery.of(context).size.width *
                            0.26, // Adjusted width
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          border: Border.all(color: Colors.grey[900]!),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bookmark,
                                size: 19,
                              ),
                              //SizedBox(width: 5),
                              Text("Watchlist",
                                  style: TextStyle(
                                      color: primaryColor, fontSize: 12)),
                            ],
                          ),
                        ),
                      )
                    : Icon(Icons.bookmark),
                label: "Watchlist",
              ),
              BottomNavigationBarItem(
                icon: (cinemaxCubit.get(context).z ?? false)
                    ? Container(
                        width: MediaQuery.of(context).size.width *
                            0.22, // Adjusted width
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          border: Border.all(color: Colors.grey[900]!),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                size: 19,
                              ),
                              //SizedBox(width: 5),
                              Text(" Profile",
                                  style: TextStyle(color: primaryColor)),
                            ],
                          ),
                        ),
                      )
                    : Icon(Icons.person),
                label: "Profile",
              ),
            ],
            currentIndex: cinemaxCubit.get(context).currentIndex,
            onTap: (index) {
              cinemaxCubit.get(context).changeCurrentIndex(index);
            },
          ),
        );
      },
    );
  }
}
