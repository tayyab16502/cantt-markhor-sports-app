import 'package:flutter/material.dart';

// --- Constants for Reusability ---
// New Gradient Colors
const Color _kGradientTop = Color(0xFF0033FF);
const Color _kGradientMiddle = Color(0xFF0600AB);
const Color _kGradientBottom = Color(0xFF00003D);

// Adjusted colors for the new theme
const Color kScaffoldBackgroundColor = Colors.transparent; // Scaffold transparent to show gradient
const Color kPrimaryTextColor = Colors.white; // Main text color is white for contrast
const Color kSecondaryTextColor = Color(0xFFE0E0E0); // Lighter grey/white for hints/secondary text
const Color kTextFieldBackgroundColor = Colors.white12; // Subtle, transparent white for text fields
const Color kTextFieldBorderColor = Colors.white24; // Subtle border color for text fields
const Color kFocusedBorderColor = Color(0xFFADD8E6); // Light blue for focused borders
const Color kButtonColor = Colors.white; // White button for clear action
const Color kButtonTextColor = Color(0xFF00003D); // Dark text for white button (from gradient bottom)
const Color kIconColor = Colors.white; // Default icon color is white
const Color kBottomNavBackgroundColor = Colors.white; // Bottom nav bar is solid white
const Color kBottomNavIconActiveColor = Color(0xFF00003D); // Active nav icon is dark blue
const Color kBottomNavIconInactiveColor = Color(0xFFA09CAB); // Inactive nav icon is medium grey/blue


const String kFontFamily = 'Inter'; // Ensure 'Inter' font is added to your project

// --- Text Styles ---
// These styles are now independent of Brightness and designed for the dark gradient
TextStyle kScreenTitleStyle(BuildContext context) => const TextStyle(
  color: kPrimaryTextColor,
  fontFamily: kFontFamily,
  fontSize: 28, // Adjusted for screen title
  fontWeight: FontWeight.bold,
  height: 1,
);

TextStyle kSectionTitleStyle(BuildContext context) => const TextStyle(
  color: kPrimaryTextColor,
  fontFamily: kFontFamily,
  fontSize: 22, // Slightly larger for section titles
  fontWeight: FontWeight.bold,
  height: 1.6,
);

TextStyle kBodyTextStyle(BuildContext context) => const TextStyle(
  color: kPrimaryTextColor,
  fontFamily: kFontFamily,
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.5,
);

TextStyle kHintTextStyle(BuildContext context) => const TextStyle(
  color: kSecondaryTextColor, // Using the new light grey/white
  fontFamily: kFontFamily,
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.25,
);

const TextStyle kButtonTextStyle = TextStyle(
  color: kButtonTextColor, // Button text color is now dark for white button
  fontFamily: kFontFamily,
  fontSize: 18, // Slightly larger
  fontWeight: FontWeight.bold, // Make button text bold
  height: 1.375,
);

TextStyle kBottomNavTextStyle(BuildContext context, {bool isActive = false}) => TextStyle(
  fontFamily: kFontFamily,
  fontSize: 11,
  fontWeight: isActive ? FontWeight.bold : FontWeight.normal, // Active label bold
  height: 1,
  color: isActive ? kBottomNavIconActiveColor : kBottomNavIconInactiveColor,
);


class ContactUsScreen extends StatefulWidget { // Renamed for clarity and consistency
  const ContactUsScreen({super.key});

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text, // Added keyboardType
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8), // Increased horizontal padding
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType, // Apply keyboard type
        style: kBodyTextStyle(context).copyWith(color: kPrimaryTextColor), // Input text color is white
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: kHintTextStyle(context),
          filled: true,
          fillColor: kTextFieldBackgroundColor, // Using the new transparent white
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14), // More rounded corners
            borderSide: BorderSide.none, // No border by default
          ),
          enabledBorder: OutlineInputBorder( // Subtle border for enabled state
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: kTextFieldBorderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder( // Highlight border for focused state
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: kFocusedBorderColor, width: 2), // Light blue focus
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16), // Adjusted padding
        ),
      ),
    );
  }

  Widget _buildContactInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Increased horizontal padding
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 24,
            color: kIconColor, // Icon color is now white
          ),
          const SizedBox(width: 16),
          Flexible( // Use Flexible to prevent text overflow
            child: Text(
              text,
              style: kBodyTextStyle(context),
              overflow: TextOverflow.ellipsis, // Add ellipsis for long text
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor, // Set to transparent
      extendBodyBehindAppBar: true, // Crucial for gradient to go behind app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar background transparent
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: kIconColor), // Back button icon is white
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: Text('Contact Us', style: kScreenTitleStyle(context)),
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
        child: SafeArea( // Keep SafeArea for content
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24), // Add bottom padding to scroll view
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 32), // Increased spacing after app bar

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8), // Consistent padding
                  child: Text('Get in Touch', style: kSectionTitleStyle(context)),
                ),
                _buildTextField(controller: _nameController, hintText: 'Name', keyboardType: TextInputType.name),
                _buildTextField(controller: _emailController, hintText: 'Email', keyboardType: TextInputType.emailAddress),
                _buildTextField(
                    controller: _messageController,
                    hintText: 'Message',
                    maxLines: 5, // Increased maxLines for message field
                    keyboardType: TextInputType.multiline),
                const SizedBox(height: 24), // Increased spacing

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4), // Consistent padding
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kButtonColor, // White button background
                      padding: const EdgeInsets.symmetric(vertical: 16), // Increased vertical padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14), // More rounded
                      ),
                      elevation: 6, // Added elevation for professional look
                      shadowColor: Colors.black.withOpacity(0.5), // Darker shadow
                      minimumSize: const Size(double.infinity, 54), // Taller button
                    ),
                    onPressed: () {
                      if (_nameController.text.isEmpty || _emailController.text.isEmpty || _messageController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all fields before submitting.', style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                        return;
                      }

                      print('Submit tapped');
                      print('Name: ${_nameController.text}');
                      print('Email: ${_emailController.text}');
                      print('Message: ${_messageController.text}');
                      // Add logic to handle form submission (e.g., API call)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Message sent! We will get back to you soon.', style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.green,
                        ),
                      );
                      // Clear controllers after submission
                      _nameController.clear();
                      _emailController.clear();
                      _messageController.clear();
                    },
                    child: const Text('Submit', style: kButtonTextStyle), // Text style includes dark color
                  ),
                ),
                const SizedBox(height: 32), // Increased spacing

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8), // Consistent padding
                  child: Text('Support Contact', style: kSectionTitleStyle(context)),
                ),
                _buildContactInfoRow(Icons.email_outlined, 'support@canttmarkhor.com'), // More professional email
                _buildContactInfoRow(Icons.phone_outlined, '+92 3XX XXXXXXX'), // More realistic phone number
                const SizedBox(height: 32), // Increased spacing

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8), // Consistent padding
                  child: Text(
                    'Feel free to reach out anytime!',
                    textAlign: TextAlign.center,
                    style: kBodyTextStyle(context),
                  ),
                ),
                // No need for a large SizedBox here as SingleChildScrollView padding handles it,
                // and bottomNavBar is outside the scroll view.
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: kBottomNavBackgroundColor, // Solid white bottom nav bar
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15), // Slightly more pronounced shadow
              offset: const Offset(0, -1), // Adjusted offset
              blurRadius: 3, // Increased blur
            )
          ],
        ),
        padding: EdgeInsets.only(
          top: 14, // Increased top padding
          bottom: MediaQuery.of(context).padding.bottom > 0 ? MediaQuery.of(context).padding.bottom : 14, // Adjusted bottom padding
        ),
        child: const Row( // Changed to const as children are now constant widgets
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _ContactBottomNavItem(Icons.home_outlined, 'Home', isActive: false), // Home is not active
            _ContactBottomNavItem(Icons.headset_mic_outlined, 'Contact', isActive: true), // Contact is active for this screen
            _ContactBottomNavItem(Icons.person_outline, 'Profile', isActive: false), // Profile is not active
          ],
        ),
      ),
    );
  }
}

class _ContactBottomNavItem extends StatelessWidget {
  final IconData iconData;
  final String label;
  final bool isActive;

  const _ContactBottomNavItem(this.iconData, this.label, {this.isActive = false});

  @override
  Widget build(BuildContext context) { // Renamed parameter from buildContext to context
    final iconColor = isActive ? kBottomNavIconActiveColor : kBottomNavIconInactiveColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(iconData, size: 24, color: iconColor),
        const SizedBox(height: 8),
        Text(
          label,
          style: kBottomNavTextStyle(context, isActive: isActive), // Use context to get themed style
        ),
      ],
    );
  }
}