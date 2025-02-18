import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemax/Models/MoviesModel/movies_model.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToust({
  required String message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: message,
    textColor: Colors.white,
    backgroundColor: chooseToastColor(state),
    fontSize: 16,
    timeInSecForIosWeb: 5,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_LONG,
  );
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Future navigateTo(context, widget) {
  return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

Future navigatoToWithAnimation(context, widget) {
  return Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = 0.0;
        var end = 1.0;
        var curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var scaleAnimation = animation.drive(tween);
        return ScaleTransition(
          scale: scaleAnimation,
          child: child,
        );
      },
    ),
  );
}

Future navigateToandKill(context, widget) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

Widget buildDefaultButton({
  required String text,
  required VoidCallback onPressed,
  required double height,
  required double width,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: primaryColor, borderRadius: BorderRadius.circular(25)),
    child: TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType input,
  Function(String)? onFieldSubmitted,
  Function(String)? onChanged,
  Function()? onTap,
  bool isObscure = false,
  FormFieldValidator<String>? onValidator,
  required String text,
  required IconData prefix,
  IconData? suffix,
  Function()? onSuffix,
  bool isClickable = true,
}) =>
    TextFormField(
      cursorColor: primaryColor,
      controller: controller,
      keyboardType: input,
      obscureText: isObscure,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      validator: onValidator,
      onTap: onTap,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: primaryColor),
        ),
        prefixIcon: Icon(prefix, color: Colors.grey),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: onSuffix,
                icon: Icon(suffix, color: Colors.grey),
              )
            : null,
      ),
    );
Widget Sliders(bool isActive) {
  return CircleAvatar(
    radius: 5,
    backgroundColor: isActive ? primaryColor : Colors.grey,
  );
}

Widget CarouselItem(MoviesModel model) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(20)),
            width: double.infinity,
            child: Container(
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
            model.releaseDate,
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ],
    ),
  );
}

Widget categoryItem(index) {
  List<String> genreName = [
    "All",
    "Action",
    "Documentation",
    "Tragedy",
    "Comedy",
    "Drama",
    "Animation"
  ];
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[800],
      borderRadius: BorderRadius.circular(25),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Text("${genreName[index]}"),
    ),
  );
}
