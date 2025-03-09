class MealPlan {
  final String id;
  final String name;
  final String frequency;
  final int amount;
  final List<Meal> meals;

  MealPlan({
    required this.id,
    required this.name,
    required this.frequency,
    required this.amount,
    required this.meals,
  });

  // Deserialize a MealPlan from a JSON object
  factory MealPlan.fromJson(Map<String, dynamic> json) {
    return MealPlan(
      id: json['id'],
      name: json['name'],
      frequency: json['frequency'],
      amount: json['amount'],
      meals: (json['meals'] as List)
          .map((mealJson) => Meal.fromJson(mealJson))
          .toList(),
    );
  }

  // Serialize a MealPlan to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'frequency': frequency,
      'amount': amount,
      'meals': meals.map((meal) => meal.toJson()).toList(),
    };
  }
}

class Meal {
  final String type;
   String startTime;
   String endTime;
  final List<String> items;

  Meal({
    required this.type,
    required this.startTime,
    required this.endTime,
    required this.items,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      type: json['type'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      items: List<String>.from(json['items']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'startTime': startTime,
      'endTime': endTime,
      'items': items,
    };
  }
}
