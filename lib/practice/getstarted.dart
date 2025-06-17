import 'package:flutter/material.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( // Wrap the entire screen content in a Container for the gradient
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
        child: SafeArea(
          child: Column(
            children: [
              // Image at the top
              Container(
                height: 212,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24), // Added margin
                decoration: BoxDecoration(
                  // You might want to remove the placeholder color if the image fills the container
                  // color: Colors.white.withOpacity(0.1), // A subtle, semi-transparent white
                  borderRadius: BorderRadius.circular(16), // Slightly more rounded corners
                  border: Border.all(color: Colors.white.withOpacity(0.2), width: 1), // Subtle border
                ),
                // child: Center( // Remove placeholder icon
                //   child: Icon(
                //     Icons.directions_run,
                //     size: 80,
                //     color: Colors.white.withOpacity(0.7),
                //   ),
                // ),
                child: ClipRRect( // Use ClipRRect to respect the border radius
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/getstarted.jpg', // <--- YOUR IMAGE PATH
                    fit: BoxFit.cover, // Ensures the image covers the container bounds
                    // Optional: if your image is too bright/dark against the gradient
                    // you can add a color overlay
                    // color: Colors.black.withOpacity(0.2),
                    // colorBlendMode: BlendMode.darken,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback in case the image fails to load
                      return Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 80,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Welcome text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Welcome to Cantt Markhor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, // Changed to white for contrast
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Subtitle text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Unleash your sports potential!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70, // Changed to a softer white
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Get Started button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: () {
                    print("Get Started button pressed.");
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Button background is white
                    foregroundColor: const Color(0xFF00003D), // Text color is dark blue from gradient
                    minimumSize: const Size(double.infinity, 54), // Slightly taller button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14), // Slightly more rounded
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), // Adjusted padding
                    elevation: 5, // Add some shadow for depth
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18, // Slightly larger text
                      fontWeight: FontWeight.bold, // Make text bold
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Bottom indicator
              Center(
                child: Container(
                  width: 120, // Slightly wider indicator
                  height: 5, // Slightly thicker indicator
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7), // White with transparency
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}