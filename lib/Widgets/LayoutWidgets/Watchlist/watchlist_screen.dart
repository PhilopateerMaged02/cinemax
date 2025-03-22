import 'package:cinemax/Models/MoviesModel/movies_model.dart';
import 'package:cinemax/Shared/components.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/cubit.dart';
import 'package:cinemax/Shared/cubit/states.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Home/MovieItemDetail/movie_item_detail_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cinemaxCubit, cinemaxStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark),
                  Text(
                    "Watchlist",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: cinemaxCubit.get(context).watchlistDetails.isNotEmpty,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: 1000,
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return itemWatchlist(
                                    cinemaxCubit
                                        .get(context)
                                        .watchlistDetails[index],
                                    context);
                              },
                              separatorBuilder: (context, index) {
                                return Container(
                                  height: 10,
                                );
                              },
                              itemCount: cinemaxCubit
                                  .get(context)
                                  .watchlistDetails
                                  .length),
                        ),
                      ),
                    ],
                  ),
                );
              },
              fallback: (BuildContext context) {
                return Center(
                  child: SvgPicture.asset(
                    "assets/images/emptyWatchlist2.svg",
                    width: 200,
                    height: 200,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget itemWatchlist(MoviesModel model, context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
            context,
            MovieItemDetailScreen(
                id: model.id,
                title: model.title,
                trailerURL: model.mainTrailer!,
                genre: model.genres.first,
                genres: model.genres,
                cast: model.castAndCrew,
                runTime: model.runtime.toString(),
                posterImage: model.posterPath,
                rate: model.voteAverage.toDouble().toStringAsFixed(1),
                year: model.releaseDate.substring(0, 4),
                popularity: model.popularity.toString(),
                overview: model.overview));
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Card(
              elevation: 10,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Stack(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              width: 100,
                              height: 150,
                              child: Image.network(
                                  "https://image.tmdb.org/t/p/w500${model.posterPath}")),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[700]),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 18,
                              ),
                              Text(
                                model.voteAverage.toDouble().toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title.length > 15
                              ? "${model.title.substring(0, 15)}..."
                              : model.title,
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w800),
                        ),
                        Row(
                          spacing: 5,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: Colors.grey,
                            ),
                            Text(model.releaseDate.substring(0, 4)),
                          ],
                        ),
                        Row(
                          spacing: 5,
                          children: [
                            Icon(
                              Icons.timer,
                              color: Colors.grey,
                            ),
                            Text("${model.runtime} min"),
                          ],
                        ),
                        Row(
                          spacing: 5,
                          children: [
                            Icon(
                              Icons.movie,
                              color: Colors.grey,
                            ),
                            Text(model.genres.first),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
                onPressed: () {
                  cinemaxCubit
                      .get(context)
                      .removeFromWatchlist(uId: uId!, movieId: model.id);
                  setState(() {});
                },
                icon: Icon(Icons.delete)),
          )
        ],
      ),
    );
  }
}
