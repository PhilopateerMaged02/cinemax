import 'package:bloc/bloc.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Widgets/AuthunticationWidgets/SignupWidget/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class cinemaxRegisterCubit extends Cubit<cinemaxRegisterStates> {
  cinemaxRegisterCubit() : super(cinemaxRegisterInitialState());
  static cinemaxRegisterCubit get(context) => BlocProvider.of(context);

  void Register(
      {required String email,
      required String password,
      required String name}) async {
    emit(cinemaxRegisterLoadingState());
    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      await FirebaseFirestore.instance.collection("users").doc().set({
        "uId": user!.uid,
        "email": email,
        "name": name,
        "phone": "+20000000000",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
      });
      emit(cinemaxRegisterSuccessState());
    } catch (error) {
      emit(cinemaxRegisterErrorState());
      print("ERROR IN REGISTER : " + error.toString());
    }
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
