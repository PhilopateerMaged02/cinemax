class ProductionCompany {
  int id;
  String name;
  String logoPath;
  String originCountry;

  ProductionCompany({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'] ?? 0,
      name: json['name'] ?? "Unknown",
      logoPath: json['logo_path'] ?? "",
      originCountry: json['origin_country'] ?? "Unknown",
    );
  }
}
