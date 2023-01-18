class MovieSummary {
  const MovieSummary({
    required this.id,
    required this.resultType,
    required this.image,
    required this.title,
    required this.description,
  });

  final String id;
  final String resultType;
  final String image;
  final String title;
  final String description;

  factory MovieSummary.fromJson(Map<String, dynamic> json) {
    return MovieSummary(
      id: json['id']!,
      resultType: json['resultType']!,
      image: json['image']!,
      title: json['title']!,
      description: json['description']!,
    );
  }
}
