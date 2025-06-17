import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth Import ADDED

// Text styles (kept as is from your original code)
const TextStyle kLabelTextStyle = TextStyle(
  color: Colors.white70,
  fontSize: 16,
  height: 1.5,
);

const TextStyle kInputHintTextStyle = TextStyle(
  color: Colors.blueGrey,
  fontSize: 16,
  height: 1.25,
);

const TextStyle kButtonTextStyle = TextStyle(
  color: Color(0xFF00003D),
  fontSize: 18,
  height: 1.375,
  fontWeight: FontWeight.bold,
);

const TextStyle kLinkTextStyle = TextStyle(
  color: Color(0xFFADD8E6),
  fontSize: 16,
  height: 1.5,
  fontWeight: FontWeight.bold,
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // For form validation
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      // If form is not valid, do nothing (errors will be shown by TextFormField validators)
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Sign in with Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // If login is successful, userCredential.user will not be null
      if (userCredential.user != null) {
        if (mounted) {
          // Navigate to DashboardScreen and replace the current route
          // So user cannot go back to login screen with back button
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
      }
      // No explicit 'else' needed here, as Firebase Auth will throw an exception on failure
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        String errorMessage = "Login failed. Please check your credentials.";
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'The email address is not valid.';
        } else if (e.code == 'user-disabled') {
          errorMessage = 'This user account has been disabled.';
        }
        // You can add more specific error codes if needed
        print("Firebase Auth Error: ${e.code} - ${e.message}"); // Log for debugging

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage, style: const TextStyle(color: Colors.white)),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) { // Catch any other generic errors
      if (mounted) {
        print("Login error: $e"); // Log the error for debugging
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("An unexpected error occurred. Please try again.", style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _navigateToSignUp() {
    Navigator.pushNamed(context, '/signup');
  }

  void _forgotPassword() {
    Navigator.pushNamed(context, '/resetpassword');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
              ),
              child: Form( // Wrap content in a Form widget
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 60),
                        _buildTitle(),
                        const SizedBox(height: 50),
                        _buildEmailField(),
                        const SizedBox(height: 28),
                        _buildPasswordField(),
                        const SizedBox(height: 20),
                        _buildForgotPassword(),
                        const SizedBox(height: 32),
                        _buildLoginButton(),
                        const SizedBox(height: 28),
                        _buildSignUpPrompt(),
                      ],
                    ),
                    const SizedBox(height: 40),
                    _buildBottomIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Welcome Back!',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 34,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Email', style: kLabelTextStyle),
        const SizedBox(height: 10),
        TextFormField( // Changed to TextFormField for validation
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.black87), // Text color inside the field
          decoration: InputDecoration(
            hintText: 'Enter your email',
            hintStyle: kInputHintTextStyle,
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
              return 'Please enter your email.';
            }
            // More robust email validation regex
            if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(value)) {
              return 'Please enter a valid email address.';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction, // Validate as user types
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Password', style: kLabelTextStyle),
        const SizedBox(height: 10),
        TextFormField( // Changed to TextFormField for validation
          controller: _passwordController,
          obscureText: _obscurePassword,
          style: const TextStyle(color: Colors.black87), // Text color inside the field
          decoration: InputDecoration(
            hintText: 'Enter password',
            hintStyle: kInputHintTextStyle,
            filled: true,
            fillColor: Colors.white.withOpacity(0.9), // Slightly transparent white
            prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF0600AB)), // Icon color matching theme
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
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: const Color(0xFF0600AB), // Icon color matching theme
              ),
              onPressed: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password.';
            }
            // You might want to remove the min length check here for login,
            // or keep it if your backend enforces it strictly and you want immediate feedback.
            // For now, I'll keep it as it was in your original code.
            if (value.length < 6) {
              return 'Password must be at least 6 characters.';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction, // Validate as user types
        ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: _isLoading ? null : _forgotPassword, // Disable if loading
        child: const Text('Forgot Password?', style: kLinkTextStyle),
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _login,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Light button background
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14), // Consistent border radius
        ),
        minimumSize: const Size(double.infinity, 54), // Ensure button has good height
        elevation: 6, // Add some shadow for depth
      ),
      child: _isLoading
          ? const SizedBox(
        width: 28, // Increased size for better visibility
        height: 28,
        child: CircularProgressIndicator(
          color: Color(0xFF0600AB), // Spinner color matching theme
          strokeWidth: 3,
        ),
      )
          : const Text('Login', style: kButtonTextStyle),
    );
  }

  Widget _buildSignUpPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ", style: kLabelTextStyle),
        TextButton(
          onPressed: _isLoading ? null : _navigateToSignUp, // Disable if loading
          child: const Text('Sign Up', style: kLinkTextStyle),
        ),
      ],
    );
  }

  Widget _buildBottomIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Center(
        child: Container(
          width: 120,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}