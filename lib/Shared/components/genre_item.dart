import 'package:cinemax/Shared/components/navigation.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/cubit.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Home/Categories/CategoryScreen/category_screen.dart';
import 'package:flutter/material.dart';

Widget genreItem(
  index,
  context,
  String title,
) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: GestureDetector(
      onTap: () async {
        await cinemaxCubit
            .get(context)
            .fetchCategoriesMovies(title, index, context);
        navigateTo(
            context,
            CategoryScreen(
                listOfCategories: cinemaxCubit.get(context).categoryMoviesList,
                title: title));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: primaryColor),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              genreName[index],
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: genreName[index].length > 10 ? 14 : 16),
            ),
          ),
        ),
      ),
    ),
  );
}
