import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemax/Models/MoviesModel/movies_model.dart';
import 'package:cinemax/Shared/Service/Dio/dio_helper.dart';
import 'package:cinemax/Shared/components.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/cubit.dart';
import 'package:cinemax/Shared/cubit/states.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Home/MostPopular/most_popular_screen.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Search/search_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  // Fetch movies using DioHelper
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cinemaxCubit, cinemaxStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      children: [
                        ConditionalBuilder(
                          condition: state is! cinemaxGetUserDataLoadingState,
                          builder: (BuildContext context) {
                            return CircleAvatar(
                              radius: 25,
                              backgroundColor: primaryColor,
                              backgroundImage: cinemaxCubit
                                              .get(context)
                                              .userModel !=
                                          null &&
                                      cinemaxCubit
                                          .get(context)
                                          .userModel!
                                          .image
                                          .isNotEmpty
                                  ? NetworkImage(cinemaxCubit
                                      .get(context)
                                      .userModel!
                                      .image)
                                  : AssetImage("assets/images/placeHolder.png")
                                      as ImageProvider,
                            );
                          },
                          fallback: (BuildContext context) {
                            return Skeletonizer(
                                child: CircleAvatar(
                              radius: 25,
                              backgroundColor: primaryColor,
                            ));
                          },
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConditionalBuilder(
                              condition:
                                  state is! cinemaxGetUserDataLoadingState,
                              builder: (BuildContext context) {
                                return Text(
                                  "Hello, ${cinemaxCubit.get(context).userModel != null ? cinemaxCubit.get(context).userModel!.name : "Guest"}",
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                );
                              },
                              fallback: (BuildContext context) {
                                return Skeletonizer(
                                  child: Text("Hello, Guest",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800)),
                                );
                              },
                            ),
                            Text(
                              "Browse your favorite movies",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                        Spacer(),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[900],
                          child: Icon(Icons.favorite, color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        navigateTo(context, SearchScreen());
                      },
                      child: Center(
                        child: Container(
                          width: 300,
                          //height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                Text("Search a title...",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey)),
                                Spacer(),
                                Container(
                                  width: 1,
                                  height: 20,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.format_list_bulleted,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    ConditionalBuilder(
                      condition:
                          state is! cinemaxGetUpComingMoviesLoadingState &&
                              cinemaxCubit
                                  .get(context)
                                  .upComingMoviesList
                                  .isNotEmpty,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: CarouselSlider.builder(
                              itemCount: cinemaxCubit
                                  .get(context)
                                  .upComingMoviesList
                                  .length,
                              itemBuilder: (context, index, realIndex) =>
                                  CarouselItem(
                                      cinemaxCubit
                                          .get(context)
                                          .upComingMoviesList[index],
                                      context),
                              options: CarouselOptions(
                                  autoPlay: true,
                                  height: 180,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentIndex =
                                          index; // Update active index
                                    });
                                  }
                                  //aspectRatio: 2.0,
                                  )),
                        );
                      },
                      fallback: (BuildContext context) {
                        return Skeletonizer(
                          child: CarouselItemFallback(context),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: SizedBox(
                        width: double.infinity,
                        height: 10,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                Sliders(index == currentIndex),
                            separatorBuilder: (context, index) => Container(
                                  width: 5,
                                ),
                            itemCount: cinemaxCubit
                                .get(context)
                                .upComingMoviesList
                                .length),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 20),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              // cinemaxCubit.get(context).fetchCategoriesMovies(
                              //     genreName[index],
                              //     index,
                              //     context,
                              //     genreId[index]);
                              return categoryItem(
                                  cinemaxCubit.get(context).categoryMoviesList,
                                  index,
                                  context,
                                  genreId[index]);
                            },
                            separatorBuilder: (context, index) => Container(
                                  width: 10,
                                ),
                            itemCount: genreName.length),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 8),
                      child: Row(
                        children: [
                          Text(
                            "Most Popular",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w800),
                          ),
                          Spacer(),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, MostPopularScreen());
                              },
                              child: Text(
                                "See All",
                                style: TextStyle(
                                    color: primaryColor, fontSize: 16),
                              ))
                        ],
                      ),
                    ),
                    ConditionalBuilder(
                      condition:
                          state is! cinemaxGetoPopularMoviesLoadingState &&
                              cinemaxCubit
                                  .get(context)
                                  .popularMoviesList
                                  .isNotEmpty,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 280,
                          width: double.infinity,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => movieItem(
                                  cinemaxCubit
                                      .get(context)
                                      .popularMoviesList[index],
                                  context),
                              separatorBuilder: (context, index) => Container(
                                    width: 10,
                                  ),
                              itemCount: 5),
                        );
                      },
                      fallback: (BuildContext context) {
                        return Skeletonizer(
                          child: movieItemFallback(context),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}




// Movie Card Widget
// class MovieCard extends StatelessWidget {
//   final MoviesModel movie;

//   const MovieCard({required this.movie});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: Colors.grey[900],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
//             child: Image.network(
//               "https://image.tmdb.org/t/p/w500${movie.posterPath}",
//               height: 180,
//               width: double.infinity,
//               fit: BoxFit.fill,
//               errorBuilder: (context, error, stackTrace) =>
//                   Icon(Icons.image_not_supported, color: Colors.white),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   movie.title,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 5),
//                 Row(
//                   children: [
//                     Icon(Icons.star, color: Colors.yellow, size: 16),
//                     SizedBox(width: 5),
//                     Text(
//                       "${movie.voteAverage.toStringAsFixed(1)}",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
                  // Grid of Popular Movies
                  // Expanded(
                  //   child: FutureBuilder<List<MoviesModel>>(
                  //     future: fetchPopularMovies(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState == ConnectionState.waiting) {
                  //         return Center(child: CircularProgressIndicator());
                  //       } else if (snapshot.hasError) {
                  //         return Center(
                  //             child: Text(
                  //                 "❌ Error loading movies: ${snapshot.error}"));
                  //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  //         return Center(child: Text("No movies found"));
                  //       } else {
                  //         List<MoviesModel> movies = snapshot.data!;
                  //         return GridView.builder(
                  //           padding: EdgeInsets.only(top: 10),
                  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //             crossAxisCount: 2,
                  //             crossAxisSpacing: 10,
                  //             mainAxisSpacing: 10,
                  //             childAspectRatio: 0.65, // Adjusted for better layout
                  //           ),
                  //           itemCount: movies.length,
                  //           itemBuilder: (context, index) {
                  //             return MovieCard(movie: movies[index]);
                  //           },
                  //         );
                  //       }
                  //     },
                  //   ),
                  // ),