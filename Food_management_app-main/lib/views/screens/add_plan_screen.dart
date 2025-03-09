import 'package:flutter/material.dart';
import 'package:foodm/models/meal_plan_model.dart';
import 'package:foodm/mobx/meal_plan_store.dart';
import 'package:uuid/uuid.dart';

class AddPlanScreen extends StatefulWidget {
  final MealPlanStore store;

  const AddPlanScreen({super.key, required this.store});

  @override
  State<AddPlanScreen> createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends State<AddPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _planNameController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedFrequency = "Monthly";

  final Map<String, bool> _mealsSelected = {
    "Breakfast": false,
    "Lunch": false,
    "Snacks": false,
    "Dinner": false,
  };

  final Map<String, TextEditingController> _mealPriceControllers = {
    "Breakfast": TextEditingController(),
    "Lunch": TextEditingController(),
    "Snacks": TextEditingController(),
    "Dinner": TextEditingController(),
  };

  bool _showPriceBreakdown = false;
  final Uuid _uuid = const Uuid();

  // Function to calculate total amount dynamically
  void _updateTotalAmount() {
    if (!_showPriceBreakdown) return; // Skip if manual entry is enabled
    int total = 0;
    _mealsSelected.forEach((meal, isSelected) {
      if (isSelected) {
        int price = int.tryParse(_mealPriceControllers[meal]!.text) ?? 0;
        total += price;
      }
    });
    _amountController.text = total.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Plan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Plan Name Input Field
              TextFormField(
                controller: _planNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[900],
                  hintText: "Enter Plan Name",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: const Icon(Icons.assignment, color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.grey[700]!),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a plan name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Price Breakdown Toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Show price breakdown per meal"),
                  Switch(
                    value: _showPriceBreakdown,
                    onChanged: (value) {
                      setState(() {
                        _showPriceBreakdown = value;
                        if (!value) {
                          _amountController.text = ''; // Allow manual entry
                        } else {
                          _updateTotalAmount(); // Calculate dynamically
                        }
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Meal Selection with User-Defined Prices
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF393F5E),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: const Color.fromARGB(255, 197, 208, 223), width: 0.5),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: _mealsSelected.keys.map((meal) {
                    return CheckboxListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(meal, style: const TextStyle(color: Colors.white)),
                          if (_showPriceBreakdown)
                            // Price Input Box for each meal
                            SizedBox(
                              width: 60,
                              child: TextFormField(
                                controller: _mealPriceControllers[meal],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                  filled: true,
                                  fillColor: const Color(0xFF1E2235), // Dark blue background
                                  hintText: "₹",
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                onChanged: (value) {
                                  _updateTotalAmount();
                                },
                              ),
                            ),
                        ],
                      ),
                      value: _mealsSelected[meal],
                      activeColor: Colors.blueAccent,
                      checkColor: Colors.white,
                      onChanged: (value) {
                        setState(() {
                          _mealsSelected[meal] = value!;
                          _updateTotalAmount();
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 16),

              // Amount Input Field (Dynamic or Manual)
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                readOnly: _showPriceBreakdown, // Read-only when toggle is ON
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[900],
                  hintText: "Total Amount",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: const Icon(Icons.currency_rupee, color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.grey[700]!),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value == "0") {
                    return "Please enter a valid amount";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Frequency Dropdown
              DropdownButtonFormField<String>(
                value: _selectedFrequency,
                items: ["Daily", "Weekly", "Monthly"]
                    .map((frequency) => DropdownMenuItem<String>(
                          value: frequency,
                          child: Text(frequency),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFrequency = value!;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[900],
                  hintText: "Select Frequency",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: const Icon(Icons.calendar_today, color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.grey[700]!),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Save Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newPlan = MealPlan(
                      id: _uuid.v4(),
                      name: _planNameController.text,
                      frequency: _selectedFrequency,
                      amount: int.parse(_amountController.text),
                      meals: _mealsSelected.entries
                          .where((entry) => entry.value)
                          .map((entry) => Meal(
                                type: entry.key,
                                startTime: '08:00',
                                endTime: '09:00',
                                items: [],
                              ))
                          .toList(),
                    );

                    widget.store.addMealPlan(newPlan);

                    if (mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text("Save & Continue",style: TextStyle(color: Colors.white,fontSize: 24),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
