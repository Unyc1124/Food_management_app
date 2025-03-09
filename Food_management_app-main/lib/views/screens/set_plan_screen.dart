import 'package:flutter/material.dart';
import 'package:foodm/models/meal_plan_model.dart';

class SetPlanScreen extends StatefulWidget {
  final MealPlan? initialPlan;

  const SetPlanScreen({super.key, this.initialPlan});

  @override
  State<SetPlanScreen> createState() => _SetPlanScreenState();
}

class _SetPlanScreenState extends State<SetPlanScreen> {
  final Map<String, Meal> _meals = {
    "Breakfast": Meal(type: "Breakfast", startTime: "08:00", endTime: "09:00", items: []),
    "Lunch": Meal(type: "Lunch", startTime: "12:00", endTime: "13:00", items: []),
    "Snacks": Meal(type: "Snacks", startTime: "16:00", endTime: "16:30", items: []),
    "Dinner": Meal(type: "Dinner", startTime: "19:00", endTime: "20:00", items: []),
  };

  @override
  void initState() {
    super.initState();
    if (widget.initialPlan != null) {
      for (var meal in widget.initialPlan!.meals) {
        _meals[meal.type] = meal;
      }
    }
  }

  Future<void> _pickTime(BuildContext context, String mealType, bool isStartTime) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        String formattedTime = pickedTime.format(context);
        if (isStartTime) {
          _meals[mealType]?.startTime = formattedTime;
        } else {
          _meals[mealType]?.endTime = formattedTime;
        }
      });
    }
  }

  void _addItem(String mealType) {
    final TextEditingController itemController = TextEditingController();
    bool isVeg = false;
    bool isNonVeg = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Add Item to $mealType"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: itemController,
                    decoration: const InputDecoration(labelText: "Item Name"),
                  ),
                  const SizedBox(height: 10),

                  // Veg & Non-Veg Selection with Checkboxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: isVeg,
                        onChanged: (value) {
                          setDialogState(() {
                            isVeg = value!;
                            if (isVeg) isNonVeg = false;
                          });
                        },
                        activeColor: Colors.green,
                      ),
                      const Text("Veg 🟢", style: TextStyle(fontSize: 16, color: Colors.green)),

                      const SizedBox(width: 20),

                      Checkbox(
                        value: isNonVeg,
                        onChanged: (value) {
                          setDialogState(() {
                            isNonVeg = value!;
                            if (isNonVeg) isVeg = false;
                          });
                        },
                        activeColor: Colors.red,
                      ),
                      const Text("Non-Veg 🔴", style: TextStyle(fontSize: 16, color: Colors.red)),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (itemController.text.isNotEmpty && (isVeg || isNonVeg)) {
                      setState(() {
                        _meals[mealType]?.items.add(
                          "${isVeg ? "🟢" : "🔴"} ${itemController.text}",
                        );
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _savePlan() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Meal plan saved successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Plan")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: _meals.entries.map((entry) {
              final mealType = entry.key;
              final meal = entry.value;

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                  color: Colors.black54,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.fastfood, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          mealType,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _pickTime(context, mealType, true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Start: ${meal.startTime}", style: const TextStyle(color: Colors.white)),
                                  const Icon(Icons.access_time, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _pickTime(context, mealType, false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("End: ${meal.endTime}", style: const TextStyle(color: Colors.white)),
                                  const Icon(Icons.access_time, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    const Text("Items List", style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 8),
                    Column(
                      children: meal.items.map((item) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  meal.items.remove(item);
                                });
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),

                    Center(
                      child: IconButton(
                        onPressed: () => _addItem(mealType),
                        icon: const Icon(Icons.add, color: Colors.white, size: 30),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: const CircleBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _savePlan,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Save Plan", style: TextStyle(fontSize: 18, color: Colors.white)),
        ),
      ),
    );
  }
}
