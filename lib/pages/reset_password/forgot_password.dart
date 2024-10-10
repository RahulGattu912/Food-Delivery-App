import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/pages/login_pages/login_page.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _sendPasswordResetEmail() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Password reset link sent! Check your email.')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final headlineMedium = Theme.of(context).textTheme.headlineMedium;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final titleMedium = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Forgot Password?',
                  style: headlineMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 10),
                child: Text(
                  'Enter your email address to get the password reset link',
                  style: bodyLarge,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Address',
                      style: titleMedium,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 48,
                      width: 342,
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'hello@example.com',
                          hintStyle: bodyLarge,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFD0D5DD)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 48,
                      width: 342,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(primaryColor),
                          foregroundColor:
                              WidgetStateProperty.all(const Color(0xFFFFFFFF)),
                        ),
                        onPressed: _sendPasswordResetEmail,
                        child: Text(
                          'Password Reset',
                          style: titleMedium?.copyWith(
                              color: const Color(0xFFFFFFFF)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 3,
              )
            ],
          ),
        ),
      ),
    );
  }
}
