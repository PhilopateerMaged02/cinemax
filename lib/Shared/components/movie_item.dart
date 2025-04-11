import 'package:cinemax/Models/MoviesModel/movies_model.dart';
import 'package:cinemax/Shared/Service/Dio/dio_helper.dart';
import 'package:cinemax/Shared/components/navigation.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Home/MovieItemDetail/movie_item_detail_screen.dart';
import 'package:flutter/material.dart';

Widget movieItem(MoviesModel model, context) {
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
        // ignore: unused_local_variable
        for (String trailerUrl in updatedModel.trailers) {
          //print("Trailer: $trailerUrl");
        }
        //print("Main Trailer: ${updatedModel.mainTrailer}");
      } else {
        //print("No trailers available.");
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
                Image.network(
                  model.posterPath.isNotEmpty
                      ? "https://image.tmdb.org/t/p/w500${model.posterPath}"
                      : "https://www.juliedray.com/wp-content/uploads/2022/01/sans-affiche.png",
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      "https://www.juliedray.com/wp-content/uploads/2022/01/sans-affiche.png",
                      fit: BoxFit.fill,
                    );
                  },
                ),
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
                    model.voteAverage.toDouble().toStringAsFixed(1),
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
    onTap: () async {},
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
          id: updatedModel.id,
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
        // ignore: unused_local_variable
        for (String trailerUrl in updatedModel.trailers) {
          // print("Trailer: $trailerUrl");
        }
      } else {
        //print("No trailers available.");
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
                Image.network(
                  model.posterPath.isNotEmpty
                      ? "https://image.tmdb.org/t/p/w500${model.posterPath}"
                      : "https://www.juliedray.com/wp-content/uploads/2022/01/sans-affiche.png",
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      "https://www.juliedray.com/wp-content/uploads/2022/01/sans-affiche.png",
                      fit: BoxFit.fill,
                    );
                  },
                ),
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
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  Text(
                    model.voteAverage.toDouble().toStringAsFixed(1),
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
          title: updatedModel.title,
          id: updatedModel.id,
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
        // ignore: unused_local_variable
        for (String trailerUrl in updatedModel.trailers) {
          // print("Trailer: $trailerUrl");
        }
      } else {
        //print("No trailers available.");
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
                              updatedModel.title.length > 20
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
                    updatedModel.voteAverage.toDouble().toStringAsFixed(1),
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
