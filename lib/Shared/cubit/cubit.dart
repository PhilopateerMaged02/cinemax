import 'package:bloc/bloc.dart';
import 'package:cinemax/Models/MoviesModel/movies_model.dart';
import 'package:cinemax/Models/UserModel/user_model.dart';
import 'package:cinemax/Shared/Service/Dio/dio_helper.dart';
import 'package:cinemax/Shared/components.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/states.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Home/home_screen.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Myaccount/myaccount_screen.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Search/search_screen.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Watchlist/watchlist_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        print("user id : " + uId!);
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
  List<MoviesModel> TopRatedMoviesList = [];
  List<MoviesModel> categoryMoviesList = [];
  List<MoviesModel> actionMoviesList = [];
  List<MoviesModel> documentationMoviesList = [];
  //////////////////////////getUpComingMovies///////////////////////////////////

  Future<void> fetchUpComingMovies() async {
    emit(cinemaxGetUpComingMoviesLoadingState());
    try {
      upComingMoviesList = await DioHelper.getUpComingMovies();
      print(upComingMoviesList[0]);
      print(upComingMoviesList.length);
      emit(cinemaxGetUpComingMoviesSuccessState());
    } catch (error) {
      print("Error in fetching upcoming movies : " + error.toString());
      emit(cinemaxGetUpComingMoviesErrorState());
    }
  }

  //////////////////////////getPopularMovies///////////////////////////////////
  Future<void> fetchPopularMovies() async {
    emit(cinemaxGetoPopularMoviesLoadingState());
    try {
      popularMoviesList = await DioHelper.fetchPopularMovies();
      print(popularMoviesList[0]);
      print(popularMoviesList.length);
      emit(cinemaxGetPopularMoviesSuccessState());
    } catch (error) {
      print("Error in fetching popular movies : " + error.toString());
      emit(cinemaxGetPopularMoviesErrorState());
    }
  }

  //////////////////////////getTopRatedMovies///////////////////////////////////
  Future<void> fetchTopRatedMovies() async {
    emit(cinemaxGetTopRatedMoviesLoadingState());
    try {
      TopRatedMoviesList.clear();
      TopRatedMoviesList = await DioHelper.getTopRatedMovies();
      print(TopRatedMoviesList.length);
      emit(cinemaxGetTopRatedMoviesSuccessState());
    } catch (error) {
      print("Error in fetching Top Rated movies : " + error.toString());
      emit(cinemaxGetTopRatedMoviesErrorState());
    }
  }

  //////////////////////////getPopularTvShows///////////////////////////////////
  Future<void> fetchPopularTvShows() async {
    emit(cinemaxGetPopularTvShowsLoadingState());
    try {
      popularTvShowsList.clear();
      popularTvShowsList = await DioHelper.getPopularTvShows();
      print(popularTvShowsList.length);
      emit(cinemaxGetPopularTvShowsSuccessState());
    } catch (error) {
      print("Error in fetching Popular Tv Shows : " + error.toString());
      emit(cinemaxGetPopularTvShowsErrorState());
    }
  }

  /////////////////////Categories Movies////////////////////////////////////////
  Future<void> fetchCategoriesMovies(title, index, context, id) async {
    emit(cinemaxGetCategoryLoadingState());
    try {
      categoryMoviesList.clear();
      categoryMoviesList = await DioHelper.getCategoriesMovies(id);
      categoryItem(
        categoryMoviesList,
        index,
        context,
        title,
      );
      print(popularTvShowsList.length);
      emit(cinemaxGetCategorySuccessState());
    } catch (error) {
      print("Error in fetching Popular Tv Shows : " + error.toString());
      emit(cinemaxGetCategoryErrorState());
    }
  }

  //////////////////////////getActionMovies///////////////////////////////////
  Future<void> fetchActionMovies() async {
    emit(cinemaxGetCategoryLoadingState());
    try {
      actionMoviesList.clear();
      actionMoviesList = await DioHelper.fetchActionMovies();
      print(actionMoviesList.length);
      emit(cinemaxGetCategorySuccessState());
    } catch (error) {
      print("Error in fetching category movies : " + error.toString());
      emit(cinemaxGetCategoryErrorState());
    }
  }

  //////////////////////////getDocumentationMovies///////////////////////////////////
  Future<void> fetchDocumentationMovies() async {
    emit(cinemaxGetCategoryLoadingState());
    try {
      documentationMoviesList.clear();
      documentationMoviesList = await DioHelper.fetchDocumentationMovies();
      print(documentationMoviesList.length);
      emit(cinemaxGetCategorySuccessState());
    } catch (error) {
      print("Error in fetching category movies : " + error.toString());
      emit(cinemaxGetCategoryErrorState());
    }
  }
}
