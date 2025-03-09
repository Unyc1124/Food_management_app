import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:foodm/models/meal_plan_model.dart';
import 'package:foodm/views/screens/add_plan_screen.dart';
import 'package:foodm/mobx/meal_plan_store.dart';
import 'package:foodm/views/screens/feedback_screen.dart';
import 'package:foodm/views/screens/meal_track_screen.dart';
import 'package:foodm/views/screens/menu_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodm/views/screens/set_plan_screen.dart';

final List<Widget> _tabs = [
  const MealPlanScreen(),
  const MenuScreen(),
  const MealTrackScreen(),
  const FeedbackScreen(),
];

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({super.key});

  @override
  State<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  final MealPlanStore store = MealPlanStore(); // Instantiate the MobX store

  @override
  void initState() {
    super.initState();
    store.loadMealPlansFromSharedPreferences(); // Ensure shared prefs loading on init
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: const Color(0xFF2E303C),
        appBar: AppBar(
          titleSpacing: 0, // Reduces space between back arrow and title
          title: Text(
            'Food Management',
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color(0xFF2E303C),
          actions: [
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPlanScreen(store: store),
                  ),
                );
              },
              icon: const Icon(Icons.add, color: Color(0xFF49ABE8)), // '+' icon
              label: const Text(
                "Add Plan",
                style: TextStyle(
                  color: Color(0xFF49ABE8),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
          bottom: const TabBar(
            labelColor: Color(0xFF49ABE8), // Active icon and text color
            unselectedLabelColor: Colors.white70,
            indicatorColor: Color(0xFF49ABE8),
            tabs: [
              Tab(icon: Icon(Icons.food_bank, color: Color(0xFFD1E9F5)), text: 'Meal Plan'),
              Tab(icon: Icon(Icons.menu_open_rounded, color: Color(0xFFD1E9F5)), text: 'Menu'),
              Tab(icon: Icon(Icons.menu_book, color: Color(0xFFD1E9F5)), text: 'Meal Track'),
              Tab(icon: Icon(Icons.rate_review_rounded, color: Color(0xFFD1E9F5)), text: 'Feedback'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MealPlanContent(store: store),
            const MenuScreen(),
            const MealTrackScreen(),
            const FeedbackScreen(),
          ],
        ),
      ),
    );
  }
}


class MealPlanContent extends StatelessWidget {
  final MealPlanStore store;

  const MealPlanContent({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (store.mealPlans.isEmpty) {
          return const Center(child: Text('No meal plans available.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: store.mealPlans.length,
          itemBuilder: (context, index) {
            final plan = store.mealPlans[index];
            return MealPlanCard(
              plan: plan,
              onDelete: () async {
                await store.removeMealPlan(plan.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${plan.name} has been deleted.')),
                );
              },
            );
          },
        );
      },
    );
  }
}

class MealPlanCard extends StatelessWidget {
  final MealPlan plan;
  final VoidCallback onDelete;

  const MealPlanCard({
    super.key,
    required this.plan,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SetPlanScreen(),
          ),
        );
      },
      child:  Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      child: Column(
        children: [
          // Top Section (Title & Delete Button) - Fixed Height
          Container(
            height: 50, // Ensuring same height as amount section
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: Color(0xFFD1D1D1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  plan.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.grey),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),

          // Middle Section (Meal List)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: const Color(0xFF1C1E26),
            child: Column(
              children: [
                // Meal items displayed in two columns, centered
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center align
                  children: [
                    // First column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: plan.meals
                          .take((plan.meals.length / 2).ceil())
                          .map((meal) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6.0),
                                child: Text(
                                  "• ${meal.type}",
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ))
                          .toList(),
                    ),

                    const SizedBox(width: 30), // Spacing between columns

                    // Second column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: plan.meals
                          .skip((plan.meals.length / 2).ceil())
                          .map((meal) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6.0),
                                child: Text(
                                  "• ${meal.type}",
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bottom Section (Amount) - Same Height as Title Section
          Container(
            height: 50, // Ensuring same height as title section
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
               color: Color(0xFF393F5E),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Amount:",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  "₹ ${plan.amount}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF49ABE8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}