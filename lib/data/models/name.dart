class Name {
  const Name({required this.id, required this.name});

  final String id;
  final String name;

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      id: json['id'],
      name: json['name'],
    );
  }
}
