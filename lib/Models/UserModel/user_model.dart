class UserModel {
  String uId;
  String name;
  String email;
  String phone;
  String image;
  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.image,
    required this.phone,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'] ?? "No uId",
      name: json['name'] ?? "No name",
      email: json['email'] ?? "No email",
      image: json['image'] ??
          "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
      phone: json['phone'] ?? "No Phone",
    );
  }
}
