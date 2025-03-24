import 'package:cinemax/Shared/Service/Dio/dio_helper.dart';
import 'package:cinemax/Shared/components.dart';
import 'package:cinemax/Widgets/LayoutWidgets/Home/MovieItemDetail/movie_item_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> searchResults = [];
  List<dynamic> actorsList = []; // Store actors separately
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  void search(String query) async {
    setState(() {
      isLoading = true;
    });

    List<dynamic> results = await DioHelper.searchAll(query);

    // Separate actors from movies & TV shows
    actorsList =
        results.where((item) => item['media_type'] == 'person').toList();
    searchResults =
        results.where((item) => item['media_type'] != 'person').toList();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
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
                    actorsList = [];
                  });
                }
              },
              input: TextInputType.text,
              text: "Search for movies, TV Shows, or Actors...",
              prefix: Icons.search,
            ),
          ),
          if (isLoading)
            CircularProgressIndicator()
          else if (searchResults.isEmpty && actorsList.isEmpty)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/images/searchError.svg",
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: Column(
                children: [
                  // Display actors in a horizontal ListView
                  if (actorsList.isNotEmpty)
                    SizedBox(
                      height: 150, // Adjust height for actor cards
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: actorsList.length,
                        itemBuilder: (context, index) {
                          var actor = actorsList[index];
                          String name = actor["name"] ?? "Unknown Actor";
                          String imageUrl = actor["profile_path"] != null
                              ? "https://image.tmdb.org/t/p/w200${actor["profile_path"]}"
                              : "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541";

                          return Container(
                            width: 100, // Adjust width as needed
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(imageUrl,
                                      width: 80, height: 80, fit: BoxFit.cover),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                  // Display movies and TV shows in a vertical ListView
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
                          subtitle =
                              "Movie - ${result["release_date"] ?? "N/A"}";
                          imageUrl = result["poster_path"] != null
                              ? "https://image.tmdb.org/t/p/w200${result["poster_path"]}"
                              : "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541";
                        } else if (result['media_type'] == 'tv') {
                          title = result["name"] ?? "Unknown TV Show";
                          subtitle =
                              "TV Show - ${result["first_air_date"] ?? "N/A"}";
                          imageUrl = result["poster_path"] != null
                              ? "https://image.tmdb.org/t/p/w200${result["poster_path"]}"
                              : "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541";
                        }

                        return ListTile(
                          leading: Image.network(imageUrl,
                              width: 50, fit: BoxFit.cover),
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
                                "append_to_response": "videos,credits",
                              });

                              var details = detailsResponse.data;

                              // Extract runtime
                              String runtime = details["runtime"]?.toString() ??
                                  ((details["episode_run_time"] != null &&
                                          (details["episode_run_time"] as List)
                                              .isNotEmpty)
                                      ? details["episode_run_time"][0]
                                          .toString()
                                      : "N/A");

                              // Extract trailer URL
                              String trailerURL = "";
                              if (details["videos"]?["results"] != null &&
                                  (details["videos"]["results"] as List)
                                      .isNotEmpty) {
                                var trailer =
                                    (details["videos"]["results"] as List)
                                        .firstWhere(
                                  (video) => video["type"] == "Trailer",
                                  orElse: () => null,
                                );
                                trailerURL = trailer != null
                                    ? "https://www.youtube.com/watch?v=${trailer["key"]}"
                                    : "";
                              }

                              // Extract cast & crew
                              List<Map<String, String>> combinedList = [];
                              if (details.containsKey('credits')) {
                                List<dynamic>? cast =
                                    details['credits']?['cast'];
                                if (cast != null && cast.isNotEmpty) {
                                  combinedList.addAll(
                                    cast
                                        .take(10)
                                        .map((actor) => {
                                              "name":
                                                  (actor['name'] ?? "Unknown")
                                                      .toString(),
                                              "role": (actor['character'] ??
                                                      "Actor")
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
                              }
                              List<dynamic> genresData =
                                  details["genres"] ?? [];
                              List<String> genres = genresData
                                  .map((g) => g["name"].toString())
                                  .toList();
                              // Navigate to detail screen
                              navigateTo(
                                // ignore: use_build_context_synchronously
                                context,
                                MovieItemDetailScreen(
                                  id: details['id'],
                                  title: details["title"] ??
                                      details["name"] ??
                                      "Unknown",
                                  trailerURL: trailerURL,
                                  genre: details["genres"]?.isNotEmpty ?? false
                                      ? details["genres"][0]["name"]
                                      : "Unknown",
                                  cast: combinedList,
                                  runTime: runtime,
                                  genres: genres,
                                  posterImage: imageUrl,
                                  rate: details["vote_average"]
                                          ?.toString()
                                          .substring(0, 3) ??
                                      "N/A",
                                  year:
                                      details["release_date"]?.split("-")[0] ??
                                          "Unknown",
                                  popularity:
                                      details["popularity"]?.toString() ??
                                          "N/A",
                                  overview: details["overview"] ??
                                      "No overview available",
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
