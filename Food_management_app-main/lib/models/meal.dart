class Meal {
  final String type;
  final List<String> items;

  Meal({required this.type, required this.items});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      type: json['type'],
      items: List<String>.from(json['items']),
    );
  }
}
