import 'package:bloc/bloc.dart';
import 'package:cinemax/Models/MoviesModel/movies_model.dart';
import 'package:cinemax/Shared/Service/Dio/dio_helper.dart';
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
  void getUserData() async {
    String? UserName =
        await FirebaseAuth.instance.currentUser!.displayName ?? "No Name Found";
    String? UserEmail =
        await FirebaseAuth.instance.currentUser!.email ?? "No email Found";
    String? UserUid =
        await FirebaseAuth.instance.currentUser!.uid ?? "No uId Found";
    await FirebaseFirestore.instance.collection("users").doc(uId).get();

    print("user id = " + UserUid);
    print("user name = " + UserName);
    print("user email = " + UserEmail);
  }

  //////////////////////////////////////////////////////////////////////////////
  ///
  //////////////////////////getUpComingMovies///////////////////////////////////
  List<MoviesModel> upComingMoviesList = [];
  List<MoviesModel> popularMoviesList = [];

  Future<void> fetchUpComingMovies() async {
    emit(cinemaxGetUpComingMoviesLoadingState());
    try {
      upComingMoviesList = await DioHelper.getUpComingMovies();
      print(upComingMoviesList[0]);
      emit(cinemaxGetUpComingMoviesSuccessState());
    } catch (error) {
      print("Error in fetching upcoming movies : " + error.toString());
      emit(cinemaxGetUpComingMoviesErrorState());
    }
  }

  Future<void> fetchPopularMovies() async {
    emit(cinemaxGetoPopularMoviesLoadingState());
    try {
      popularMoviesList = await DioHelper.fetchPopularMovies();
      print(popularMoviesList[0]);
      emit(cinemaxGetPopularMoviesSuccessState());
    } catch (error) {
      print("Error in fetching popular movies : " + error.toString());
      emit(cinemaxGetPopularMoviesErrorState());
    }
  }
}
