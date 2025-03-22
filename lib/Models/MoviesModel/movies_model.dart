class MoviesModel {
  int id;
  String title;
  String overview;
  String posterPath;
  String backdropPath;
  String releaseDate;
  double voteAverage;
  int voteCount;
  double popularity;
  int runtime;
  List<String> genres;
  List<Map<String, String>> castAndCrew;
  List<String> trailers;
  String? mainTrailer;

  MoviesModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.trailers,
    required this.voteCount,
    required this.popularity,
    required this.runtime,
    required this.genres,
    required this.castAndCrew,
    this.mainTrailer,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    List<Map<String, String>> combinedList = [];

    List<dynamic>? cast = json['credits']?['cast'];
    if (cast != null) {
      combinedList.addAll(cast.take(10).map((actor) => {
            "name": actor['name'] ?? "Unknown",
            "role": actor['character'] ?? "Actor",
            "image": actor['profile_path'] != null
                ? "https://image.tmdb.org/t/p/w200${actor['profile_path']}"
                : "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
          }));
    }

    List<dynamic>? crew = json['credits']?['crew'];
    if (crew != null) {
      combinedList.addAll(crew
          .where((member) =>
              member['job'] == "Director" ||
              member['job'] == "Writer" ||
              member['job'] == "Producer")
          .map((crewMember) => {
                "name": crewMember['name'] ?? "Unknown",
                "role": crewMember['job'] ?? "Crew",
                "image": crewMember['profile_path'] != null
                    ? "https://image.tmdb.org/t/p/w200${crewMember['profile_path']}"
                    : "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
              }));
    }

    List<dynamic> videos = json['videos']?['results'] ?? [];
    List<String> trailersList = videos
        .where((video) => video['site'] == 'YouTube')
        .map((video) => "https://www.youtube.com/watch?v=${video['key']}")
        .toList();

    String? trailerUrl;
    var trailer = videos.firstWhere(
        (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
        orElse: () => null);
    var teaser = videos.firstWhere(
        (video) => video['type'] == 'Teaser' && video['site'] == 'YouTube',
        orElse: () => null);
    var firstVideo = videos.firstWhere((video) => video['site'] == 'YouTube',
        orElse: () => null);

    if (trailer != null) {
      trailerUrl = "https://www.youtube.com/watch?v=${trailer['key']}";
    } else if (teaser != null) {
      trailerUrl = "https://www.youtube.com/watch?v=${teaser['key']}";
    } else if (firstVideo != null) {
      trailerUrl = "https://www.youtube.com/watch?v=${firstVideo['key']}";
    }

    return MoviesModel(
      id: json['id'],
      title: json['title'] ?? "No Title",
      overview: json['overview'] ?? "No Overview",
      posterPath: json['poster_path'] != null && json['poster_path'].isNotEmpty
          ? "https://image.tmdb.org/t/p/w500${json['poster_path']}"
          : "https://www.juliedray.com/wp-content/uploads/2022/01/sans-affiche.png",
      backdropPath: json['backdrop_path'] != null &&
              json['backdrop_path'].isNotEmpty
          ? "https://image.tmdb.org/t/p/w500${json['backdrop_path']}"
          : "https://www.juliedray.com/wp-content/uploads/2022/01/sans-affiche.png",
      releaseDate: json['release_date'] ?? "Unknown",
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      popularity: (json['popularity'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((genre) => genre['name'] as String)
              .toList() ??
          [],
      castAndCrew: combinedList,
      trailers: trailersList,
      mainTrailer: trailerUrl,
    );
  }
}
