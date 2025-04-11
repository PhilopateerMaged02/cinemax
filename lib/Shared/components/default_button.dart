import 'package:cinemax/Shared/constants.dart';
import 'package:flutter/material.dart';

Widget buildDefaultButton(
    {required String text,
    required VoidCallback onPressed,
    required double height,
    required double width,
    required Color? color}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        color: color,
        borderRadius: BorderRadius.circular(25)),
    child: TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}
