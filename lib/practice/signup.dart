import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// --- Text Styles ---
const TextStyle _kStatusBarTextStyle = TextStyle(
  color: Colors.white, // Changed to white for better visibility on dark background
  fontFamily: 'Roboto',
  fontSize: 14,
  fontWeight: FontWeight.normal,
);

const TextStyle _kTitleTextStyle = TextStyle(
  color: Colors.white, // Changed to white
  fontFamily: 'Inter',
  fontSize: 32,
  fontWeight: FontWeight.bold,
  height: 1,
);

const TextStyle _kLabelTextStyle = TextStyle(
  color: Colors.white, // Changed to white
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.5,
);

const TextStyle _kHintTextStyle = TextStyle(
  color: Colors.white70, // Changed to white with opacity
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.25,
);

const TextStyle _kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Inter',
  fontSize: 16,
  letterSpacing: 0.5,
  fontWeight: FontWeight.w500,
  height: 1.375,
);

const TextStyle _kTermsTextStyle = TextStyle(
  color: Colors.white, // Changed to white
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.5,
);

// --- Colors ---
const Color _kTextFieldColor = Color(0x1AFFFFFF); // White with 10% opacity
const Color _kButtonColor = Colors.white;
const Color _kDisabledButtonColor = Colors.grey;
const Color _kBorderColor = Colors.white; // Changed to white

// Gradient colors
const Color _kTopGradientColor = Color(0xFF0033FF);
const Color _kMiddleGradientColor = Color(0xFF0600AB);
const Color _kBottomGradientColor = Color(0xFF00003D);

class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  bool _agreeToTerms = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _verificationEmailSent = false;

  @override
  void initState() {
    super.initState();
    _resetState();
    _auth.signOut();
  }

  void _resetState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _agreeToTerms = false;
    _isPasswordVisible = false;
    _isConfirmPasswordVisible = false;
    _isLoading = false;
    _verificationEmailSent = false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showInfoSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.grey[800],
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  Future<void> _createAccount() async {
    if (!_formKey.currentState!.validate()) {
      _showErrorSnackBar('Please fill all required fields correctly.');
      return;
    }
    if (!_agreeToTerms) {
      _showErrorSnackBar('Please agree to the Terms & Conditions.');
      return;
    }

    setState(() {
      _isLoading = true;
      _verificationEmailSent = false;
    });

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await userCredential.user?.sendEmailVerification();

      if (mounted) {
        setState(() {
          _verificationEmailSent = true;
        });
        _showInfoSnackBar('Account created. Please check your email for verification!');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred. Please try again.";
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'An account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      }
      _showErrorSnackBar(errorMessage);
    } catch (e) {
      _showErrorSnackBar('An unexpected error occurred: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _checkEmailVerificationAndNavigate() async {
    if (!_verificationEmailSent) {
      _showInfoSnackBar('Please create an account first to receive a verification email.');
      return;
    }

    setState(() { _isLoading = true; });
    try {
      await _auth.currentUser?.reload();
      final currentUser = _auth.currentUser;

      if (currentUser != null && currentUser.emailVerified) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
      } else {
        _showInfoSnackBar('Email not yet verified. Please check your inbox or resend the email.');
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Error checking verification: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() { _isLoading = false; });
      }
    }
  }

  Future<void> _resendVerificationEmail() async {
    if (!_verificationEmailSent) {
      _showInfoSnackBar('Please create an account first to resend verification.');
      return;
    }

    setState(() { _isLoading = true; });
    try {
      await _auth.currentUser?.sendEmailVerification();
      _showInfoSnackBar('Verification email re-sent. Please check your inbox.');
    } on FirebaseAuthException catch (e) {
      _showErrorSnackBar('Failed to resend email: ${e.message}');
    } catch (e) {
      _showErrorSnackBar('An unexpected error occurred: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() { _isLoading = false; });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final String currentTime =
        '${now.hour % 12 == 0 ? 12 : now.hour % 12}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}';

    final bool canCreateAccount = !_isLoading;
    final bool canInteractWithVerificationButtons = !_isLoading && _verificationEmailSent;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                _kTopGradientColor,
                _kMiddleGradientColor,
                _kBottomGradientColor,
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildStatusBar(currentTime),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Create Your Account',
                  textAlign: TextAlign.center,
                  style: _kTitleTextStyle,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Email Address', style: _kLabelTextStyle),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _emailController,
                          hintText: 'Enter your email address',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        const Text('Password', style: _kLabelTextStyle),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _passwordController,
                          hintText: 'Enter password',
                          isObscured: !_isPasswordVisible,
                          suffixIcon: _isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          onSuffixIconPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        const Text('Confirm Password', style: _kLabelTextStyle),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _confirmPasswordController,
                          hintText: 'Confirm your password',
                          isObscured: !_isConfirmPasswordVisible,
                          suffixIcon: _isConfirmPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          onSuffixIconPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        _buildTermsAndConditionsCheckbox(),
                        const SizedBox(height: 32),
                        Center(
                          child: ElevatedButton(
                            onPressed: canCreateAccount ? _createAccount : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _kButtonColor.withOpacity(0.9),
                              disabledBackgroundColor: _kDisabledButtonColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: _isLoading && !canInteractWithVerificationButtons
                                ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.black, // Changed to black for visibility on white button
                                strokeWidth: 3,
                              ),
                            )
                                : Text(
                              'Create Account',
                              style: _kButtonTextStyle.copyWith(color: Colors.black), // Changed to black
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        if (_verificationEmailSent) ...[
                          Center(
                            child: Text(
                              "A verification email has been sent. Please check your inbox.",
                              style: _kLabelTextStyle.copyWith(color: Colors.white70),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: TextButton(
                              onPressed: canInteractWithVerificationButtons
                                  ? _checkEmailVerificationAndNavigate : null,
                              child: Text(
                                'I have verified, proceed to Dashboard',
                                style: TextStyle(
                                  color: canInteractWithVerificationButtons
                                      ? Colors.white : Colors.white54,
                                  decoration: canInteractWithVerificationButtons
                                      ? TextDecoration.underline
                                      : null,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: TextButton(
                              onPressed: canInteractWithVerificationButtons
                                  ? _resendVerificationEmail : null,
                              child: Text(
                                'Resend Verification Email',
                                style: TextStyle(
                                  color: canInteractWithVerificationButtons
                                      ? Colors.white : Colors.white54,
                                  decoration: canInteractWithVerificationButtons
                                      ? TextDecoration.underline
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
              _buildBottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool isObscured = false,
    IconData? suffixIcon,
    VoidCallback? onSuffixIconPressed,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: _kTextFieldColor,
        border: Border.all(color: _kBorderColor, width: 1),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isObscured,
        style: const TextStyle(
          color: Colors.white, // Changed to white
          fontFamily: 'Inter',
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: _kHintTextStyle,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          border: InputBorder.none,
          suffixIcon: suffixIcon != null
              ? IconButton(
            icon: Icon(suffixIcon, color: Colors.white70), // Changed to white with opacity
            onPressed: onSuffixIconPressed,
          )
              : null,
        ),
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Widget _buildTermsAndConditionsCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: _agreeToTerms,
            onChanged: (bool? newValue) {
              setState(() {
                _agreeToTerms = newValue ?? false;
              });
            },
            activeColor: Colors.white, // Changed to white
            checkColor: Colors.black, // Changed to black for contrast
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: const BorderSide(color: Colors.white, width: 1.5), // Changed to white
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'I agree to the Terms & Conditions and Privacy Policy',
            style: _kTermsTextStyle,
            softWrap: true,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBar(String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            time,
            textAlign: TextAlign.left,
            style: _kStatusBarTextStyle,
          ),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.wifi, color: Colors.white, size: 16.0), // Changed to white
              SizedBox(width: 2),
              Icon(Icons.signal_cellular_alt, color: Colors.white, size: 16.0), // Changed to white
              SizedBox(width: 2),
              Icon(Icons.battery_full, color: Colors.white, size: 16.0), // Changed to white
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0, top: 10.0),
        width: 108,
        height: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white, // Changed to white
        ),
      ),
    );
  }
}