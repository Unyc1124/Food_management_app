import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:foodm/models/meal_plan_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'meal_plan_store.g.dart';

class MealPlanStore = _MealPlanStoreBase with _$MealPlanStore;

abstract class _MealPlanStoreBase with Store {
  @observable
  ObservableList<MealPlan> mealPlans = ObservableList<MealPlan>();

  @observable
  String selectedFrequency = 'Monthly';

  // Save meal plans to shared preferences
  @action
  Future<void> saveMealPlansToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Convert meal plans to JSON string
    final mealPlansJson = mealPlans.map((plan) => plan.toJson()).toList();
    await prefs.setString('mealPlans', jsonEncode(mealPlansJson));
  }

  // Load meal plans from shared preferences
  @action
  Future<void> loadMealPlansFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Retrieve meal plans JSON string
    final mealPlansString = prefs.getString('mealPlans');
    if (mealPlansString != null) {
      // Convert JSON string back to list of MealPlan objects
      final decodedPlans = jsonDecode(mealPlansString) as List<dynamic>;
      mealPlans = ObservableList.of(
        decodedPlans.map((planJson) => MealPlan.fromJson(planJson)),
      );
    }
  }

  // Add a new meal plan and save to shared preferences
  @action
  Future<void> addMealPlan(MealPlan plan) async {
    mealPlans.add(plan);
    await saveMealPlansToSharedPreferences(); // Save updated meal plans
  }

  // Remove a meal plan by ID and save to shared preferences
  @action
  Future<void> removeMealPlan(String id) async {
    mealPlans.removeWhere((plan) => plan.id == id);
    await saveMealPlansToSharedPreferences(); // Save updated meal plans
  }

  // Set the frequency for the meal plan
  @action
  void setFrequency(String frequency) {
    selectedFrequency = frequency;
  }
}
