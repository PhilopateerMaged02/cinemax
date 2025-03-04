import 'dart:convert';
import 'dart:developer';

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
      List<MoviesModel> allPopularMovies = [];

      for (int i = 1; i <= 10; i++) {
        // Fetch up to 10 pages
        Response response =
            await DioHelper.dio.get("movie/popular", queryParameters: {
          "language": "en-US",
          "page": i,
        });

        if (response.statusCode == 200) {
          List<MoviesModel> movies = (response.data['results'] as List)
              .map((movie) => MoviesModel.fromJson(movie))
              .toList();

          allPopularMovies.addAll(movies); // Append movies from each page
        } else {
          throw Exception(
              "Failed to load movies (Status Code: ${response.statusCode})");
        }
      }

      print(
          "✅ Popular Movies Fetched Successfully: ${allPopularMovies.length} items");
      return allPopularMovies;
    } catch (e) {
      print("❌ Error fetching popular movies: $e");
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

  static Future<List<MoviesModel>> getTopRatedMovies() async {
    try {
      List<MoviesModel> allTopMovies = [];

      for (int i = 1; i <= 10; i++) {
        Response response =
            await DioHelper.dio.get("movie/top_rated", queryParameters: {
          "language": "en-US",
          "page": i,
        });

        if (response.statusCode == 200) {
          List<MoviesModel> movies = (response.data['results'] as List)
              .map((movie) => MoviesModel.fromJson(movie))
              .toList();

          allTopMovies.addAll(movies); // Append results from each page
        } else {
          throw Exception(
              "Failed to load Top movies (Status Code: ${response.statusCode})");
        }
      }

      print(
          "✅ Top Rated Movies Fetched Successfully: ${allTopMovies.length} items");
      return allTopMovies;
    } catch (e) {
      print("❌ Error fetching Top movies: $e");
      return [];
    }
  }

  static Future<List<MoviesModel>> getPopularTvShows() async {
    try {
      List<MoviesModel> allTvShows = [];

      for (int i = 1; i <= 10; i++) {
        Response response =
            await DioHelper.dio.get("tv/popular", queryParameters: {
          "language": "en-US",
          "page": i,
        });

        if (response.statusCode == 200) {
          List<MoviesModel> tvShows = (response.data['results'] as List)
              .map((tvShow) => MoviesModel.fromJson(tvShow))
              .toList();

          allTvShows.addAll(tvShows);
          print("length of the full list of popular tv : " +
              allTvShows.length.toString()); // Append results from each page
        } else {
          throw Exception(
              "Failed to load TV shows (Status Code: ${response.statusCode})");
        }
      }

      print(
          "✅ Popular TV Shows Fetched Successfully: ${allTvShows.length} items");
      return allTvShows;
    } catch (e) {
      print("❌ Error fetching TV shows: $e");
      return [];
    }
  }

  static Future<MoviesModel?> fetchMovieDetails(int movieId) async {
    try {
      Response response = await DioHelper.dio.get(
        "movie/$movieId",
        queryParameters: {
          "language": "en-US",
          "append_to_response": "videos,credits"
        },
      );

      if (response.statusCode == 200) {
        //log("✅ Full API Response: ${jsonEncode(response.data)}");
        //log("🟡 Checking runtime: ${response.data['runtime']}");
        return MoviesModel.fromJson(response.data);
      } else {
        throw Exception(
            "Failed to load movie details (Status: ${response.statusCode})");
      }
    } catch (e) {
      print("❌ Error fetching movie details: $e");
      return null;
    }
  }

  static Future<List<dynamic>> searchAll(String query) async {
    if (query.isEmpty) return [];

    try {
      Response response = await DioHelper.dio.get(
        "search/multi",
        queryParameters: {
          "query": query,
        },
      );

      if (response.statusCode == 200) {
        return response.data['results'];
      } else {
        print("Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Search error: $e");
      return [];
    }
  }

  static Future<List<MoviesModel>> getCategoriesMovies(int id) async {
    try {
      Response response = await DioHelper.dio.get(
        "discover/movie",
        queryParameters: {
          "with_genres": id,
          "language": "en-US",
          "sort_by": "popularity.desc",
          "page": 1,
        },
      );

      if (response.statusCode == 200) {
        print("✅ Action Movies Fetched Successfully:");
        return (response.data['results'] as List)
            .map((movie) => MoviesModel.fromJson(movie))
            .toList();
      } else {
        throw Exception(
            "Failed to load Action movies (Status Code: ${response.statusCode})");
      }
    } catch (e) {
      print("❌ Error fetching Action movies: $e");
      return [];
    }
  }

  static Future<List<MoviesModel>> fetchActionMovies() async {
    try {
      List<MoviesModel> allActionMovies = [];

      for (int i = 1; i <= 10; i++) {
        // Fetch up to 10 pages
        Response response =
            await DioHelper.dio.get("discover/movie", queryParameters: {
          "language": "en-US",
          "with_genres": 28,
          "sort_by": "popularity.desc",
          "page": i,
        });

        if (response.statusCode == 200) {
          List<MoviesModel> movies = (response.data['results'] as List)
              .map((movie) => MoviesModel.fromJson(movie))
              .toList();

          allActionMovies.addAll(movies); // Append movies from each page
        } else {
          throw Exception(
              "Failed to load movies (Status Code: ${response.statusCode})");
        }
      }

      print(
          "✅ Action Movies Fetched Successfully: ${allActionMovies.length} items");
      return allActionMovies;
    } catch (e) {
      print("❌ Error fetching popular movies: $e");
      return [];
    }
  }

  static Future<List<MoviesModel>> fetchDocumentationMovies() async {
    try {
      List<MoviesModel> allDocumentationMovies = [];

      for (int i = 1; i <= 10; i++) {
        // Fetch up to 10 pages
        Response response =
            await DioHelper.dio.get("discover/movie", queryParameters: {
          "language": "en-US",
          "with_genres": 99,
          "sort_by": "popularity.desc",
          "page": i,
        });

        if (response.statusCode == 200) {
          List<MoviesModel> movies = (response.data['results'] as List)
              .map((movie) => MoviesModel.fromJson(movie))
              .toList();

          allDocumentationMovies.addAll(movies); // Append movies from each page
        } else {
          throw Exception(
              "Failed to load movies (Status Code: ${response.statusCode})");
        }
      }

      print(
          "✅ Documentation Movies Fetched Successfully: ${allDocumentationMovies.length} items");
      return allDocumentationMovies;
    } catch (e) {
      print("❌ Error fetching popular movies: $e");
      return [];
    }
  }
}
