import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

// Define text styles for consistency, updated for the new theme
const TextStyle _kLabelTextStyle = TextStyle(
  color: Colors.white70, // Adjusted for dark background
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.5,
);

const TextStyle _kInputHintTextStyle = TextStyle(
  color: Colors.blueGrey, // Adjusted for light input fields on dark background
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.25,
);

const TextStyle _kButtonTextStyle = TextStyle(
  color: Color(0xFF00003D), // Dark blue for text on light button
  fontSize: 18,
  fontWeight: FontWeight.bold, // Make button text bold
  height: 1.375,
  letterSpacing: 0.5, // Added for better readability of longer button text
);

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // For email validation
  bool _isLoading = false; // To show a loading indicator on the button

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetLink() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      // Form is invalid, validator will show the error.
      // Optionally, show a generic SnackBar if needed, but usually not necessary
      // if autovalidateMode is onUserInteraction.
      return;
    }

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      if (mounted) { // Check if the widget is still in the tree
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Password reset link successfully sent to ${_emailController.text.trim()}",
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green, // Green background for success
          ),
        );
        // Optionally, navigate after a short delay or let user navigate manually
        // Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        String errorMessage = "Failed to send reset link. Please try again.";
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'The email address is not valid.';
        }
        // You can add more specific Firebase error codes if needed
        print("Firebase Auth Error: ${e.code} - ${e.message}"); // Log for debugging

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) { // Catch any other generic errors
      if (mounted) {
        print("Send reset link error: $e"); // Log the error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "An unexpected error occurred. Please try again.",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Reset Password',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0033FF),
              Color(0xFF0600AB),
              Color(0xFF00003D),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Forgot Your Password?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Enter your email address below and we\'ll send you a link to reset your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text('Email Address', textAlign: TextAlign.left, style: _kLabelTextStyle),
                  const SizedBox(height: 10),
                  _buildEmailField(),
                  const SizedBox(height: 40),
                  _buildSubmitButton(),
                  const Spacer(), // Pushes the bottom content down
                  Center(
                    child: Container(
                      width: 120,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Colors.black87), // Text color inside the field
      decoration: InputDecoration(
        hintText: 'Enter your email address',
        hintStyle: _kInputHintTextStyle,
        filled: true,
        fillColor: Colors.white.withOpacity(0.9), // Slightly transparent white
        prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF0600AB)), // Icon color matching theme
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none, // No border when not focused
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3), width: 1), // Subtle border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFADD8E6), width: 2), // Lighter blue for focus
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email address.';
        }
        // More robust email validation regex
        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(value)) {
          return 'Please enter a valid email address.';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction, // Validate as user types
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _sendResetLink, // Disable button when loading
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Light button background
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14), // Consistent border radius
        ),
        minimumSize: const Size(double.infinity, 54), // Ensure button has good height
        elevation: 6, // Add some shadow for depth
      ),
      child: _isLoading
          ? const SizedBox( // Show loading indicator
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          color: Color(0xFF00003D), // Dark blue spinner
          strokeWidth: 3,
        ),
      )
          : const Text(
        'Send Password Reset Link',
        style: _kButtonTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}