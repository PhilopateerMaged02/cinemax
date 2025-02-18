import 'package:cinemax/Models/MoviesModel/movies_model.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  // Initialize Dio with BaseOptions
  static void initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://api.themoviedb.org/3/",
        headers: {
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjOTBmZTllNWI5OGY0M2UzMDc1MjkwYzE2MDIzMjQ4MSIsIm5iZiI6MTczOTU3MjM2Ny42MzYsInN1YiI6IjY3YWZjNDhmYWMwODhhNDE0NTZjMzM3ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Iky2hQ50W_t7vaHRJ6Qn0XQ-0fVBPASwKXtji3PuXF0",
          'Content-Type': 'application/json',
        },
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<List<MoviesModel>> fetchPopularMovies() async {
    try {
      Response response =
          await DioHelper.dio.get("movie/popular", queryParameters: {
        "language": "en-US",
        "page": 1,
      });

      if (response.statusCode == 200) {
        return (response.data['results'] as List)
            .map((movie) => MoviesModel.fromJson(movie))
            .toList();
      } else {
        throw Exception(
            "Failed to load movies (Status Code: ${response.statusCode})");
      }
    } catch (e) {
      print("❌ Error fetching movies: $e");
      return [];
    }
  }

  static Future<List<MoviesModel>> getUpComingMovies() async {
    try {
      Response response = await DioHelper.dio.get(
        "movie/upcoming",
        //     queryParameters: {
        //   "language": "en-US",
        //   "page": 1,
        // }
      );

      if (response.statusCode == 200) {
        print("✅ UPCOMING  Movies Fetched Successfully:");
        return (response.data['results'] as List)
            .map((movie) => MoviesModel.fromJson(movie))
            .toList();
      } else {
        throw Exception(
            "Failed to load movies (Status Code: ${response.statusCode})");
      }
    } catch (e) {
      print("❌ Error fetching movies: $e");
      return [];
    }
  }
}
