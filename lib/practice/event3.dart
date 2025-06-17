import 'package:flutter/material.dart';

// --- Gradient Color Constants (from previous updates) ---
const Color kGradientTopBlue = Color(0xFF0033FF);
const Color kGradientMediumBlue = Color(0xFF0600AB);
const Color kGradientBottomBlue = Color(0xFF00003D);

// --- General Theme Colors (from previous updates) ---
const Color kWhiteTextColor = Colors.white; // For text on gradients and dark backgrounds
const Color kDarkTextColor = Color(0xFF1C1B1F); // For text on white/light backgrounds
const Color kLightGrayBackground = Color(0xFFEFF1F5); // General scaffold and card background
const Color kMediumGrayTextColor = Color(0xFFA09CAB); // For secondary text, disabled icons
const Color kPrimaryButtonBlue = kGradientMediumBlue; // Main button color
const Color kAccentBlue = kGradientTopBlue; // For accents like active borders, primary icons
const Color kDividerColor = Color(0xFFE0E0E0); // Lighter divider color
const Color kSuccessColor = Color(0xFF4CAF50); // Green for success
const Color kWarningColor = Color(0xFFFFC107); // Orange for warning/maybe
const Color kInfoColor = Color(0xFF2196F3); // Blue for info/pending
const Color kErrorColor = Color(0xFFFF5252); // Red for errors

// --- Reusable Text Styles (Adjusted for the new theme) ---
const TextStyle kAppBarTitleTextStyle = TextStyle(
  color: kWhiteTextColor, // AppBar title is white on gradient
  fontFamily: 'Inter',
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

const TextStyle kScreenTitleTextStyle = TextStyle(
  color: kDarkTextColor, // Titles on white background
  fontFamily: 'Inter',
  fontSize: 32,
  fontWeight: FontWeight.bold,
  height: 1.25,
);

const TextStyle kSectionTitleTextStyle = TextStyle(
  color: kDarkTextColor, // Section titles on white background
  fontFamily: 'Inter',
  fontSize: 20,
  fontWeight: FontWeight.w700, // Slightly bolder for emphasis
  height: 1.6,
);

const TextStyle kInfoTextStyle = TextStyle(
  color: kDarkTextColor, // Main info text
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.5,
);

const TextStyle kPlayerNameTextStyle = TextStyle(
  color: kDarkTextColor,
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.w500, // Medium weight for names
  height: 1.2,
);

const TextStyle kStatusTextStyle = TextStyle(
  fontFamily: 'Inter',
  fontSize: 14,
  fontWeight: FontWeight.w600, // Bolder status
  height: 1.4,
);

const TextStyle kBottomNavLabelStyle = TextStyle(
  fontSize: 11,
  fontFamily: 'Inter',
);


class EventDetailsScreen extends StatefulWidget { // Renamed for clarity
  const EventDetailsScreen({super.key}); // Added key for best practice

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  // Assuming 'Events' is the active tab when navigating to this screen.
  // This state would typically be managed by the parent widget (e.g., main scaffold)
  // that holds the BottomNavigationBar, and passed down or accessed via provider.
  // For this isolated screen, we'll default it to 1 (Events).
  int _currentBottomNavIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGrayBackground, // Consistent light gray background
      appBar: _buildAppBar(),
      body: ListView( // Using ListView for scrollability
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0), // Increased padding
        children: <Widget>[
          const Text('Match Confirmed', style: kScreenTitleTextStyle),
          const SizedBox(height: 28), // Increased spacing

          _buildInfoRow(icon: Icons.sports_soccer_outlined, text: 'Match: Soccer Tournament'), // Themed icon
          _buildInfoRow(icon: Icons.calendar_today_outlined, text: 'Date: April 20, 2023'), // Themed icon
          _buildInfoRow(icon: Icons.access_time_outlined, text: 'Time: 3:00 PM'), // Themed icon
          const SizedBox(height: 28),

          const Text('Players', style: kSectionTitleTextStyle),
          const Divider(height: 20, thickness: 1.0, color: kDividerColor), // Themed divider
          _buildPlayerItem(name: 'Alice Johnson'),
          _buildPlayerItem(name: 'Bob Smith'),
          _buildPlayerItem(name: 'Charlie Brown'),
          const SizedBox(height: 28),

          const Text('RSVP Status', style: kSectionTitleTextStyle),
          const Divider(height: 20, thickness: 1.0, color: kDividerColor), // Themed divider
          _buildRsvpItem(name: 'Alice Johnson', status: 'Going', statusColor: kSuccessColor),
          _buildRsvpItem(name: 'Bob Smith', status: 'Maybe', statusColor: kWarningColor),
          _buildRsvpItem(name: 'Charlie Brown', status: 'Not Going', statusColor: kErrorColor),
          const SizedBox(height: 30), // Space before bottom nav
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // --- Helper methods to build UI sections ---

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kGradientTopBlue, kGradientMediumBlue, kGradientBottomBlue],
          ),
        ),
      ),
      elevation: 1.0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: kWhiteTextColor), // Modern back icon, white
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          debugPrint("Back arrow pressed: Popping EventDetailsScreen");
        },
      ),
      title: const Text('Event Details', style: kAppBarTitleTextStyle), // Add a title
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.share, color: kWhiteTextColor, size: 24), // Share icon, white
          onPressed: () {
            debugPrint("Share event pressed");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Share Event (TODO)', style: TextStyle(color: kWhiteTextColor)),
                backgroundColor: kAccentBlue,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.edit_outlined, color: kWhiteTextColor, size: 24), // Edit icon, white
          onPressed: () {
            debugPrint("Edit event pressed");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Edit Event (TODO)', style: TextStyle(color: kWhiteTextColor)),
                backgroundColor: kAccentBlue,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // Helper widget for information rows (Match, Date, Time)
  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0), // Increased vertical padding
      child: Row(
        children: [
          Icon(icon, color: kAccentBlue, size: 24), // Themed icon color and size
          const SizedBox(width: 16), // Increased spacing
          Text(text, style: kInfoTextStyle),
        ],
      ),
    );
  }

  // Helper widget for player list items
  Widget _buildPlayerItem({required String name}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0), // Increased vertical padding
      child: Row(
        children: [
          CircleAvatar(
            radius: 20, // Slightly larger avatar
            backgroundColor: kLightGrayBackground, // Themed background
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: kPlayerNameTextStyle.copyWith(color: kAccentBlue), // Themed initial color
            ),
          ),
          const SizedBox(width: 16), // Increased spacing
          Text(name, style: kPlayerNameTextStyle),
        ],
      ),
    );
  }

  // Helper widget for RSVP status items
  Widget _buildRsvpItem({required String name, required String status, Color? statusColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0), // Increased vertical padding
      child: Row(
        children: [
          CircleAvatar(
            radius: 20, // Slightly larger avatar
            backgroundColor: statusColor?.withOpacity(0.15) ?? kLightGrayBackground, // Subtle background based on status
            child: Icon(
              status == 'Going' ? Icons.check_circle_rounded : // Filled icon for status
              status == 'Maybe' ? Icons.help_rounded : // Filled icon for status
              Icons.cancel_rounded, // Filled icon for status
              color: statusColor ?? kMediumGrayTextColor, // Themed icon color
              size: 24, // Larger icon
            ),
          ),
          const SizedBox(width: 16), // Increased spacing
          Expanded(child: Text(name, style: kPlayerNameTextStyle)),
          Text(status, style: kStatusTextStyle.copyWith(color: statusColor)), // Status text color matching icon
        ],
      ),
    );
  }

  // Helper widget for the custom bottom navigation bar
  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      // Apply the gradient here
      child: Container(
        height: 65, // Consistent height
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kGradientTopBlue, kGradientMediumBlue, kGradientBottomBlue],
          ),
        ),
        child: Row(
          children: <Widget>[
            _buildNavButton(icon: Icons.home_filled, label: 'Home', index: 0, onPressed: () {
              debugPrint('Home Tapped');
              Navigator.pushNamed(context, '/dashboard'); // Navigate to dashboard
            }),
            _buildNavButton(icon: Icons.event_note_outlined, label: 'Events', index: 1, onPressed: () {
              debugPrint('Events Tapped');
              // This screen is already about events, so no navigation needed for this tab
            }),
            _buildNavButton(icon: Icons.add_circle_outline, label: 'Create', index: 2, onPressed: () {
              debugPrint('Create Tapped');
              Navigator.pushNamed(context, '/createevent'); // Navigate to event creation
            }),
            _buildNavButton(icon: Icons.person_outline, label: 'Profile', index: 3, onPressed: () {
              debugPrint('Profile Tapped');
              Navigator.pushNamed(context, '/profile'); // Navigate to profile
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required String label,
    required int index,
    required VoidCallback onPressed,
  }) {
    bool isActive = _currentBottomNavIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          // Update the state if the tab changes
          if (_currentBottomNavIndex != index) {
            setState(() {
              _currentBottomNavIndex = index;
            });
          }
          onPressed(); // Execute the button's specific action (e.g., navigation)
        },
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: isActive ? kWhiteTextColor : kMediumGrayTextColor.withOpacity(0.8), // Themed colors
              size: isActive ? 28 : 24, // Larger active icon
            ),
            const SizedBox(height: 4), // Consistent spacing
            Text(
              label,
              style: kBottomNavLabelStyle.copyWith(
                color: isActive ? kWhiteTextColor : kMediumGrayTextColor.withOpacity(0.8), // Themed colors
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}