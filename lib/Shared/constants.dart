import 'package:flutter/material.dart';

const Color primaryColor = Colors.cyan;
String fullName = "";
String? uId = "";
List<int> genreId = [
  28,
  12,
  16,
  35,
  80,
  99,
  18,
  10751,
  14,
  36,
  27,
  10402,
  9648,
  10749,
  878,
  10770,
  53,
  10752,
  37
];

List<String> genreName = [
  "Action",
  "Adventure",
  "Animation",
  "Comedy",
  "Crime",
  "Documentary",
  "Drama",
  "Family",
  "Fantasy",
  "History",
  "Horror",
  "Music",
  "Mystery",
  "Romance",
  "Science Fiction",
  "TV Movie",
  "Thriller",
  "War",
  "Western"
];

String formatReleaseDate(String releaseDate) {
  try {
    DateTime date = DateTime.parse(releaseDate);
    List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];

    return "On ${months[date.month - 1]} ${date.day}, ${date.year}";
  } catch (e) {
    return "Release Date Unavailable";
  }
}
