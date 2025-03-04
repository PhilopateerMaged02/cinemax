import 'dart:convert';
import 'package:cinemax/Shared/Service/Dio/dio_helper.dart';
import 'package:cinemax/Shared/components.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Home/MovieItemDetail/movie_item_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> searchResults = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  void search(String query) async {
    setState(() {
      isLoading = true;
    });

    searchResults = await DioHelper.searchAll(query);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: defaultFormField(
                controller: searchController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    search(value);
                  } else {
                    setState(() {
                      searchResults = [];
                    });
                  }
                },
                input: TextInputType.text,
                text: "Search for movies, TV shows, or actors...",
                prefix: Icons.search),
          ),
          if (isLoading)
            CircularProgressIndicator()
          else if (searchResults.isEmpty)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/images/searchError.svg", // Correct way to load an SVG
                    width: 200, // Adjust size as needed
                    height: 200,
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  var result = searchResults[index];
                  String title = "";
                  String subtitle = "";
                  String imageUrl = "";

                  if (result['media_type'] == 'movie') {
                    title = result["title"] ?? "Unknown Movie";
                    subtitle = "Movie - ${result["release_date"] ?? "N/A"}";
                    imageUrl = result["poster_path"] != null
                        ? "https://image.tmdb.org/t/p/w200${result["poster_path"]}"
                        : "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541";
                  } else if (result['media_type'] == 'tv') {
                    title = result["name"] ?? "Unknown TV Show";
                    subtitle = "TV Show - ${result["first_air_date"] ?? "N/A"}";
                    imageUrl = result["poster_path"] != null
                        ? "https://image.tmdb.org/t/p/w200${result["poster_path"]}"
                        : "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541";
                  } else if (result['media_type'] == 'person') {
                    title = result["name"] ?? "Unknown Actor";
                    subtitle = "Actor";
                    imageUrl = result["profile_path"] != null
                        ? "https://image.tmdb.org/t/p/w200${result["profile_path"]}"
                        : "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541";
                  }

                  return ListTile(
                      leading:
                          Image.network(imageUrl, width: 50, fit: BoxFit.cover),
                      title: Text(title),
                      subtitle: Text(subtitle),
                      onTap: () async {
                        if (result['media_type'] == "movie" ||
                            result['media_type'] == "tv") {
                          int id = result["id"];
                          String type = result["media_type"];

                          var detailsResponse = await DioHelper.dio
                              .get("$type/$id", queryParameters: {
                            "language": "en-US",
                            "append_to_response":
                                "videos,credits", // Fetch trailer & cast
                          });

                          var details = detailsResponse.data;

                          // Extract runtime
                          String runtime = details["runtime"]?.toString() ??
                              ((details["episode_run_time"] != null &&
                                      (details["episode_run_time"] as List)
                                          .isNotEmpty)
                                  ? details["episode_run_time"][0].toString()
                                  : "N/A");

                          // Extract trailer URL
                          String trailerURL = "";
                          if (details["videos"]?["results"] != null &&
                              (details["videos"]["results"] as List)
                                  .isNotEmpty) {
                            var trailer = (details["videos"]["results"] as List)
                                .firstWhere(
                                    (video) => video["type"] == "Trailer",
                                    orElse: () => null);
                            trailerURL = trailer != null
                                ? "https://www.youtube.com/watch?v=${trailer["key"]}"
                                : "";
                          }

                          // Extract cast & crew
                          List<Map<String, String>> combinedList = [];

                          if (details.containsKey('credits')) {
                            List<dynamic>? cast = details['credits']?['cast'];
                            if (cast != null && cast.isNotEmpty) {
                              combinedList.addAll(
                                cast
                                    .take(10)
                                    .map((actor) => {
                                          "name": (actor['name'] ?? "Unknown")
                                              .toString(),
                                          "role":
                                              (actor['character'] ?? "Actor")
                                                  .toString(),
                                          "image": ((actor['profile_path'] !=
                                                          null &&
                                                      actor['profile_path']
                                                          .toString()
                                                          .isNotEmpty)
                                                  ? "https://image.tmdb.org/t/p/w200${actor['profile_path']}"
                                                  : "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541")
                                              .toString()
                                        })
                                    .toList(),
                              );
                            }

                            List<dynamic>? crew = details['credits']?['crew'];
                            if (crew != null && crew.isNotEmpty) {
                              combinedList.addAll(
                                crew
                                    .where((member) =>
                                        member['job'] == "Director" ||
                                        member['job'] == "Writer" ||
                                        member['job'] == "Producer")
                                    .map((crewMember) => {
                                          "name":
                                              (crewMember['name'] ?? "Unknown")
                                                  .toString(),
                                          "role": (crewMember['job'] ?? "Crew")
                                              .toString(),
                                          "image": ((crewMember[
                                                              'profile_path'] !=
                                                          null &&
                                                      crewMember['profile_path']
                                                          .toString()
                                                          .isNotEmpty)
                                                  ? "https://image.tmdb.org/t/p/w200${crewMember['profile_path']}"
                                                  : "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541")
                                              .toString()
                                        })
                                    .toList(),
                              );
                            }
                          }

                          setState(() {});

                          // Extract genres
                          List<dynamic> genresData = details["genres"] ?? [];
                          List<String> genres = genresData
                              .map((g) => g["name"].toString())
                              .toList();
                          String firstGenre = genres.isNotEmpty
                              ? genres.first.substring(0, 4)
                              : "Unknown";

                          // Navigate to detail screen
                          navigateTo(
                            context,
                            MovieItemDetailScreen(
                              title: details["title"] ??
                                  details["name"] ??
                                  "Unknown",
                              trailerURL: trailerURL,
                              genre: firstGenre,
                              genres: genres,
                              cast: combinedList,
                              runTime: runtime,
                              posterImage: result["poster_path"] != null
                                  ? "https://image.tmdb.org/t/p/w500${result["poster_path"]}"
                                  : "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
                              rate: details["vote_average"]
                                      ?.toString()
                                      .substring(0, 3) ??
                                  "N/A",
                              year: (details["release_date"] ??
                                      details["first_air_date"] ??
                                      "Unknown")
                                  .split("-")[0]
                                  .toString(),
                              popularity:
                                  details["popularity"]?.toString() ?? "N/A",
                              overview: details["overview"] ??
                                  "No overview available",
                            ),
                          );
                        }
                      });
                },
              ),
            ),
        ],
      ),
    );
  }
}
