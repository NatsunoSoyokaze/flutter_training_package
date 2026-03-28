class Staff {
  final String title;
  final String name;

  const Staff({
    required this.title,
    required this.name,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      title: json['title'],
      name: json['name'],
    );
  }
}