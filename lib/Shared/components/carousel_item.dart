import 'package:cinemax/Models/MoviesModel/movies_model.dart';
import 'package:cinemax/Shared/Service/Dio/dio_helper.dart';
import 'package:cinemax/Shared/components/navigation.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Home/MovieItemDetail/movie_item_detail_screen.dart';
import 'package:flutter/material.dart';

Widget CarouselItem(MoviesModel model, context) {
  return GestureDetector(
    onTap: () async {
      MoviesModel? updatedModel = await DioHelper.fetchMovieDetails(model.id);
      navigateTo(
        context,
        MovieItemDetailScreen(
          id: updatedModel!.id,
          title: updatedModel.title,
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
              child: SizedBox(
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
              formatReleaseDate(model.releaseDate),
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget CarouselItemFallback(context) {
  return GestureDetector(
    onTap: () async {},
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
              child: SizedBox(
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
