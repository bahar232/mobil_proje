class Expert {
  final String name;
  final String count;
  final String image;
  final String star;

  Expert(
      {required this.name,
      required this.count,
      required this.image,
      required this.star});

  Map<String, dynamic> toMap() =>
      {'name': name, 'count': count, 'image': image, 'star': star};

  factory Expert.fromMap(map) => Expert(
      name: map['name'] ?? "",
      count: map['count'] ?? "",
      image: map['image'] ?? "",
      star: map['star'] ?? "");
}
