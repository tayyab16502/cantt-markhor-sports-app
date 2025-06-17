import 'package:flutter/material.dart';
// import 'package:practiceapp/practice/apptutorial.dart'; // Ensure this path is correct if navigating

// --- Constants for Reusability and Theme Colors ---
const Color _kGradientTop = Color(0xFF0033FF);
const Color _kGradientMiddle = Color(0xFF0600AB);
const Color _kGradientBottom = Color(0xFF00003D);

const Color _kPrimaryTextColor = Colors.white; // Main text color on gradient
const Color _kSecondaryTextColor = Color(0xFFE0E0E0); // Lighter grey for hints
const Color _kTextFieldFillColor = Colors.white12; // Subtle transparent white for input fields
const Color _kTextFieldBorderColor = Colors.white24; // Subtle transparent white border
const Color _kFocusedBorderColor = Color(0xFFADD8E6); // Light blue for focused fields
const Color _kButtonBackgroundColor = Colors.white; // White button background
const Color _kButtonTextColor = Color(0xFF00003D); // Dark blue for button text (from gradient bottom)
const Color _kIconColor = Colors.white; // For AppBar back arrow and prefix icons
const Color _kDropdownIconColor = Color(0xFFA09CAB); // Medium grey/blue for dropdown icon

const String _kFontFamily = 'Inter'; // Ensure 'Inter' font is added to your project

// --- Text Styles ---
const TextStyle _kScreenTitleStyle = TextStyle(
  color: _kPrimaryTextColor, // Screen title is white
  fontFamily: _kFontFamily,
  fontSize: 28, // Adjusted for screen title
  fontWeight: FontWeight.bold,
  height: 1.1,
);

const TextStyle _kLabelTextStyle = TextStyle(
  color: _kPrimaryTextColor, // Labels are white
  fontFamily: _kFontFamily,
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.5,
);

const TextStyle _kInputTextStyle = TextStyle( // Style for text typed into the field
  color: _kPrimaryTextColor, // Input text itself should be white
  fontFamily: _kFontFamily,
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.25,
);

const TextStyle _kInputHintTextStyle = TextStyle(
  color: _kSecondaryTextColor, // Hints are lighter grey
  fontFamily: _kFontFamily,
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.25,
);

const TextStyle _kButtonTextStyle = TextStyle(
  color: _kButtonTextColor, // Button text is dark blue
  fontFamily: _kFontFamily,
  fontSize: 18, // Slightly larger button text
  fontWeight: FontWeight.bold, // Make button text bold
  height: 1.375,
);


class ProfileSetupScreen extends StatefulWidget { // Renamed for clarity
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _bioController = TextEditingController();
  final _locationController = TextEditingController();
  String? _selectedSport; // To store the selected favorite sport

  // Example sports for the dropdown
  final List<String> _sports = ['Soccer', 'Basketball', 'Tennis', 'Running', 'Cricket', 'Swimming', 'Cycling', 'Other'];

  @override
  void dispose() {
    _bioController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_bioController.text.isEmpty || _locationController.text.isEmpty || _selectedSport == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields to save your profile.", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }
    // TODO: Implement your profile saving logic here (e.g., API call)
    print('Bio: ${_bioController.text}');
    print('Location: ${_locationController.text}');
    print('Favorite Sport: $_selectedSport');

    // Simulate successful profile save
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile Saved Successfully!", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate to the next screen (e.g., app tutorial or home screen)
    Navigator.pushNamed(context, '/tutorial'); // Using '/tutorial' as per your original button action
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Make Scaffold background transparent
      extendBodyBehindAppBar: true, // Allow body to extend behind AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar background transparent
        elevation: 0,
        // Optional: Add a back button if this screen isn't the first one after login/signup
        leading: IconButton( // Adding back button for better navigation flow
          icon: const Icon(Icons.arrow_back, color: _kIconColor), // Back icon is white
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Set Up Your Profile',
          style: _kScreenTitleStyle, // Use the new screen title style
        ),
        centerTitle: true,
      ),
      body: Container( // Wrap body in Container for gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _kGradientTop,
              _kGradientMiddle,
              _kGradientBottom,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0), // Increased horizontal padding
            child: SingleChildScrollView( // To prevent overflow with keyboard
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 32), // Space below AppBar title

                  // Bio Label
                  const Text('Bio', textAlign: TextAlign.left, style: _kLabelTextStyle),
                  const SizedBox(height: 10), // Adjusted spacing
                  _buildTextField(
                    controller: _bioController,
                    hintText: 'Tell us about yourself (e.g., interests, goals)',
                    maxLines: 4, // Allow more lines for a detailed bio
                  ),
                  const SizedBox(height: 24),

                  // Location Label
                  const Text('Location', textAlign: TextAlign.left, style: _kLabelTextStyle),
                  const SizedBox(height: 10), // Adjusted spacing
                  _buildTextField(
                    controller: _locationController,
                    hintText: 'Enter your city or region',
                    prefixIcon: Icons.location_on_outlined, // Material icon for location
                  ),
                  const SizedBox(height: 24),

                  // Favorite Sports Label
                  const Text('Favorite Sport', textAlign: TextAlign.left, style: _kLabelTextStyle), // Changed to singular
                  const SizedBox(height: 10), // Adjusted spacing
                  _buildSportsDropdown(),
                  const SizedBox(height: 40), // More space before button

                  // Save Profile Button
                  _buildSaveProfileButton(),

                  const SizedBox(height: 60), // Generous spacing before bottom indicator

                  // Bottom indicator
                  Center(
                    child: Container(
                      width: 120, // Slightly wider
                      height: 5, // Slightly thicker
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8), // White with transparency
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24), // Padding at the very bottom
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    IconData? prefixIcon,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: _kInputTextStyle, // Input text color is white
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: _kInputHintTextStyle,
        filled: true,
        fillColor: _kTextFieldFillColor, // Transparent white fill
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: _kIconColor) // Prefix icon is white
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14), // More rounded corners
          borderSide: BorderSide.none, // No default border
        ),
        enabledBorder: OutlineInputBorder( // Subtle border for enabled state
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: _kTextFieldBorderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder( // Highlight border for focused state
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _kFocusedBorderColor, width: 2), // Light blue focus
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16), // Adjusted padding
      ),
    );
  }

  Widget _buildSportsDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4), // Adjusted padding
      decoration: BoxDecoration(
        color: _kTextFieldFillColor, // Transparent white fill
        borderRadius: BorderRadius.circular(14), // More rounded corners
        border: Border.all(color: _kTextFieldBorderColor, width: 1), // Subtle border
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedSport,
          isExpanded: true,
          hint: const Text('Select your favorite sport', style: _kInputHintTextStyle),
          icon: const Icon(Icons.arrow_drop_down, color: _kDropdownIconColor), // Dropdown icon color
          items: _sports.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: _kInputTextStyle), // Text in dropdown items is white
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedSport = newValue;
            });
          },
          dropdownColor: _kGradientBottom, // Darkest blue for dropdown menu background
          style: _kInputTextStyle, // Ensure selected item in dropdown has correct text style
        ),
      ),
    );
  }

  Widget _buildSaveProfileButton() {
    return ElevatedButton(
      onPressed: _saveProfile, // Calls the _saveProfile method
      style: ElevatedButton.styleFrom(
        backgroundColor: _kButtonBackgroundColor, // White button background
        padding: const EdgeInsets.symmetric(vertical: 18), // Increased vertical padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14), // More rounded
        ),
        minimumSize: const Size(double.infinity, 54), // Taller button
        elevation: 6, // Added elevation for a lifted effect
        shadowColor: Colors.black.withOpacity(0.5), // Darker shadow
      ),
      child: const Text('Save Profile', style: _kButtonTextStyle), // Text style includes dark color
    );
  }
}