import 'package:bloc/bloc.dart';
import 'package:cinemax/Shared/Service/SharedPrefrences/shared_prefrences.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Widgets/AuthunticationWidgets/LoginWidget/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class cinemaxLoginCubit extends Cubit<cinemaxLoginStates> {
  cinemaxLoginCubit() : super(cinemaxLoginInitialState());
  static cinemaxLoginCubit get(context) => BlocProvider.of(context);
  void Login({required String email, required String password}) async {
    emit(cinemaxLoginLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uId = FirebaseAuth.instance.currentUser!.uid;
      SharedPrefrencesSingleton.setString('uId', uId!);
      emit(cinemaxLoginSuccessState());
    }).catchError((error) {
      emit(cinemaxLoginErrorState());
      print("ERROR IN Login : " + error.toString());
    });
  }

  bool visibility1 = true;
  IconData suffix1 = Icons.visibility_outlined;
  void changeVisibility1() {
    visibility1 = !visibility1;
    suffix1 =
        visibility1 ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(cinemaxChangePasswordVisibilityState());
  }
}
