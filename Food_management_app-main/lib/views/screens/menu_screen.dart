import 'package:flutter/material.dart';
import 'package:foodm/views/screens/menu_item_screen.dart';
import 'package:foodm/services/json_parser.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Future<Map<String, dynamic>> _menuFuture;

  @override
  void initState() {
    super.initState();
    _menuFuture = JsonParser.loadMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E303C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                '🍴 Menu Dashboard',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 244, 241, 245),
                ),
              ),
              const SizedBox(height: 20),

              // FutureBuilder for Categories
              Expanded(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: _menuFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Error loading menu: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final menu = snapshot.data!;
                      final categories = menu.keys.toList();

                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                          childAspectRatio: 3 / 2,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MenuItemsScreen(
                                    category: categories[index],
                                    items: menu[categories[index]],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF393F5E), // Solid color
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.purple.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(2, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  categories[index].toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(child: Text('No menu available.'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
