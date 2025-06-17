import 'package:flutter/material.dart';

// --- Gradient Color Constants ---
const Color kGradientTopBlue = Color(0xFF0033FF);
const Color kGradientMediumBlue = Color(0xFF0600AB);
const Color kGradientBottomBlue = Color(0xFF00003D);

// --- General Theme Colors ---
const Color kWhiteTextColor = Colors.white; // Main text color is white for contrast
const Color kDarkBlueTextColor = Color(0xFF00003D); // For text on white backgrounds
const Color kLightHintTextColor = Color(0xFFE0E0E0); // Lighter grey/white for hints/secondary text on dark
const Color kSemiTransparentWhite = Colors.white12; // Subtle, transparent white for elements
const Color kPrimaryButtonBlue = kGradientMediumBlue; // Main action button color
const Color kSecondaryButtonBackground = Colors.white; // White for secondary button background
const Color kSecondaryButtonText = kDarkBlueTextColor; // Dark text for white secondary button
const Color kErrorColor = Color(0xFFFF5252); // Standard Material error color, good contrast on blue

// --- Font Family Constant ---
const String _kFontFamily = 'Inter'; // Assuming 'Inter' font is available

// --- Reusable Text Styles ---
TextStyle get _kAppBarTitleTextStyle => const TextStyle(
  color: kWhiteTextColor,
  fontFamily: _kFontFamily,
  fontSize: 24, // Slightly larger for better prominence
  fontWeight: FontWeight.bold,
);

TextStyle get _kBodyTextStyle => const TextStyle(
  color: kWhiteTextColor, // Main text will be white on the gradient
  fontFamily: _kFontFamily,
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.5,
);

TextStyle get _kCardSubtitleTextStyle => const TextStyle( // For hints or secondary text like "Public"
  color: kLightHintTextColor, // Use the light hint color for subtitles
  fontFamily: _kFontFamily,
  fontSize: 14,
  fontWeight: FontWeight.normal,
  height: 1.4,
);

TextStyle get _kPostInputHintTextStyle => const TextStyle( // Specific hint for post input
  color: kLightHintTextColor, // Lighter grey/white hint
  fontFamily: _kFontFamily,
  fontSize: 18, // Larger hint text for main input area
  fontWeight: FontWeight.normal,
);

TextStyle get _kButtonTextStyle => const TextStyle(
  color: kWhiteTextColor, // White text on blue primary button
  fontFamily: _kFontFamily,
  fontSize: 18, // Larger for button prominence
  fontWeight: FontWeight.bold,
);

class CreatePostScreen extends StatefulWidget { // Renamed for clarity and consistency
  const CreatePostScreen({super.key});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _postTextController = TextEditingController();

  @override
  void dispose() {
    _postTextController.dispose();
    super.dispose();
  }

  void _handlePost() {
    if (_postTextController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot post an empty message.', style: TextStyle(color: kWhiteTextColor)),
          backgroundColor: kErrorColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    print('Post button pressed with text: ${_postTextController.text}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Post published: "${_postTextController.text}"', style: const TextStyle(color: kWhiteTextColor)),
        backgroundColor: kGradientTopBlue,
        behavior: SnackBarBehavior.floating,
      ),
    );
    _postTextController.clear(); // Clear text after posting
    // Navigator.pop(context); // Optional: close the screen after posting
    // Navigator.pushNamed(context, '/dashboard'); // Optional: navigate to dashboard
  }

  void _handleUploadPhotos() {
    print('Upload Photos tapped');
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Upload photos feature (TODO)', style: TextStyle(color: kWhiteTextColor)),
          backgroundColor: kGradientMediumBlue, // Use a themed color
          behavior: SnackBarBehavior.floating,
        )
    );
    // Implement image picker logic here
  }

  void _handleCancel() {
    print('Cancel button pressed');
    // Consider adding a confirmation dialog for unsaved changes
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows body to go behind transparent AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar transparent to show gradient
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: kWhiteTextColor), // White icon
          onPressed: _handleCancel,
        ),
        title: Text(
          'Create Post',
          style: _kAppBarTitleTextStyle, // Themed AppBar title
        ),
        centerTitle: false, // Title aligned to the start
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kGradientTopBlue, kGradientMediumBlue, kGradientBottomBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea( // Ensures content is within safe area
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0), // Increased overall padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // User Profile Section
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 28, // Slightly larger avatar
                      backgroundImage: NetworkImage(
                        'https://placehold.co/60x60/E0E6FF/00003D?text=JD', // Placeholder, adjusted for size
                      ),
                      backgroundColor: kWhiteTextColor, // Background if image fails
                    ),
                    const SizedBox(width: 16), // Increased spacing
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: _kBodyTextStyle.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Public', // Consider an actual visibility setting here
                          style: _kCardSubtitleTextStyle, // Uses themed subtitle style
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24), // Increased spacing

                // Text Input Field for Post Content
                Expanded(
                  child: TextField(
                    controller: _postTextController,
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    style: _kBodyTextStyle, // White text for input
                    cursorColor: kWhiteTextColor,
                    decoration: InputDecoration(
                      hintText: "What's on your mind?",
                      hintStyle: _kPostInputHintTextStyle, // Specific style for post hint
                      border: InputBorder.none, // No border for a clean look
                      contentPadding: EdgeInsets.zero, // No extra padding within the text field itself
                    ),
                  ),
                ),
                const SizedBox(height: 24), // Increased spacing

                // Upload Photos Section
                InkWell(
                  onTap: _handleUploadPhotos,
                  borderRadius: BorderRadius.circular(12),
                  splashFactory: NoSplash.splashFactory, // To reduce visual clutter on tap
                  highlightColor: Colors.transparent, // To reduce visual clutter on tap
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0), // Increased padding
                    decoration: BoxDecoration(
                      color: kSemiTransparentWhite, // Subtle background
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5), // Subtle border
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // To keep content tight
                      children: [
                        const Icon(
                          Icons.photo_library_outlined,
                          color: kWhiteTextColor, // White icon
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Add Photos', // Changed text for clarity
                          style: _kBodyTextStyle.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32), // More space before buttons

                // Action Buttons: Post and Cancel
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _handlePost,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryButtonBlue, // Themed button color
                          foregroundColor: kWhiteTextColor, // Text color for the button
                          padding: const EdgeInsets.symmetric(vertical: 16), // Increased vertical padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14), // More rounded
                          ),
                          elevation: 5, // Added elevation
                          shadowColor: Colors.black.withOpacity(0.4), // Darker shadow
                        ),
                        child: Text(
                          'Post',
                          style: _kButtonTextStyle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Increased spacing between buttons
                    Expanded(
                      child: OutlinedButton( // Changed to OutlinedButton for secondary action
                        onPressed: _handleCancel,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: kSecondaryButtonBackground, // White background
                          foregroundColor: kSecondaryButtonText, // Dark blue text
                          padding: const EdgeInsets.symmetric(vertical: 16), // Increased vertical padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14), // More rounded
                          ),
                          side: BorderSide(color: kWhiteTextColor.withOpacity(0.5), width: 1.5), // Subtle border
                          elevation: 0, // No elevation for outlined button
                        ),
                        child: Text(
                          'Cancel',
                          style: _kButtonTextStyle.copyWith(color: kSecondaryButtonText), // Ensure dark text
                        ),
                      ),
                    ),
                  ],
                ),
                // Padding for the bottom safe area is now handled by the main Padding and SafeArea
              ],
            ),
          ),
        ),
      ),
    );
  }
}