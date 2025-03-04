import 'package:cinemax/Models/MoviesModel/movies_model.dart';
import 'package:cinemax/Shared/components.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/cubit.dart';
import 'package:cinemax/Shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocumentationScreen extends StatefulWidget {
  @override
  State<DocumentationScreen> createState() => _DocumentationScreenState();
}

class _DocumentationScreenState extends State<DocumentationScreen> {
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
                    "Documentry",
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
                              .documentationMoviesList
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
                                    .documentationMoviesList[index],
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
