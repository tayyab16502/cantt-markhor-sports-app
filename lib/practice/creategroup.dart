import 'package:flutter/material.dart';
// import 'dart:io'; // Only needed if you are actually loading File images

// --- Gradient Color Constants ---
const Color kGradientTopBlue = Color(0xFF0033FF);
const Color kGradientMediumBlue = Color(0xFF0600AB);
const Color kGradientBottomBlue = Color(0xFF00003D);

// --- Adjusted Colors for the new theme ---
const Color kWhiteTextColor = Colors.white; // Main text color is white for contrast
const Color kLightBlueFieldBackground = Colors.white; // Solid white background for fields
const Color kDarkBlueInputFieldText = Color(0xFF00003D); // Dark blue for input text
const Color kSlightlyDarkerBlueHint = Color(0xFFA09CAB); // For hints or less prominent text (medium grey/blue)
const Color kPrimaryButtonBlue = kGradientMediumBlue; // Using the middle gradient blue for the button
const Color kTextFieldOutlineColor = Colors.white; // White outline for text fields
const Color kFocusedOutlineColor = kGradientTopBlue; // Brighter blue for focused outline
const Color kErrorColor = Color(0xFFFF5252); // Standard Material error color, good contrast on blue
const Color kChipSelectedBackground = kGradientTopBlue; // Top gradient blue for selected chip
const Color kChipUnselectedBackground = Colors.white12; // Subtle, transparent white for unselected chips
const Color kChipBorderColor = Colors.white30; // Light transparent white for chip borders


// --- Reusable Text Styles (Adjusted for the new theme) ---
const String _kFontFamily = 'Inter'; // Define font family once

TextStyle get _kAppBarTitleTextStyle => const TextStyle(
  color: kWhiteTextColor, // White text on dark app bar
  fontFamily: _kFontFamily,
  fontSize: 24, // Slightly larger for better prominence
  fontWeight: FontWeight.bold,
);

TextStyle get _kSectionTitleTextStyle => const TextStyle(
  color: kWhiteTextColor, // White text against gradient
  fontFamily: _kFontFamily,
  fontSize: 18,
  fontWeight: FontWeight.w600, // Semi-bold
  height: 1.5,
);

TextStyle get _kInputHintTextStyle => const TextStyle(
  color: kSlightlyDarkerBlueHint, // Lighter hint text
  fontFamily: _kFontFamily,
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.25,
);

TextStyle get _kInputTextStyle => const TextStyle(
  color: kDarkBlueInputFieldText, // Dark text on light field background
  fontFamily: _kFontFamily,
  fontSize: 16,
  fontWeight: FontWeight.normal,
);

TextStyle get _kButtonTextStyle => const TextStyle(
  color: kWhiteTextColor, // White text on blue button
  fontFamily: _kFontFamily,
  fontSize: 18, // Larger for button prominence
  fontWeight: FontWeight.bold, // Bold text
  height: 1.375,
);

TextStyle get _kChipTextStyle => const TextStyle(
  fontFamily: _kFontFamily,
  fontSize: 15, // Slightly larger for readability
  fontWeight: FontWeight.normal,
);

// --- Data Model for the new group ---
class Group {
  final String id;
  final String name;
  final String imageUrl;
  final String memberCount;
  final String category;
  final String? description;
  final String? location;

  Group({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.memberCount,
    required this.category,
    this.description,
    this.location,
  });
}

class CreateGroupScreen extends StatefulWidget { // Renamed to Screen for consistency
  const CreateGroupScreen({super.key});

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _groupNameController;
  late TextEditingController _groupDescriptionController;
  late TextEditingController _locationController;

  String? _selectedSport;
  // File? _pickedImage; // If you plan to implement image picking
  final List<String?> _imagePlaceholders = [null, null, null]; // For multiple images

  final List<String> _sportTypes = ['Football', 'Basketball', 'Tennis', 'Running', 'Cycling', 'Yoga', 'Badminton', 'Swimming']; // Added more sports

  @override
  void initState() {
    super.initState();
    _groupNameController = TextEditingController();
    _groupDescriptionController = TextEditingController();
    _locationController = TextEditingController();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    _groupDescriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _createGroup() {
    // Basic validation for sport type (formKey doesn't cover ChoiceChips directly)
    bool isSportSelected = _selectedSport != null;

    if (_formKey.currentState!.validate() && isSportSelected) {
      final newGroup = Group(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _groupNameController.text.trim(),
        description: _groupDescriptionController.text.trim(),
        imageUrl: 'assets/images/default_group_placeholder.png', // Placeholder
        memberCount: '1 member', // Default for new group creator
        category: _selectedSport!, // Safe to use ! because we checked isSportSelected
        location: _locationController.text.trim().isNotEmpty ? _locationController.text.trim() : 'Not specified',
      );

      print('New Group Created: ${newGroup.name}, Sport: ${newGroup.category}, Location: ${newGroup.location}');
      Navigator.pop(context, newGroup); // Pass the new group back if needed

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${newGroup.name} group created successfully!', style: const TextStyle(color: kWhiteTextColor)),
          backgroundColor: kGradientTopBlue, // Use a theme color
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      String errorMessage = '';
      if (!isSportSelected) {
        errorMessage += 'Please select a sport type. ';
      }
      if (!_formKey.currentState!.validate()) {
        errorMessage += 'Please fill all required fields.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage.trim(), style: const TextStyle(color: kWhiteTextColor)),
          backgroundColor: kErrorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Will be covered by Container's gradient
      extendBodyBehindAppBar: true, // Allows body to go behind transparent AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make AppBar transparent
        elevation: 0, // No shadow for a cleaner look with the gradient
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: kWhiteTextColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Create Group', style: _kAppBarTitleTextStyle),
        centerTitle: true,
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0), // Increased horizontal padding
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20), // Spacing below AppBar (already handled by SafeArea and Scrollview padding)
                  Text('Group Images (Optional)', style: _kSectionTitleTextStyle),
                  const SizedBox(height: 16), // Adjusted spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(3, (index) => _buildImagePlaceholder(index)),
                  ),
                  const SizedBox(height: 32), // More space before first input

                  _buildTextField(
                    controller: _groupNameController,
                    hintText: 'Enter group name',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Group name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20), // Adjusted spacing

                  _buildTextField(
                    controller: _groupDescriptionController,
                    hintText: 'Tell us about your group (e.g., goals, activities)',
                    maxLines: 4, // More lines for description
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Group description is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32), // Adjusted spacing

                  Text('Sport Type', style: _kSectionTitleTextStyle),
                  const SizedBox(height: 16), // Adjusted spacing
                  _buildSportTypeChips(),
                  const SizedBox(height: 32), // Adjusted spacing

                  Text('Location (Optional)', style: _kSectionTitleTextStyle),
                  const SizedBox(height: 16), // Adjusted spacing
                  _buildTextField(
                    controller: _locationController,
                    hintText: 'Search for a location (e.g., city, park)',
                    prefixIcon: Icons.location_on_outlined,
                  ),
                  const SizedBox(height: 40), // Spacing before the button container
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildCreateGroupButton(context),
    );
  }

  Widget _buildImagePlaceholder(int index) {
    return GestureDetector(
      onTap: () {
        print('Select image $index');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image picker for slot ${index + 1} coming soon!', style: const TextStyle(color: kWhiteTextColor)),
            backgroundColor: kGradientMediumBlue,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Container(
        width: 90, // Slightly larger placeholder
        height: 90, // Slightly larger placeholder
        decoration: BoxDecoration(
          color: kWhiteTextColor.withOpacity(0.15), // Semi-transparent white
          borderRadius: BorderRadius.circular(16), // More rounded corners
          border: Border.all(color: kWhiteTextColor.withOpacity(0.4), width: 1.5), // Slightly thicker, more visible border
        ),
        child: _imagePlaceholders[index] == null
            ? Icon(Icons.add_a_photo_outlined, color: kWhiteTextColor.withOpacity(0.8), size: 35) // Slightly larger icon
            : ClipRRect(
          borderRadius: BorderRadius.circular(16),
          // child: Image.file(File(_imagePlaceholders[index]!), fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    IconData? prefixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: _kInputTextStyle, // Dark text on light field
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: _kInputHintTextStyle,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: kSlightlyDarkerBlueHint) : null, // Hint icon color
        filled: true,
        fillColor: kLightBlueFieldBackground, // Solid white background for text fields
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none, // No border by default
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: kTextFieldOutlineColor, width: 1), // White outline
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: kFocusedOutlineColor, width: 2), // Accent border on focus
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: kErrorColor, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: kErrorColor, width: 2),
        ),
        errorStyle: const TextStyle(color: kErrorColor, fontWeight: FontWeight.w500),
      ),
      validator: validator,
    );
  }

  Widget _buildSportTypeChips() {
    return Wrap(
      spacing: 12.0, // Increased spacing
      runSpacing: 12.0, // Increased vertical spacing
      children: _sportTypes.map((sport) {
        bool isSelected = _selectedSport == sport;
        return ChoiceChip(
          label: Text(
              sport,
              style: _kChipTextStyle.copyWith(
                color: isSelected ? kWhiteTextColor : kGradientBottomBlue, // White for selected, dark blue for unselected text
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              )
          ),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _selectedSport = sport;
              }
              // Allow deselection only if another is selected or it's mandatory to pick one
              // For mandatory choice, remove 'else { _selectedSport = null; }'
            });
          },
          backgroundColor: isSelected ? kChipSelectedBackground : kChipUnselectedBackground, // Theme colors
          selectedColor: kChipSelectedBackground, // Theme color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(
              color: isSelected ? kChipSelectedBackground : kChipBorderColor, // Border matches fill
              width: 1.5,
            ),
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          pressElevation: 0, // No elevation change on press for cleaner look
        );
      }).toList(),
    );
  }

  Widget _buildCreateGroupButton(BuildContext context) {
    return Container(
      // Bottom padding dynamically handles safe area
      padding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).padding.bottom > 0 ? MediaQuery.of(context).padding.bottom : 24, // Consistent 24 horizontal padding
          top: 16 // Padding above the button
      ),
      // Solid background for the bottom bar for distinction
      decoration: const BoxDecoration(
        color: kGradientBottomBlue, // Darkest blue from gradient
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryButtonBlue, // Use the defined primary button blue
          padding: const EdgeInsets.symmetric(vertical: 18), // Slightly more vertical padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0), // More rounded corners
          ),
          minimumSize: const Size(double.infinity, 56), // Taller button
          elevation: 5, // Add some elevation to make it pop
        ),
        onPressed: _createGroup,
        child: Text('Create Group', style: _kButtonTextStyle),
      ),
    );
  }
}