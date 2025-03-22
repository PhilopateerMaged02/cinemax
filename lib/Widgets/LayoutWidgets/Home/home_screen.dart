import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemax/Shared/components.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/cubit.dart';
import 'package:cinemax/Shared/cubit/states.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Home/Categories/all_categories_screen.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Home/MostPopular/most_popular_screen.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Search/search_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 1, top: 8, left: 8),
                      child: Text(
                        "Upcoming",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w800),
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
                          padding: const EdgeInsets.symmetric(vertical: 8),
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
                          vertical: 10, horizontal: 8),
                      child: Row(
                        children: [
                          Text(
                            "Categories",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w800),
                          ),
                          Spacer(),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, AllCategoriesScreen());
                              },
                              child: Text(
                                "See All",
                                style: TextStyle(
                                    color: primaryColor, fontSize: 16),
                              ))
                        ],
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
                              return categoryItem(
                                  cinemaxCubit.get(context).categoryMoviesList,
                                  index,
                                  context,
                                  genreName[index]);
                            },
                            separatorBuilder: (context, index) => Container(
                                  width: 10,
                                ),
                            itemCount: 4),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
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
                        final moviesList =
                            cinemaxCubit.get(context).popularMoviesList;
                        return SizedBox(
                          height: 280,
                          width: double.infinity,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: moviesList.length >= 5
                                ? 5
                                : moviesList
                                    .length, // Avoid out-of-range errors
                            itemBuilder: (context, index) =>
                                movieItem(moviesList[index], context),
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10),
                          ),
                        );
                      },
                      fallback: (BuildContext context) {
                        return Skeletonizer(
                          child: SizedBox(
                            height: 280,
                            width: double.infinity,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) =>
                                  movieItemFallback(context),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 10),
                            ),
                          ),
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
