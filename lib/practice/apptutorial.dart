import 'package:flutter/material.dart';
// import 'dart:ui'; // For ImageFilter, though not actively used in this snippet

// --- Text Styles ---
const TextStyle _kTitleTextStyle = TextStyle(
  color: Colors.white, // White for contrast against blue gradient
  // fontFamily: 'Inter', // Ensure this font is available or remove
  fontSize: 32, // Slightly larger for main title
  fontWeight: FontWeight.bold,
  height: 1.2,
);

const TextStyle _kStepTitleTextStyle = TextStyle(
  color: Colors.white, // White for contrast against blue gradient
  // fontFamily: 'Inter',
  fontSize: 24, // Slightly larger for step titles
  fontWeight: FontWeight.w600,
  height: 1.2,
);

const TextStyle _kDescriptionTextStyle = TextStyle(
  color: Color(0xFFE0E0E0), // Lighter gray for better contrast
  // fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.5,
  letterSpacing: 0.2,
);

const TextStyle _kButtonTextStyle = TextStyle(
  color: Color(0xFF00003D), // Dark blue for text on light button
  // fontFamily: 'Inter',
  fontSize: 18, // Slightly larger button text
  fontWeight: FontWeight.bold, // Made button text bold
  letterSpacing: 0.5,
  height: 1.375,
);

// --- Colors ---
// Original _kPrimaryColor was dark, now used for elements that need strong contrast
const Color _kPrimaryColor = Color(0xFF0600AB); // Using middle blue from gradient
const Color _kLightColorForElements = Colors.white; // Used for elements that need to stand out brightly
// const Color _kAccentColor = Color.fromRGBO(66, 133, 244, 1); // Keep if you plan to use it

// New Gradient Colors
const Color _kGradientTop = Color(0xFF0033FF);
const Color _kGradientMiddle = Color(0xFF0600AB);
const Color _kGradientBottom = Color(0xFF00003D);


class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _tutorialSteps = [
    {
      'title': '1. Group Discovery',
      'description':
      'Discover groups that match your interests and connect with like-minded people. This section might have a bit more text to demonstrate scrolling if needed. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'image_asset': 'assets/images/tutorial_group_discovery.png',
      'icon': Icons.groups_2_outlined, // Changed icon for groups
    },
    {
      'title': '2. Chat Seamlessly',
      'description':
      'Engage in real-time conversations and build meaningful connections.',
      'image_asset': 'assets/images/tutorial_chat.png',
      'icon': Icons.chat_bubble_outline_rounded,
    },
    {
      'title': '3. Easy Event Scheduling',
      'description':
      'Plan and join events effortlessly with our intuitive scheduling feature. You can add more details here to see how the scrolling behaves within each page.',
      'image_asset': 'assets/images/tutorial_event_scheduling.png',
      'icon': Icons.event_available_outlined,
    }
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _handleNextOrGetStarted() {
    if (_currentPage < _tutorialSteps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutSine,
      );
    } else {
      print("Get Started Tapped! Navigating to /dashboard");
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Apply the gradient background to the Scaffold body
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _kGradientTop,
              _kGradientMiddle,
              _kGradientBottom,
            ],
            stops: [0.0, 0.5, 1.0], // Distribute the colors evenly
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 24.0), // Increased padding
                child: Text(
                  'Welcome to Your App Tour!',
                  textAlign: TextAlign.center,
                  style: _kTitleTextStyle,
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _tutorialSteps.length,
                  itemBuilder: (context, index) {
                    final step = _tutorialSteps[index];
                    return _buildTutorialStep(
                      title: step['title'] as String,
                      description: step['description'] as String,
                      imageAsset: step['image_asset'] as String?,
                      icon: step['icon'] as IconData,
                    );
                  },
                ),
              ),
              _buildNavigationControls(),
              _buildBottomIndicator(),
              const SizedBox(height: 24), // Overall bottom padding for the screen
            ],
          ),
        ),
      ),
    );
  }

  // UPDATED _buildTutorialStep to make its content scrollable
  Widget _buildTutorialStep({
    required String title,
    required String description,
    String? imageAsset,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      // Wrap the content of each page with SingleChildScrollView
      child: SingleChildScrollView( // <--- KEY CHANGE HERE
        physics: const BouncingScrollPhysics(), // Optional: for a nice scroll effect
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center content vertically IF it's shorter than PageView item
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Add some padding at the top if it's scrollable,
            // so content doesn't stick to the very top edge immediately when scrolling starts.
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35, // Keep as is or make flexible
              margin: const EdgeInsets.only(bottom: 32.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15), // Subtle transparent white for image container
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4), // Darker shadow for depth
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: (imageAsset != null && imageAsset.isNotEmpty)
                    ? Image.asset(
                  imageAsset,
                  fit: BoxFit.contain, // Use contain to show entire image
                  // You might need to adjust the image assets themselves
                  // or use a color filter if they don't look good on a dark background.
                  // color: Colors.white.withOpacity(0.8), // Example: apply a subtle tint
                  // colorBlendMode: BlendMode.modulate,
                  errorBuilder: (context, error, stackTrace) {
                    print("Error loading image: $imageAsset - $error");
                    return Center(
                        child: Icon(icon,
                            size: 80,
                            color: _kLightColorForElements.withOpacity(0.7))); // Light icon for error
                  },
                )
                    : Center(
                    child: Icon(icon,
                        size: 80, color: _kLightColorForElements.withOpacity(0.8))), // Light icon
              ),
            ),
            Text(title, textAlign: TextAlign.center, style: _kStepTitleTextStyle),
            const SizedBox(height: 20), // Increased spacing
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: _kDescriptionTextStyle,
              ),
            ),
            // Add some padding at the bottom of the scrollable content
            const SizedBox(height: 40), // Increased bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0), // Increased vertical padding
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_tutorialSteps.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6.0), // Slightly more spacing
                width: _currentPage == index ? 28.0 : 10.0, // Wider active indicator
                height: 10.0, // Thicker indicator
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), // Slightly more rounded
                  color: _currentPage == index
                      ? _kLightColorForElements // White for active indicator
                      : _kLightColorForElements.withOpacity(0.4), // Lighter for inactive
                ),
              );
            }),
          ),
          const SizedBox(height: 40), // Increased spacing
          ElevatedButton(
            onPressed: _handleNextOrGetStarted,
            style: ElevatedButton.styleFrom(
              backgroundColor: _kLightColorForElements, // Button background is now white
              padding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 32), // Increased padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // Rounded pill shape
              ),
              minimumSize: const Size(double.infinity, 58), // Taller button
              elevation: 8, // Increased elevation for a lifted effect
              shadowColor: Colors.black.withOpacity(0.5), // Darker shadow
            ),
            child: Text(
              _currentPage == _tutorialSteps.length - 1
                  ? 'Get Started'
                  : 'Next',
              style: _kButtonTextStyle, // Uses the updated button text style
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomIndicator() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0, top: 10.0),
        width: 134,
        height: 5,
        decoration: BoxDecoration(
          color: _kLightColorForElements.withOpacity(0.8), // White for the bottom indicator
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}