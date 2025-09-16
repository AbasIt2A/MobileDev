import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;
  bool _agreeToTerms = false;

  bool _hasEightChars = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;

  void _validatePassword(String password) {
    setState(() {
      _hasEightChars = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildIcon(), // This is where the logo is
              const SizedBox(height: 16),
              const Text(
                'Create Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Join thousands of users and start your journey today',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              _buildLabeledTextField(
                label: 'Full Name',
                hint: 'Enter your full name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 24),
              _buildLabeledTextField(
                label: 'Email Address',
                hint: 'Enter your email',
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 24),
              _buildPasswordField(),
              const SizedBox(height: 8),
              _buildPasswordCriteria('At least 8 characters', _hasEightChars),
              _buildPasswordCriteria('One uppercase letter', _hasUppercase),
              _buildPasswordCriteria('One number', _hasNumber),
              const SizedBox(height: 24),
              _buildPhoneField(),
              const SizedBox(height: 24),
              _buildTermsCheckbox(),
              const SizedBox(height: 24),
              _buildCreateAccountButton(),
              const SizedBox(height: 24),
              _buildDivider(),
              const SizedBox(height: 24),
              _buildGoogleButton(),
              const SizedBox(height: 32),
              _buildSignInLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[100],
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        const Text(
          'Step 1 of 2',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  // Modified to use Image.asset for the logo
  Widget _buildIcon() {
    return Center(
      child: Image.asset(
        'assets/images/logo.png', // Your new logo
        height: 80, // Adjust size as needed
      ),
    );
  }

  Widget _buildLabeledTextField({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            suffixIcon: Icon(icon, color: Colors.grey[500]),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: _obscurePassword,
          onChanged: _validatePassword,
          decoration: InputDecoration(
            hintText: 'Create a password',
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: Colors.grey[500],
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordCriteria(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isMet ? Colors.green : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: isMet ? Colors.green : Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Phone Number',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                value: '+1',
                underline: const SizedBox(),
                items: <String>['+1', '+63', '+44', '+91'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter phone number',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _agreeToTerms,
          onChanged: (bool? value) {
            setState(() {
              _agreeToTerms = value ?? false;
            });
          },
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Inter'),
              children: <TextSpan>[
                const TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'Terms of Service',
                  style: const TextStyle(color: Color(0xFF6D5FFD), fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(color: Color(0xFF6D5FFD), fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateAccountButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6D5FFD),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text('Create Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[300])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'or continue with',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey[300])),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Image.asset('assets/images/google.png', height: 24.0),
      label: const Text('Continue with Google'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  Widget _buildSignInLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(color: Colors.grey[600], fontSize: 15),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop(); // Go back to the login screen
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: const Text(
              'Sign In',
              style: TextStyle(
                color: Color(0xFF6D5FFD),
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}