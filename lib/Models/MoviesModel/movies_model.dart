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

  MoviesModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      id: json['id'],
      title: json['title'] ?? "No Title",
      overview: json['overview'] ?? "No Overview",
      posterPath: json['poster_path'] ?? "",
      backdropPath: json['backdrop_path'] ?? "",
      releaseDate: json['release_date'] ?? "Unknown",
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      popularity: (json['popularity'] ?? 0).toDouble(),
    );
  }
}
