import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart'; // Uncomment if you use SVGs

// --- Constants for Colors and Styles ---
// Updated text colors for a dark background
const Color kPrimaryTextColor = Colors.white; // Changed to white for dark background
const Color kBackgroundColor = Colors.transparent; // Scaffold background is now transparent
const Color kAppBarIconColor = Colors.white; // Changed to white for back icon

const TextStyle kScreenTitleStyle = TextStyle(
  color: kPrimaryTextColor,
  fontFamily: 'Inter',
  fontSize: 32,
  fontWeight: FontWeight.normal,
  height: 1.25,
);

const TextStyle kSectionTitleStyle = TextStyle(
  color: Colors.white, // Changed to white
  fontFamily: 'Inter',
  fontSize: 20,
  fontWeight: FontWeight.normal,
  height: 1.6,
);

const TextStyle kSettingsItemStyle = TextStyle(
  color: Color.fromRGBO(230, 230, 255, 1), // A light bluish white
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.5, // Adjusted for better readability with switches
);

const TextStyle kSettingsActionStyle = TextStyle(
  color: Color.fromRGBO(230, 230, 255, 1), // A light bluish white
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1,
);

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  // State variables for switches
  bool _isDarkMode = false;
  bool _pushNotificationsEnabled = true;
  bool _eventNotificationsEnabled = true;
  bool _groupAlertsEnabled = false;

  // Helper widget for section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Adjusted padding
      child: Text(title, style: kSectionTitleStyle),
    );
  }

  // Helper widget for settings items with a switch
  Widget _buildSwitchSettingItem(
      String title, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      title: Text(title, style: kSettingsItemStyle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF0033FF), // Active color for switch - top gradient color
        inactiveThumbColor: const Color.fromRGBO(100, 100, 150, 1), // Lighter subtle blue for inactive thumb
        inactiveTrackColor: const Color.fromRGBO(50, 50, 100, 1), // Darker subtle blue for inactive track
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), // Adjusted padding
    );
  }

  // Helper widget for settings items that perform an action (e.g., navigate)
  Widget _buildActionSettingItem(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title, style: kSettingsActionStyle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color.fromRGBO(190, 190, 220, 1)), // Lighter grey/blue for arrow
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor, // Scaffold background transparent
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar background transparent
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: kAppBarIconColor), // Icon color
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            print("Back button pressed");
          },
        ),
        title: const Text(
          'Advanced Settings',
          style: kScreenTitleStyle,
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: Container( // Wrap body in a Container for the gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0033FF), // Top color: #0033FF
              Color(0xFF0600AB), // Middle color: #0600AB
              Color(0xFF00003D), // Bottom color: #00003D
            ],
          ),
        ),
        child: ListView(
          children: <Widget>[
            _buildSectionTitle('Display Settings'),
            _buildSwitchSettingItem('Dark Mode', _isDarkMode, (bool value) {
              setState(() {
                _isDarkMode = value;
              });
              print("Dark Mode: $_isDarkMode");
              // Add logic to change theme
            }),
            _buildActionSettingItem('Font Size', () {
              print("Font Size tapped");
              // Navigate to font size settings
            }),
            const Divider(height: 20, indent: 16, endIndent: 16, color: Color.fromRGBO(60, 60, 100, 1)), // Adjusted divider color

            _buildSectionTitle('Account Management'),
            _buildActionSettingItem('Change Email', () {
              print("Change Email tapped");
              // Navigate or show dialog
            }),
            _buildActionSettingItem('Reset Password', () {
              print("Reset Password tapped");
              // Navigate or show dialog
            }),
            _buildActionSettingItem('Delete Account', () {
              print("Delete Account tapped");
              // Show confirmation dialog
            }),
            const Divider(height: 20, indent: 16, endIndent: 16, color: Color.fromRGBO(60, 60, 100, 1)), // Adjusted divider color

            _buildSectionTitle('Notifications'),
            _buildSwitchSettingItem(
                'Push Notifications', _pushNotificationsEnabled, (bool value) {
              setState(() {
                _pushNotificationsEnabled = value;
              });
              print("Push Notifications: $_pushNotificationsEnabled");
            }),
            _buildSwitchSettingItem(
                'Event Notifications', _eventNotificationsEnabled, (bool value) {
              setState(() {
                _eventNotificationsEnabled = value;
              });
              print("Event Notifications: $_eventNotificationsEnabled");
            }),
            _buildSwitchSettingItem('Group Alerts', _groupAlertsEnabled, (bool value) {
              setState(() {
                _groupAlertsEnabled = value;
              });
              print("Group Alerts: $_groupAlertsEnabled");
            }),
            const Divider(height: 20, indent: 16, endIndent: 16, color: Color.fromRGBO(60, 60, 100, 1)), // Adjusted divider color

            _buildSectionTitle('Data & Privacy'),
            _buildActionSettingItem('Export Data', () {
              print("Export Data tapped");
            }),
            _buildActionSettingItem('Clear Cache', () {
              print("Clear Cache tapped");
              // Implement cache clearing logic
            }),
            _buildActionSettingItem('Privacy Preferences', () {
              print("Privacy Preferences tapped");
              // Navigate to privacy preferences
            }),
            const Divider(height: 20, indent: 16, endIndent: 16, color: Color.fromRGBO(60, 60, 100, 1)), // Adjusted divider color

            _buildActionSettingItem('About Us', () {
              print("About Us tapped");
              // Navigate to About Us screen
            }),
            const SizedBox(height: 20), // For bottom padding
          ],
        ),
      ),
    );
  }
}