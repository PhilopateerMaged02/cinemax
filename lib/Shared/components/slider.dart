import 'package:cinemax/Shared/constants.dart';
import 'package:flutter/material.dart';

Widget Sliders(bool isActive) {
  return CircleAvatar(
    radius: 5,
    backgroundColor: isActive ? primaryColor : Colors.grey,
  );
}
