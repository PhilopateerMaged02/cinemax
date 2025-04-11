import 'package:cinemax/Shared/components/navigation.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/cubit.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Home/Categories/CategoryScreen/category_screen.dart';
import 'package:flutter/material.dart';

Widget categoryItem(
  categoryList,
  index,
  context,
  String title,
) {
  //cinemaxCubit.get(context).fetchCategoriesMovies(title, index, context, index);
  return GestureDetector(
    onTap: () async {
      await cinemaxCubit
          .get(context)
          .fetchCategoriesMovies(title, index, context);
      navigateTo(
          context,
          CategoryScreen(
              listOfCategories: cinemaxCubit.get(context).categoryMoviesList,
              title: title));
      //print("Index of ListView = " + index.toString());
      //print("Index of GenreNameList = " + genreName[index]);
      //print("Index of GenreIdList = " + genreId[index].toString());
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        child: Text(
          genreName[index],
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}
