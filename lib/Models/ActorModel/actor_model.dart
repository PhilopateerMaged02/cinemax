class ActorModel {
  int id;
  String name;
  String character;
  String profilePath;

  ActorModel({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return ActorModel(
      id: json['id'],
      name: json['name'] ?? "Unknown Actor",
      character: json['character'] ?? "Unknown Character",
      profilePath: json['profile_path'] != null
          ? "https://image.tmdb.org/t/p/w500${json['profile_path']}"
          : "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png",
    );
  }
}
