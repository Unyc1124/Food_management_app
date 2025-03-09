import 'package:flutter/material.dart';
import 'package:foodm/views/screens/meal_plan_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const FoodManagementApp());
}

class FoodManagementApp extends StatelessWidget {
  const FoodManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Management App',
      theme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.white,
      Colors.purple,
      Colors.blue,
      Colors.white,
      Colors.yellow,
      Colors.red,
      Colors.white,
    ];
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Opacity
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/res1.jpg'), // Your background image
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.4), // Color overlay for opacity
            ),
          ),
          // Foreground Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30),
                DefaultTextStyle(
                  style: GoogleFonts.ribeyeMarrow(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(
                        'Welcome to',
                        textStyle: GoogleFonts.ribeyeMarrow(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 236, 233, 236).withOpacity(0.65),
                        ),
                      ),
                      ColorizeAnimatedText(
                        ' 😋Food Management ',
                        textStyle: GoogleFonts.ribeyeMarrow(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                        colors: colorizeColors,
                      ),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),
                const SizedBox(height: 30),
                Icon(
                  Icons.fastfood,
                  size: 150.0,
                  color: Colors.white.withOpacity(0.65),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MealPlanScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.65),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(color: Color.fromARGB(255, 21, 21, 22)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
