import 'package:flutter/material.dart';
import 'package:foodm/models/meal_plan_model.dart';

class MealPlanDetailScreen extends StatelessWidget {
  final MealPlan mealPlan;

  const MealPlanDetailScreen({super.key, required this.mealPlan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mealPlan.name),
      ),
      body: Padding(
       

        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              mealPlan.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text("Frequency: ${mealPlan.frequency}", style: const TextStyle(fontSize: 18)),
            Text("Amount: ₹${mealPlan.amount}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Text("Meals", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...mealPlan.meals.map(
              (meal) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  child: ListTile(
                    title: Text(meal.type),
                    subtitle: Text(
                      "Start Time: ${meal.startTime}\nEnd Time: ${meal.endTime}\nItems: ${meal.items.join(', ')}",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
