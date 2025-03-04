import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemax/Models/MoviesModel/movies_model.dart';
import 'package:cinemax/Shared/Service/Dio/dio_helper.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/cubit.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Home/Categories/ActionScreen/action_screen.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Home/Categories/DocumentationScreen/documentation_screen.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Home/Categories/TopRatedScreen/top_screen.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Home/Categories/categories_screen.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Home/MovieItemDetail/movie_item_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToust({
  required String message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: message,
    textColor: Colors.white,
    backgroundColor: chooseToastColor(state),
    fontSize: 16,
    timeInSecForIosWeb: 5,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_LONG,
  );
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Future navigateTo(context, widget) {
  return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

Future navigatoToWithAnimation(context, widget) {
  return Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = 0.0;
        var end = 1.0;
        var curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var scaleAnimation = animation.drive(tween);
        return ScaleTransition(
          scale: scaleAnimation,
          child: child,
        );
      },
    ),
  );
}

Future navigateToandKill(context, widget) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

Widget buildDefaultButton({
  required String text,
  required VoidCallback onPressed,
  required double height,
  required double width,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: primaryColor, borderRadius: BorderRadius.circular(25)),
    child: TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType input,
  Function(String)? onFieldSubmitted,
  Function(String)? onChanged,
  Function()? onTap,
  bool isObscure = false,
  FormFieldValidator<String>? onValidator,
  required String text,
  required IconData prefix,
  IconData? suffix,
  Function()? onSuffix,
  bool isClickable = true,
}) =>
    TextFormField(
      cursorColor: primaryColor,
      controller: controller,
      keyboardType: input,
      obscureText: isObscure,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      validator: onValidator,
      onTap: onTap,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: primaryColor),
        ),
        prefixIcon: Icon(prefix, color: Colors.grey),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: onSuffix,
                icon: Icon(suffix, color: Colors.grey),
              )
            : null,
      ),
    );
Widget Sliders(bool isActive) {
  return CircleAvatar(
    radius: 5,
    backgroundColor: isActive ? primaryColor : Colors.grey,
  );
}

Widget CarouselItem(MoviesModel model, context) {
  return GestureDetector(
    onTap: () async {
      MoviesModel? updatedModel = await DioHelper.fetchMovieDetails(model.id);
      navigateTo(
        context,
        MovieItemDetailScreen(
          title: updatedModel!.title,
          genre: updatedModel.genres.first,
          trailerURL: updatedModel.mainTrailer!,
          posterImage: updatedModel.posterPath,
          rate: updatedModel.voteAverage.toDouble().toStringAsFixed(1),
          year: updatedModel.releaseDate.substring(0, 4),
          overview: updatedModel.overview,
          genres: updatedModel.genres,
          runTime: updatedModel.runtime.toString(),
          popularity: updatedModel.popularity.round().toString(),
          cast: updatedModel.castAndCrew,
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20)),
              width: double.infinity,
              child: Container(
                height: 180,
                child: Image(
                    fit: BoxFit.contain,
                    image: NetworkImage(
                        "https://image.tmdb.org/t/p/w500${model.backdropPath}")),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            child: Text(
              model.title,
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              model.releaseDate,
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget CarouselItemFallback(context) {
  return GestureDetector(
    onTap: () async {
      //MoviesModel? updatedModel = await DioHelper.fetchMovieDetails(model.id);
      // navigateTo(
      //   context,
      //   MovieItemDetailScreen(
      //     title: updatedModel!.title,
      //     genre: updatedModel.genres.first,
      //     trailerURL: updatedModel.mainTrailer!,
      //     posterImage: updatedModel.posterPath,
      //     rate: updatedModel.voteAverage.toDouble().toStringAsFixed(1),
      //     year: updatedModel.releaseDate.substring(0, 4),
      //     overview: updatedModel.overview,
      //     genres: updatedModel.genres,
      //     runTime: updatedModel.runtime.toString(),
      //     popularity: updatedModel.popularity.round().toString(),
      //     cast: updatedModel.castAndCrew,
      //   ),
      // );
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20)),
              width: double.infinity,
              child: Container(
                height: 180,
                child: Image(
                    fit: BoxFit.fitWidth,
                    image: AssetImage("assets/images/placeHolder.png")),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            child: Text(
              "No Title",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "No Date",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget categoryItem(categoryList, index, context, title) {
  //cinemaxCubit.get(context).fetchCategoriesMovies(title, index, context, index);
  return GestureDetector(
    onTap: () async {
      if (index == 0) {
        // navigateTo(
        //     context,
        //     CategoriesScreen(
        //       listOfCategories: categoryList,
        //       title: title,
        //     ));
        navigateTo(context, TopScreen());
        print("Index of ListView = " + index.toString());
        print("Index of GenreNameList = " + genreName[index]);
        print("Index of GenreIdList = " + genreId[index].toString());
      } else if (index == 1) {
        navigateTo(context, ActionScreen());
        //await DioHelper.getCategoriesMovies(genreId[index]);
        // navigateTo(
        //     context,
        //     CategoriesScreen(
        //       listOfCategories: categoryList,
        //       title: title,
        //     ));
      } else if (index == 2) {
        navigateTo(context, DocumentationScreen());
        //await DioHelper.getCategoriesMovies(genreId[index]);
        // navigateTo(
        //     context,
        //     CategoriesScreen(
        //       listOfCategories: categoryList,
        //       title: title,
        //     ));
      } else if (index == 3) {
        navigateTo(context, DocumentationScreen());
        //await DioHelper.getCategoriesMovies(genreId[index]);
        // navigateTo(
        //     context,
        //     CategoriesScreen(
        //       listOfCategories: categoryList,
        //       title: title,
        //     ));
      } else if (index == 4) {
        navigateTo(context, ActionScreen());
        //await DioHelper.getCategoriesMovies(genreId[index]);
        // navigateTo(
        //     context,
        //     CategoriesScreen(
        //       listOfCategories: categoryList,
        //       title: title,
        //     ));
      } else if (index == 5) {
        navigateTo(context, ActionScreen());
        //await DioHelper.getCategoriesMovies(genreId[index]);
        // navigateTo(
        //     context,
        //     CategoriesScreen(
        //       listOfCategories: categoryList,
        //       title: title,
        //     ));
      } else if (index == 6) {
        navigateTo(context, ActionScreen());
        //await DioHelper.getCategoriesMovies(genreId[index]);
        // navigateTo(
        //     context,
        //     CategoriesScreen(
        //       listOfCategories: categoryList,
        //       title: title,
        //     ));
      } else if (index == 7) {
        navigateTo(context, ActionScreen());
        //await DioHelper.getCategoriesMovies(genreId[index]);
        // navigateTo(
        //     context,
        //     CategoriesScreen(
        //       listOfCategories: categoryList,
        //       title: title,
        //     ));
      } else if (index == 8) {
        navigateTo(context, ActionScreen());
        //await DioHelper.getCategoriesMovies(genreId[index]);
        // navigateTo(
        //     context,
        //     CategoriesScreen(
        //       listOfCategories: categoryList,
        //       title: title,
        //     ));
      }
      print("Index of ListView = " + index.toString());
      print("Index of GenreNameList = " + genreName[index]);
      print("Index of GenreIdList = " + genreId[index].toString());
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        child: Container(
          child: Text(
            "${genreName[index]}",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget movieItem(MoviesModel model, context) {
  return GestureDetector(
    onTap: () async {
      MoviesModel? updatedModel = await DioHelper.fetchMovieDetails(model.id);
      navigateTo(
        context,
        MovieItemDetailScreen(
          title: updatedModel!.title,
          genre: updatedModel.genres.first,
          trailerURL: updatedModel.mainTrailer!,
          posterImage: updatedModel.posterPath,
          genres: updatedModel.genres,
          rate: updatedModel.voteAverage.toDouble().toStringAsFixed(1),
          year: updatedModel.releaseDate.substring(0, 4),
          overview: updatedModel.overview,
          runTime: updatedModel.runtime.toString(),
          popularity: updatedModel.popularity.round().toString(),
          cast: updatedModel.castAndCrew,
        ),
      );
      if (updatedModel.trailers.isNotEmpty) {
        for (String trailerUrl in updatedModel.trailers) {
          print("Trailer: $trailerUrl");
        }
        print("Main Trailer: ${updatedModel.mainTrailer}");
      } else {
        print("No trailers available.");
      }
    },
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            width: 150,
            height: 350,
            color: Colors.grey[900],
            child: Column(
              children: [
                Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://image.tmdb.org/t/p/w500${model.posterPath}")),
                Spacer(),
                Container(
                  width: double.infinity,
                  height: 40,
                  color: Colors.grey[900],
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              model.title.length > 15
                                  ? "${model.title.substring(0, 15)}..."
                                  : model.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w800),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              model.releaseDate,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            //width: 20,
            //height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey[700],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  Text(
                    '${model.voteAverage.toDouble().toStringAsFixed(1)}',
                    style: TextStyle(color: Colors.orange),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget movieItemFallback(context) {
  return GestureDetector(
    onTap: () async {
      //MoviesModel? updatedModel = await DioHelper.fetchMovieDetails(model.id);
      // navigateTo(
      //   context,
      //   MovieItemDetailScreen(
      //     title: updatedModel!.title,
      //     genre: updatedModel.genres.first,
      //     trailerURL: updatedModel.mainTrailer!,
      //     posterImage: updatedModel.posterPath,
      //     genres: updatedModel.genres,
      //     rate: updatedModel.voteAverage.toDouble().toStringAsFixed(1),
      //     year: updatedModel.releaseDate.substring(0, 4),
      //     overview: updatedModel.overview,
      //     runTime: updatedModel.runtime.toString(),
      //     popularity: updatedModel.popularity.round().toString(),
      //     cast: updatedModel.castAndCrew,
      //   ),
      // );
      // if (updatedModel.trailers.isNotEmpty) {
      //   for (String trailerUrl in updatedModel.trailers) {
      //     print("Trailer: $trailerUrl");
      //   }
      //   print("Main Trailer: ${updatedModel.mainTrailer}");
      // } else {
      //   print("No trailers available.");
      // }
    },
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            width: 150,
            height: 350,
            color: Colors.grey[900],
            child: Column(
              children: [
                Image(
                    fit: BoxFit.fitHeight,
                    image: AssetImage("assets/images/placeHolder.png")),
                Spacer(),
                Container(
                  width: double.infinity,
                  height: 40,
                  color: Colors.grey[900],
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w800),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            //width: 20,
            //height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey[700],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  Text(
                    '',
                    style: TextStyle(color: Colors.orange),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget movieItemMostPopular(MoviesModel model, context) {
  return GestureDetector(
    onTap: () async {
      MoviesModel? updatedModel = await DioHelper.fetchMovieDetails(model.id);
      navigateTo(
        context,
        MovieItemDetailScreen(
          title: updatedModel!.title,
          genre: updatedModel.genres.first,
          posterImage: updatedModel.posterPath,
          trailerURL: updatedModel.mainTrailer!,
          genres: updatedModel.genres,
          rate: updatedModel.voteAverage.toDouble().toStringAsFixed(1),
          year: updatedModel.releaseDate.substring(0, 4),
          overview: updatedModel.overview,
          runTime: updatedModel.runtime.toString(),
          popularity: updatedModel.popularity.round().toString(),
          cast: updatedModel.castAndCrew,
        ),
      );
      if (updatedModel.trailers.isNotEmpty) {
        for (String trailerUrl in updatedModel.trailers) {
          print("Trailer: $trailerUrl");
        }
      } else {
        print("No trailers available.");
      }
    },
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            width: 250,
            color: Colors.grey[900],
            child: Column(
              children: [
                Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://image.tmdb.org/t/p/w500${model.posterPath}")),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    color: Colors.grey[900],
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.title.length > 20
                                  ? "${model.title.substring(0, 15)}..."
                                  : model.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              model.releaseDate,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: 60,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey[700],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  Text(
                    '${model.voteAverage.toDouble().toStringAsFixed(1)}',
                    style: TextStyle(color: Colors.orange),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget movieItemSearch(query, context) {
  MoviesModel? updatedModel = (DioHelper.searchAll(query)) as MoviesModel?;
  return GestureDetector(
    onTap: () async {
      navigateTo(
        context,
        MovieItemDetailScreen(
          title: updatedModel!.title,
          genre: updatedModel.genres.first,
          posterImage: updatedModel.posterPath,
          trailerURL: updatedModel.mainTrailer!,
          genres: updatedModel.genres,
          rate: updatedModel.voteAverage.toDouble().toStringAsFixed(1),
          year: updatedModel.releaseDate.substring(0, 4),
          overview: updatedModel.overview,
          runTime: updatedModel.runtime.toString(),
          popularity: updatedModel.popularity.round().toString(),
          cast: updatedModel.castAndCrew,
        ),
      );
      if (updatedModel.trailers.isNotEmpty) {
        for (String trailerUrl in updatedModel.trailers) {
          print("Trailer: $trailerUrl");
        }
      } else {
        print("No trailers available.");
      }
    },
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            width: 250,
            color: Colors.grey[900],
            child: Column(
              children: [
                Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://image.tmdb.org/t/p/w500${updatedModel!.posterPath}")),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    color: Colors.grey[900],
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              updatedModel!.title.length > 20
                                  ? "${updatedModel.title.substring(0, 15)}..."
                                  : updatedModel.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              updatedModel.releaseDate,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: 60,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey[700],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  Text(
                    '${updatedModel.voteAverage.toDouble().toStringAsFixed(1)}',
                    style: TextStyle(color: Colors.orange),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}
