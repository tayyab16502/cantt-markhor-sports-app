import 'package:flutter/material.dart';

// --- Gradient Color Constants ---
const Color kGradientTopBlue = Color(0xFF0033FF);
const Color kGradientMediumBlue = Color(0xFF0600AB);
const Color kGradientBottomBlue = Color(0xFF00003D);

// --- General Theme Colors ---
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

const TextStyle kTitleTextStyle = TextStyle(
  color: kDarkTextColor, // Titles on white background
  fontFamily: 'Inter',
  fontSize: 32,
  fontWeight: FontWeight.bold,
  height: 1.25,
);

const TextStyle kEventTextStyle = TextStyle(
  color: kDarkTextColor, // Event titles on white background
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.w600,
  height: 1.2,
);

const TextStyle kEventSubtitleTextStyle = TextStyle(
  color: kMediumGrayTextColor, // Event subtitles on white background
  fontFamily: 'Inter',
  fontSize: 14,
  fontWeight: FontWeight.normal,
  height: 1.4,
);

const TextStyle kCardTextStyle = TextStyle(
  color: kDarkTextColor, // Text inside light gray cards
  fontFamily: 'Inter',
  fontSize: 14,
  fontWeight: FontWeight.w500,
  height: 1.2,
);

const TextStyle kButtonTextStyle = TextStyle(
  color: kWhiteTextColor, // Text on primary blue buttons
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.w600,
  height: 1.375,
);

const TextStyle kBottomNavTextStyle = TextStyle(
  fontSize: 10,
  fontFamily: 'Inter',
);


class Event1Screen extends StatefulWidget {
  const Event1Screen({super.key});

  @override
  _Event1ScreenState createState() => _Event1ScreenState();
}

class _Event1ScreenState extends State<Event1Screen> {
  int _currentBottomNavIndex = 1; // Default to Events tab

  PreferredSizeWidget _buildAppBar() {
    String title = "Events Calendar";
    Widget? leadingWidget;

    // The current design suggests the Event1Screen is primarily for the 'Events' tab,
    // and navigating away from it would change the currentBottomNavIndex.
    // So, if the index is 1 (Events), show the back button.
    if (_currentBottomNavIndex == 1) {
      leadingWidget = Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: kWhiteTextColor), // White back icon
          onPressed: () {
            Navigator.pop(context); // Pop back to the previous screen (Dashboard)
            debugPrint("Back arrow pressed on Events tab, popping to previous screen.");
          },
        ),
      );
    }
    // Update title for other tabs if this AppBar were reused for other screens,
    // though typically each screen would have its own specific AppBar.
    else if (_currentBottomNavIndex == 0) {
      title = "Dashboard";
    } else if (_currentBottomNavIndex == 2) {
      title = "Messages";
    } else if (_currentBottomNavIndex == 3) {
      title = "Groups";
    } else if (_currentBottomNavIndex == 4) {
      title = "Profile";
    }

    return AppBar(
      // Apply the gradient here
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
      title: Text(title, style: kAppBarTitleTextStyle),
      leading: leadingWidget,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: kWhiteTextColor, size: 28), // White icons
          onPressed: () {
            debugPrint("Search pressed");
            Navigator.pushNamed(context, '/search'); // Assuming you have a search route
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none_outlined, color: kWhiteTextColor, size: 28), // White icons
          onPressed: () {
            debugPrint("Notifications pressed");
            // You might want to navigate to a notifications screen or show a dialog
          },
        ),
        if (_currentBottomNavIndex == 1) // This action only appears on the Events tab
          PopupMenuButton<String>( // Use a PopupMenuButton for more options
            icon: const Icon(Icons.more_vert, color: kWhiteTextColor), // White icon
            onSelected: (String result) {
              debugPrint('More options selected: $result');
              // Handle popup menu item selection
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Filter Events',
                child: Text('Filter Events', style: TextStyle(color: kDarkTextColor)),
              ),
              const PopupMenuItem<String>(
                value: 'Sort Events',
                child: Text('Sort Events', style: TextStyle(color: kDarkTextColor)),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'Manage Alerts',
                child: Text('Manage Alerts', style: TextStyle(color: kDarkTextColor)),
              ),
            ],
          ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildBodyContent() {
    switch (_currentBottomNavIndex) {
      case 0:
        return const Center(child: Text("Navigating to Dashboard...", style: kEventTextStyle));
      case 1:
        return _buildEvent1ScreenContent();
      case 2:
        return const Center(child: Text("Navigating to Messages...", style: kEventTextStyle));
      case 3:
        return const Center(child: Text("Navigating to Groups...", style: kEventTextStyle));
      case 4:
        return const Center(child: Text("Navigating to Profile...", style: kEventTextStyle));
      default:
        return _buildEvent1ScreenContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGrayBackground, // Consistent background color
      appBar: _buildAppBar(),
      body: _buildBodyContent(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      // Re-evaluating FAB position. Mini start float might cover content.
      // Considering moving FAB inside SingleChildScrollView or using a different strategy.
      // For now, let's keep it and adjust its padding slightly.
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: _currentBottomNavIndex == 1 ? Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 20.0), // Increased bottom padding
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, '/event3');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Viewing Event Alerts', style: TextStyle(color: kWhiteTextColor)),
                backgroundColor: kAccentBlue,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(Icons.notifications_active, color: kWhiteTextColor),
          label: Text('Alerts', style: kButtonTextStyle.copyWith(fontSize: 14)), // Smaller text for FAB
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryButtonBlue, // Themed FAB button color
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10), // Adjusted padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25), // More rounded
            ),
            elevation: 6, // More pronounced elevation
            shadowColor: Colors.black.withOpacity(0.3),
          ),
        ),
      ) : null,
    );
  }

  Widget _buildEvent1ScreenContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0), // Added vertical padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Removed the initial SizedBox(height: 10) due to vertical padding
          _buildEventCardsSection(),
          const SizedBox(height: 30),
          _buildUpcomingEventsHeader(),
          const SizedBox(height: 15),
          _buildEventDetails(),
          const SizedBox(height: 30), // Adjusted spacing
          Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryButtonBlue, // Themed button color
                  padding: const EdgeInsets.symmetric(vertical: 18), // Increased vertical padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14), // More rounded corners
                  ),
                  elevation: 5, // More elevation
                  shadowColor: Colors.black.withOpacity(0.4),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/event2');
                  debugPrint('Create Invitation button pressed, navigating to /event2');
                },
                child: const Text('Create Invitation', style: kButtonTextStyle),
              ),
            ),
          ),
          const SizedBox(height: 20), // Spacing before the bottom FAB
          // The bottom-right FAB will handle its own positioning relative to the Scaffold
          // and might overlap with the button if content is short.
          // Consider using a Stack or placing it inside a Column at the end
          // if you want it to scroll with the content and always be visible.
          // For now, removing the FloatingActionButton here as it's already on the Scaffold.
          // Re-evaluating the position of the second FAB. It's often better to have one FAB.
          // If you need another action, consider an AppBar action or a button within the scroll view.
          // If you truly need two FABs, they typically use different locations.
          // Let's remove this one to simplify for now, unless specified.
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: FloatingActionButton(
          //     onPressed: () {
          //       print('Bottom right action button (FAB) pressed on Events tab');
          //     },
          //     backgroundColor: kPrimaryButtonBlue,
          //     foregroundColor: kWhiteTextColor,
          //     child: const Icon(Icons.add, size: 30),
          //     tooltip: 'Add Event',
          //   ),
          // ),

          // The bottom indicator is good, just adjust its color to match the theme.
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 30, bottom: 10), // Increased top margin
              width: 130,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: kGradientMediumBlue.withOpacity(0.7), // Themed color
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 0,
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
            _buildBottomNavItem(icon: Icons.home_filled, label: 'Home', index: 0),
            _buildBottomNavItem(icon: Icons.event_note_outlined, label: 'Events', index: 1),
            _buildBottomNavItem(icon: Icons.maps_ugc_outlined, label: 'Messages', index: 2),
            _buildBottomNavItem(icon: Icons.group_outlined, label: 'Groups', index: 3),
            _buildBottomNavItem(icon: Icons.person_outline, label: 'Profile', index: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    bool isSelected = _currentBottomNavIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          if (_currentBottomNavIndex != index) {
            setState(() {
              _currentBottomNavIndex = index;
            });
          }

          // Navigate based on index
          if (index == 0) {
            Navigator.pushNamed(context, '/dashboard');
            debugPrint("Navigating to Dashboard screen via route '/dashboard'");
          } else if (index == 1) {
            // Already on Event1Screen, no navigation needed
            debugPrint("Switched to tab: $label (index $index) - Already on Event1Screen");
          } else if (index == 2) {
            Navigator.pushNamed(context, '/message1');
            debugPrint("Navigating to Message1 screen via route '/message1'");
          } else if (index == 3) {
            Navigator.pushNamed(context, '/group1');
            debugPrint("Navigating to Group1 screen via route '/group1'");
          } else if (index == 4) {
            Navigator.pushNamed(context, '/profile');
            debugPrint("Navigating to Profile screen via route '/profile'");
          }
        },
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: isSelected ? kWhiteTextColor : kMediumGrayTextColor.withOpacity(0.8), // Adjusted colors
              size: isSelected ? 28 : 24, // Larger active icon
            ),
            const SizedBox(height: 4), // Consistent spacing
            Text(
              label,
              style: kBottomNavTextStyle.copyWith(
                color: isSelected ? kWhiteTextColor : kMediumGrayTextColor.withOpacity(0.8), // Adjusted colors
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCardsSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: _buildEventCard('Cricket Match on 12th', Icons.sports_cricket, context)),
            const SizedBox(width: 16), // Increased spacing between cards
            Expanded(child: _buildEventCard('Soccer Match on 15th', Icons.sports_soccer, context)),
          ],
        ),
        const SizedBox(height: 16), // Increased spacing between rows of cards
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: _buildEventCard('Team Meeting on 20th', Icons.group_work, context)),
            const SizedBox(width: 16), // Increased spacing between cards
            Expanded(child: _buildEventCard('Annual Party on 25th', Icons.celebration, context)),
          ],
        ),
      ],
    );
  }

  Widget _buildEventCard(String text, IconData iconData, BuildContext context) {
    return Card(
      elevation: 4, // Increased elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18), // More rounded corners
      ),
      color: kWhiteTextColor, // Cards should be white for contrast
      child: InkWell(
        onTap: () {
          debugPrint('$text card pressed');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$text card tapped!', style: const TextStyle(color: kWhiteTextColor)),
              backgroundColor: kAccentBlue, // Themed snackbar
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                iconData,
                size: 36, // Slightly larger icons
                color: kAccentBlue, // Accent color for icons
              ),
              const SizedBox(height: 10), // Increased spacing
              Text(
                text,
                textAlign: TextAlign.center,
                style: kCardTextStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingEventsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0), // Small padding for the header row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Upcoming Events',
            style: kEventTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold), // Larger header
          ),
          TextButton(
            onPressed: () {
              debugPrint('See All pressed');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('See All upcoming events tapped!', style: TextStyle(color: kWhiteTextColor)),
                  backgroundColor: kAccentBlue,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              // Navigator.pushNamed(context, '/allEvents'); // Example navigation
            },
            child: Text(
              'See All',
              style: kEventSubtitleTextStyle.copyWith(color: kGradientMediumBlue, fontWeight: FontWeight.w600), // Themed color
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventDetails() {
    return Column(
      children: [
        _buildEventDetailRow(
            'Cricket Match - 09:00 am',
            'Confirmed',
            Icons.check_circle_rounded, // Filled icon for status
            kSuccessColor, // Themed success color
            context
        ),
        const Divider(height: 25, thickness: 1.0, color: kDividerColor), // Thicker, themed divider
        _buildEventDetailRow(
            'Soccer Match - 07:00 pm',
            'Maybe',
            Icons.help_rounded, // Filled icon for status
            kWarningColor, // Themed warning color
            context
        ),
        const Divider(height: 25, thickness: 1.0, color: kDividerColor),
        _buildEventDetailRow(
            'Team Meeting - 10:00 am',
            'Pending',
            Icons.pending_actions_rounded, // Filled icon for status
            kInfoColor, // Themed info color
            context
        ),
      ],
    );
  }

  Widget _buildEventDetailRow(String title, String status, IconData icon, Color iconColor, BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('Event detail row tapped: $title');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title details tapped!', style: const TextStyle(color: kWhiteTextColor)),
            backgroundColor: kAccentBlue,
            behavior: SnackBarBehavior.floating,
          ),
        );
        // Example: Navigator.pushNamed(context, '/eventDetail', arguments: title);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0), // Increased padding
        child: Row(
          children: <Widget>[
            Icon(icon, size: 24, color: iconColor), // Larger icon
            const SizedBox(width: 16), // Increased spacing
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: kEventTextStyle,
                  ),
                  const SizedBox(height: 4), // More space
                  Text(
                    status,
                    style: kEventSubtitleTextStyle.copyWith(color: iconColor, fontWeight: FontWeight.w500), // Status text color matching icon
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 20, color: kMediumGrayTextColor.withOpacity(0.7)), // Themed arrow
          ],
        ),
      ),
    );
  }
}