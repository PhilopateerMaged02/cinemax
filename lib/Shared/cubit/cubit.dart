// ignore_for_file: avoid_print

import 'package:cinemax/Models/MoviesModel/movies_model.dart';
import 'package:cinemax/Models/UserModel/user_model.dart';
import 'package:cinemax/Shared/Service/Dio/dio_helper.dart';
import 'package:cinemax/Shared/components.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/states.dart';
import 'package:cinemax/Widgets/AuthunticationWidgets/LoginSignupWidget/login_signup.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Home/home_screen.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Myaccount/myaccount_screen.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Search/search_screen.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Watchlist/watchlist_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class cinemaxCubit extends Cubit<cinemaxStates> {
  cinemaxCubit() : super(cinemaxInitialState());
  static cinemaxCubit get(context) => BlocProvider.of(context);
  /////////////////////BottomNavigationBar Logic////////////////////////////////
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    WatchlistScreen(),
    MyaccountScreen()
  ];
  bool? x = true, y, w, z;
  void changeCurrentIndex(int index) {
    currentIndex = index;
    if (currentIndex == 0) {
      x = true;
      y = false;
      w = false;
      z = false;
    } else if (currentIndex == 1) {
      y = true;
      x = false;
      w = false;
      z = false;
    } else if (currentIndex == 2) {
      w = true;
      x = false;
      y = false;
      z = false;
    } else if (currentIndex == 3) {
      z = true;
      x = false;
      y = false;
      w = false;
    }
    emit(cinemaxChangeBottomNavStates());
  }

  ////////////////////////////////getUserData//////////////////////////////
  UserModel? userModel;
  MoviesModel? moviesModel;
  Future<UserModel?> getUserData() async {
    emit(cinemaxGetUserDataLoadingState());
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .where("uId", isEqualTo: uId)
          .limit(1)
          .get()
          .then((value) => value.docs.first);

      if (userDoc.exists) {
        emit(cinemaxGetUserDataSuccessState());

        print("user id : ${uId!}");
        return userModel =
            UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      emit(cinemaxGetUserDataErrorState());

      print("Error fetching user data: $e");
    }
    emit(cinemaxGetUserDataErrorState());
    return null;
  }

  //////////////////////////////////////////////////////////////////////////////
  List<MoviesModel> upComingMoviesList = [];
  List<MoviesModel> popularMoviesList = [];
  List<MoviesModel> popularTvShowsList = [];
  // ignore: non_constant_identifier_names
  List<MoviesModel> TopRatedMoviesList = [];
  List<MoviesModel> categoryMoviesList = [];
  List<MoviesModel> watchlistMoviesList = [];
  List<MoviesModel> watchlistDetails = [];
  //////////////////////////getUpComingMovies///////////////////////////////////

  Future<void> fetchUpComingMovies() async {
    emit(cinemaxGetUpComingMoviesLoadingState());
    try {
      upComingMoviesList = await DioHelper.getUpComingMovies();
      //print(upComingMoviesList[0]);
      //print(upComingMoviesList.length);
      emit(cinemaxGetUpComingMoviesSuccessState());
    } catch (error) {
      //print("Error in fetching upcoming movies : $error");
      emit(cinemaxGetUpComingMoviesErrorState());
    }
  }

  //////////////////////////getPopularMovies///////////////////////////////////
  Future<void> fetchPopularMovies() async {
    emit(cinemaxGetoPopularMoviesLoadingState());
    try {
      popularMoviesList = await DioHelper.fetchPopularMovies();
      //print(popularMoviesList[0]);
      //print(popularMoviesList.length);
      emit(cinemaxGetPopularMoviesSuccessState());
    } catch (error) {
      //print("Error in fetching popular movies : " + error.toString());
      emit(cinemaxGetPopularMoviesErrorState());
    }
  }

  //////////////////////////getTopRatedMovies///////////////////////////////////
  Future<void> fetchTopRatedMovies() async {
    emit(cinemaxGetTopRatedMoviesLoadingState());
    try {
      TopRatedMoviesList.clear();
      TopRatedMoviesList = await DioHelper.getTopRatedMovies();
      //print(TopRatedMoviesList.length);
      emit(cinemaxGetTopRatedMoviesSuccessState());
    } catch (error) {
      //print("Error in fetching Top Rated movies : " + error.toString());
      emit(cinemaxGetTopRatedMoviesErrorState());
    }
  }

  //////////////////////////getPopularTvShows///////////////////////////////////
  Future<void> fetchPopularTvShows() async {
    emit(cinemaxGetPopularTvShowsLoadingState());
    try {
      popularTvShowsList.clear();
      popularTvShowsList = await DioHelper.getPopularTvShows();
      //print(popularTvShowsList.length);
      emit(cinemaxGetPopularTvShowsSuccessState());
    } catch (error) {
      //print("Error in fetching Popular Tv Shows : " + error.toString());
      emit(cinemaxGetPopularTvShowsErrorState());
    }
  }

  /////////////////////Categories Movies////////////////////////////////////////
  Future<void> fetchCategoriesMovies(title, index, context) async {
    emit(cinemaxGetCategoryLoadingState());
    try {
      int id = genreId[index];
      categoryMoviesList.clear();
      categoryMoviesList = await DioHelper.getCategoriesMovies(id);
      // categoryItem(
      //   categoryMoviesList,
      //   index,
      //   context,
      //   title,
      // );
      //print(categoryMoviesList.length);
      emit(cinemaxGetCategorySuccessState());
    } catch (error) {
      //print("Error in fetching Category Movies : " + error.toString());
      emit(cinemaxGetCategoryErrorState());
    }
  }

  ///////////////////////////Add to Watchlist////////////////////////////////
  void addToWatchlist({
    required int id,
  }) async {
    try {
      emit(cinemaxAddToWatchlistLoadingState());
      await FirebaseFirestore.instance
          .collection("watchlist")
          .doc()
          .set({"uId": uId, "id": id});
      showToust(message: "Added to Watchlist", state: ToastStates.SUCCESS);
      emit(cinemaxAddToWatchlistSuccessState());
    } catch (error) {
      emit(cinemaxAddToWatchlistErrorState());
      //print("Erro in Adding to Watchlist : ${error}");
    }
  }

  ///////////////////////////Add to Watchlist////////////////////////////////
  void removeFromWatchlist({
    required String uId,
    required int movieId,
  }) async {
    try {
      emit(cinemaxRemoveFromWatchlistLoadingState());

      // Get the documents that match the criteria
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("watchlist")
          .where("uId", isEqualTo: uId) // Filter by user ID
          .where("id", isEqualTo: movieId) // Filter by movie ID
          .get();

      // Delete each document that matches
      for (var doc in snapshot.docs) {
        await FirebaseFirestore.instance
            .collection("watchlist")
            .doc(doc.id)
            .delete();
      }
      watchlistDetails.removeWhere((movie) => movie.id == movieId);
      getWatchlistDetails();
      emit(cinemaxRemoveFromWatchlistSucessState());
    } catch (error) {
      emit(cinemaxRemoveFromWatchlistErrorState());
      //print("❌ Error removing from Watchlist: $error");
    }
  }

///////////////////////////get Watchlist////////////////////////////////
  Future<List<MoviesModel>> getWatchlistDetails() async {
    emit(cinemaxGetWatchlistLoadingState());

    try {
      watchlistDetails.clear();
      QuerySnapshot response = await FirebaseFirestore.instance
          .collection("watchlist")
          .where("uId", isEqualTo: uId)
          .get();

      if (response.docs.isNotEmpty) {
        Set<int> uniqueMovieIds = {}; // Set to track unique movie IDs

        for (var doc in response.docs) {
          int movieId = (doc.data() as Map<String, dynamic>)["id"] as int;

          if (!uniqueMovieIds.contains(movieId)) {
            uniqueMovieIds.add(movieId);
            MoviesModel? movie = await DioHelper.fetchMovieDetails(movieId);
            if (movie != null) {
              watchlistDetails.add(movie);
            }
          }
        }

        emit(cinemaxGetWatchlistSuccessState());
        // print("✅ Watchlist details fetched successfully!");
      } else {
        //print("⚠️ No watchlist found for user ID: $uId");
      }
    } catch (e) {
      emit(cinemaxGetWatchlistErrorState());
      //print("❌ Error fetching watchlist details: $e");
    }

    return watchlistDetails;
  }

  void signOut(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      final prefs = await SharedPreferences.getInstance();
      prefs.remove("uId");
      navigateToandKill(context, LoginSignup());
    } catch (error) {
      print('Error signing out: $error');
    }
  }
}
