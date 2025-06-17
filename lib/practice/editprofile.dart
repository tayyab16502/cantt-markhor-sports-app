import 'package:flutter/material.dart';

// --- Gradient Color Constants ---
const Color kGradientTopBlue = Color(0xFF0033FF);
const Color kGradientMediumBlue = Color(0xFF0600AB);
const Color kGradientBottomBlue = Color(0xFF00003D);

// --- General Theme Colors ---
const Color kWhiteTextColor = Colors.white;
const Color kLightBlueFieldBackground = Color(0xFFE0E6FF);
const Color kDarkBlueInputFieldText = Color(0xFF00003D);
const Color kHintTextColor = Color(0xFF7A8BFF);
const Color kPrimaryButtonBlue = kGradientMediumBlue;
const Color kErrorColor = Color(0xFFFF5252);
const Color kSuccessSnackbarColor = Color(0xFF4CAF50);

// --- Reusable Text Styles ---
const TextStyle _kAppBarTitleTextStyle = TextStyle(
  color: kWhiteTextColor,
  fontFamily: 'Inter',
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

const TextStyle _kSectionLabelTextStyle = TextStyle(
  color: kWhiteTextColor,
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

const TextStyle _kInputTextStyle = TextStyle(
  color: kDarkBlueInputFieldText,
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.normal,
);

const TextStyle _kInputHintTextStyle = TextStyle(
  color: kHintTextColor,
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.normal,
);

const TextStyle _kButtonTextStyle = TextStyle(
  color: kWhiteTextColor,
  fontFamily: 'Inter',
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    // Initialize with values from the image
    _nameController.text = 'Tayyab Khan';
    _emailController.text = 'tayyab.khan@gmail.com';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    debugPrint('Pick image Tapped');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image picker (TODO) - Add image_picker package',
            style: TextStyle(color: kWhiteTextColor)),
        backgroundColor: kGradientTopBlue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      debugPrint('Name: ${_nameController.text}');
      debugPrint('Email: ${_emailController.text}');
      if (_passwordController.text.isNotEmpty) {
        debugPrint('New Password: (hidden)');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profile Changes Saved!',
            style: _kButtonTextStyle.copyWith(
                fontWeight: FontWeight.normal, fontSize: 16),
          ),
          backgroundColor: kSuccessSnackbarColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(15),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please correct the errors in the form.',
              style: TextStyle(color: kWhiteTextColor)),
          backgroundColor: kErrorColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(15),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: kWhiteTextColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Edit Profile', style: _kAppBarTitleTextStyle),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: kWhiteTextColor), // Assuming this is the icon from the image
            onPressed: () {
              // Handle action for the person icon
            },
          ),
        ],
      ),
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [kGradientTopBlue, kGradientMediumBlue, kGradientBottomBlue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              // Remove ConstrainedBox here
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: kToolbarHeight * 0.5),
                      _buildProfilePictureSection(),
                      const SizedBox(height: 40),
                      _buildTextField(
                        controller: _nameController,
                        label: 'Name',
                        hint: 'Enter your name',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email',
                        hint: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      _buildTextField(
                        controller: _passwordController,
                        label: 'New Password',
                        hint: 'Leave blank to keep current password',
                        obscureText: _obscureText,
                        isPassword: true,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryButtonBlue,
                          foregroundColor: kWhiteTextColor,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 5,
                          shadowColor: Colors.black.withOpacity(0.4),
                        ),
                        child: Text('Save Changes', style: _kButtonTextStyle),
                      ),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePictureSection() {
    return Column(
      children: [
        Text(
          'Profile Picture',
          style: _kSectionLabelTextStyle.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: _pickImage,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Use Image.asset or NetworkImage here for the profile picture
              // For demonstration, I'll keep the CircleAvatar with a placeholder icon
              // If you have a specific image from the user, you can load it like:
              // CircleAvatar(
              //   radius: 60,
              //   backgroundImage: AssetImage('assets/profile_pic.png'), // Or NetworkImage('url')
              // ),
              CircleAvatar(
                radius: 60,
                backgroundColor: kLightBlueFieldBackground.withOpacity(0.4),
                child: Image.asset(
                  'edit.jpg', // Assuming 'edit.jpg' is in your assets and configured in pubspec.yaml
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: kGradientMediumBlue,
                    shape: BoxShape.circle,
                    border: Border.all(color: kWhiteTextColor, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: kWhiteTextColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: _kSectionLabelTextStyle,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          obscureText: isPassword ? _obscureText : false,
          keyboardType: keyboardType,
          style: _kInputTextStyle,
          cursorColor: kGradientTopBlue,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: _kInputHintTextStyle,
            filled: true,
            fillColor: kLightBlueFieldBackground,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kGradientTopBlue, width: 2.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: kErrorColor, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: kErrorColor, width: 2.5),
            ),
            errorStyle: const TextStyle(
                color: kErrorColor,
                fontWeight: FontWeight.w500,
                fontSize: 13),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                _obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: kGradientMediumBlue,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
                : null,
          ),
          validator: validator,
        ),
      ],
    );
  }
}