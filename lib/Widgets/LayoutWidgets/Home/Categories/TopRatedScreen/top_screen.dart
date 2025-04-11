import 'package:cinemax/Shared/components/movie_item.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/cubit.dart';
import 'package:cinemax/Shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cinemaxCubit, cinemaxStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return ConditionalBuilder(
            condition: state is! cinemaxGetCategoryLoadingState,
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image(image: AssetImage("assets/images/Back.png"))),
                  title: Text(
                    "Top Rated",
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  centerTitle: true,
                ),
                body: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 650,
                      child: GridView.builder(
                          itemCount: cinemaxCubit
                              .get(context)
                              .TopRatedMoviesList
                              .length,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisExtent: 320,
                                  maxCrossAxisExtent: 280,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return movieItemMostPopular(
                                cinemaxCubit
                                    .get(context)
                                    .TopRatedMoviesList[index],
                                context);
                          }),
                    ),
                  ],
                ),
              );
            },
            fallback: (BuildContext context) {
              return Center(
                  child: CircularProgressIndicator(
                color: primaryColor,
              ));
            },
          );
        });
  }
}
