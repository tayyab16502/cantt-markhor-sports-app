import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToGetStarted();
  }

  _navigateToGetStarted() async {
    // Set the splash screen duration to 5 seconds
    await Future.delayed(const Duration(seconds: 5), () {});

    // Navigate to the '/getstarted' screen
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/getstarted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a Container with BoxDecoration for the gradient background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Start gradient from the top
            end: Alignment.bottomCenter, // End gradient at the bottom
            colors: [
              Color(0xFF0033FF), // Top color: #0033FF
              Color(0xFF0600AB), // Middle color: #0600AB
              Color(0xFF00003D), // Bottom color: #00003D
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- All Sports Icon/Image ---
              // Icon color changed to a subtle light blue for better contrast
              const Icon(
                Icons.sports_soccer, // Example: A soccer ball icon
                size: 100,
                color: Color(0xFFADD8E6), // A light blue that complements the gradient
              ),

              // Option 2 (Preferred for Custom Image): Using your PNG/JPG asset
              // If you use an image, ensure its colors are suitable for the dark background.
              // You might need to adjust the image itself or use a color filter.
              /*
              Image.asset(
                'assets/images/all_sports_icon.png', // <-- REPLACE WITH YOUR IMAGE PATH
                width: 100, // Adjust size as needed
                height: 100, // Adjust size as needed
                // Consider color blending if your image is not suitable for dark background
                // color: Color(0xFFADD8E6), // Apply a tint if needed
                // colorBlendMode: BlendMode.modulate,
              ),
              */

              const SizedBox(height: 30), // Spacing below the icon

              // --- App Name ---
              const Text(
                'Cantt Markhor',
                style: TextStyle(
                  fontFamily: 'Inter', // Ensure this font is available or remove
                  color: Color(0xFFFFFFFF), // Pure white for primary text
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2, // Adds a professional touch
                ),
              ),
              const SizedBox(height: 10),
              // Tagline color changed to a slightly muted white/light grey
              const Text(
                'Unleash the Champion Within', // Optional tagline
                style: TextStyle(
                  fontFamily: 'Inter', // Ensure this font is available or remove
                  color: Color(0xFFE0E0E0), // Slightly subdued white for tagline
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 60), // Spacing before the indicator
              CircularProgressIndicator(
                // Loading indicator color changed to a brighter, complementary blue
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF87CEEB)), // A light sky blue
                strokeWidth: 2, // Thinner line for a cleaner look
              ),
            ],
          ),
        ),
      ),
    );
  }
}