import 'package:flutter/material.dart';

class AthleteProfileScreen extends StatelessWidget {
  const AthleteProfileScreen({super.key});

  // --- Constants for reusable styles and colors ---
  // Updated text colors for contrast against the blue gradient
  static const Color _kPrimaryTextColor = Colors.white;
  static const Color _kSecondaryTextColor = Color(0xFFE0E0E0); // Lighter grey/white for subtitles/hints
  static const Color _kButtonColor = Colors.white; // White button for contrast
  static const Color _kButtonTextColor = Color(0xFF00003D); // Dark text for white button (from gradient bottom)
  static const Color _kChipBorderColor = Color(0xFFADD8E6); // Light blue for chip borders
  static const Color _kChipBackgroundColor = Colors.white12; // Subtle, transparent white for chips
  static const Color _kAvatarBackgroundColor = Colors.white24; // Transparent white for avatar placeholder

  // New Gradient Colors - already defined in your code, keeping them for clarity
  static const Color _kGradientTop = Color(0xFF0033FF);
  static const Color _kGradientMiddle = Color(0xFF0600AB);
  static const Color _kGradientBottom = Color(0xFF00003D);

  static const String _kFontFamily = 'Inter'; // Assuming 'Inter' is added to your project

  static const TextStyle _kScreenTitleStyle = TextStyle(
    color: _kPrimaryTextColor,
    fontFamily: _kFontFamily,
    fontSize: 28, // Adjusted for screen title
    fontWeight: FontWeight.bold, // Made bold
    height: 1.25,
  );

  static const TextStyle _kSectionTitleStyle = TextStyle(
    color: _kPrimaryTextColor,
    fontFamily: _kFontFamily,
    fontSize: 20, // Slightly larger for section titles
    fontWeight: FontWeight.bold, // Made bold
    height: 1.5,
  );

  static const TextStyle _kProfileNameStyle = TextStyle(
    color: _kPrimaryTextColor,
    fontFamily: _kFontFamily,
    fontSize: 22, // Larger for the profile name
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static const TextStyle _kProfileTaglineStyle = TextStyle(
    color: _kSecondaryTextColor,
    fontFamily: _kFontFamily,
    fontSize: 15,
    fontWeight: FontWeight.normal,
    height: 1.428,
  );

  static const TextStyle _kBodyTextStyle = TextStyle(
    color: _kPrimaryTextColor,
    fontFamily: _kFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.0,
  );

  static const TextStyle _kSubtitleTextStyle = TextStyle(
    color: _kSecondaryTextColor,
    fontFamily: _kFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.428,
  );

  static const TextStyle _kButtonTextStyle = TextStyle(
    color: _kButtonTextColor,
    fontFamily: _kFontFamily,
    fontSize: 18, // Slightly larger button text
    fontWeight: FontWeight.bold, // Make button text bold
    height: 1.375,
  );

  static const TextStyle _kChipTextStyle = TextStyle(
    color: _kPrimaryTextColor, // Chip text color is white
    fontFamily: _kFontFamily,
    fontSize: 15, // Slightly smaller for chips
    fontWeight: FontWeight.normal,
    height: 1.375,
  );

  static const TextStyle _kNavBarLabelStyle = TextStyle(
    fontFamily: _kFontFamily,
    fontSize: 11,
    fontWeight: FontWeight.normal,
    height: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Scaffold background becomes transparent
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar background transparent to show gradient
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _kPrimaryTextColor),
          onPressed: () {
            // Handle back navigation
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text('Athlete Profile', style: _kScreenTitleStyle),
        centerTitle: false, // Align title to the start for a modern look
      ),
      extendBodyBehindAppBar: true, // Extends body behind app bar to show gradient fully
      body: Container( // Wrap the body with a Container for the gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _kGradientTop,
              _kGradientMiddle,
              _kGradientBottom,
            ],
            stops: [0.0, 0.5, 1.0], // Explicit stops ensure smooth transition
          ),
        ),
        child: SafeArea( // Use SafeArea inside the gradient container
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0), // Increased horizontal padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 24), // Adjusted spacing after app bar
                  _buildProfileHeader(),
                  const SizedBox(height: 32), // Increased spacing
                  _buildSectionTitle('Performance Statistics'),
                  const SizedBox(height: 12), // Adjusted spacing
                  _buildPerformanceStats(),
                  const SizedBox(height: 32), // Increased spacing
                  _buildSectionTitle('Areas of Interest'),
                  const SizedBox(height: 16), // Adjusted spacing
                  _buildInterestChips(),
                  const SizedBox(height: 40), // Increased spacing
                  _buildActionButton('Message Athlete', onPressed: () {
                    // TODO: Implement message athlete action
                    print('Message Athlete tapped');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opening chat with Emily Johnson...', style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }),
                  const SizedBox(height: 18), // Adjusted spacing
                  _buildActionButton('Followers & Following', onPressed: () {
                    // TODO: Implement followers/following action
                    print('Followers & Following tapped');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Navigating to Followers & Following...', style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }),
                  const SizedBox(height: 18), // Adjusted spacing
                  _buildActionButton('Player Social Feed', onPressed: () {
                    // TODO: Implement social feed action
                    print('Player Social Feed tapped');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Loading Emily Johnson\'s social feed...', style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }),
                  const SizedBox(height: 80), // Space for bottom nav bar to prevent content from being cut off
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: <Widget>[
        const CircleAvatar(
          radius: 35, // Larger avatar
          backgroundColor: _kAvatarBackgroundColor,
          // Replace with actual image or placeholder icon
          child: Icon(Icons.person, size: 40, color: _kPrimaryTextColor), // Icon color is white
        ),
        const SizedBox(width: 20), // Increased spacing
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Emily Johnson', style: _kProfileNameStyle), // Using new profile name style
            const SizedBox(height: 4), // Adjusted spacing
            const Text('Competitive Swimmer', style: _kProfileTaglineStyle), // Using new profile tagline style
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: _kSectionTitleStyle);
  }

  Widget _buildPerformanceStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Total Races: 30', style: _kBodyTextStyle),
        const SizedBox(height: 8), // Increased spacing
        const Text('Fastest Time: 1:45', style: _kSubtitleTextStyle), // Reusing subtitle style
      ],
    );
  }

  Widget _buildInterestChips() {
    final interests = ['Pool Training', 'Triathlons', 'Weightlifting', 'Nutrition', 'Endurance', 'Recovery']; // Added more interests
    return Wrap(
      spacing: 12.0, // Increased spacing between chips
      runSpacing: 12.0, // Increased vertical spacing between rows of chips
      children: interests
          .map((interest) => Chip(
        label: Text(interest, style: _kChipTextStyle),
        backgroundColor: _kChipBackgroundColor, // Subtle, transparent background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // More rounded chips
          side: const BorderSide(color: _kChipBorderColor, width: 1.5), // Slightly thicker, light blue border
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjusted padding
      ))
          .toList(),
    );
  }

  Widget _buildActionButton(String text, {required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity, // Make button take full width
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _kButtonColor, // White button background
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18), // Adjusted padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14), // More rounded
          ),
          elevation: 6, // Increased elevation for a lifted effect
          shadowColor: Colors.black.withOpacity(0.5), // Darker shadow for contrast
          minimumSize: const Size(double.infinity, 54), // Taller button
        ),
        child: Text(text, style: _kButtonTextStyle), // Button text color is dark
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    // In a real app, this would be managed by a stateful widget or a BLoC/Provider
    int currentIndex = 1; // Assuming 'Profile' is the current selected item (index 1)

    return BottomNavigationBar(
      backgroundColor: Colors.white, // Bottom Nav Bar is white
      type: BottomNavigationBarType.fixed, // Essential for showing all labels
      selectedItemColor: _kButtonTextColor, // Selected icon/label is dark blue
      unselectedItemColor: _kSecondaryTextColor, // Unselected is light gray
      selectedLabelStyle: _kNavBarLabelStyle.copyWith(color: _kButtonTextColor, fontWeight: FontWeight.bold), // Selected label bold
      unselectedLabelStyle: _kNavBarLabelStyle.copyWith(color: _kSecondaryTextColor),
      currentIndex: currentIndex,
      elevation: 10.0, // Increased elevation for a more prominent bottom bar
      onTap: (index) {
        print('Tapped on nav item: $index');
        // Example navigation logic:
        // if (index == 0) {
        //   Navigator.pushReplacementNamed(context, '/home');
        // } else if (index == 2) {
        //   Navigator.pushReplacementNamed(context, '/events');
        // } else if (index == 3) {
        //   Navigator.pushReplacementNamed(context, '/settings');
        // }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_outlined),
          activeIcon: Icon(Icons.event),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          activeIcon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}