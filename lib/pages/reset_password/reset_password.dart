import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/login_pages/login_page.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isVisible_1 = true;
  bool isVisible_2 = true;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final disabledColor = Theme.of(context).disabledColor;
    final headlineMedium = Theme.of(context).textTheme.headlineMedium;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final titleMedium = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Reset Password',
                  style: headlineMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
                child: Text(
                  'Enter your new password twice below to reset a new password ',
                  style: bodyLarge,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Enter new password',
                      style: titleMedium,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 48,
                      width: 342,
                      child: TextField(
                        obscureText: isVisible_1,
                        decoration: InputDecoration(
                          hintText: '152@@##PAss',
                          hintStyle: bodyLarge?.copyWith(color: disabledColor),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible_1 = !isVisible_1;
                              });
                            },
                            icon: Icon(
                              isVisible_1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xFF999999),
                            ),
                          ),
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
                    const SizedBox(height: 20),
                    Text(
                      'Re-enter new password',
                      style: titleMedium,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 48,
                      width: 342,
                      child: TextField(
                        obscureText: isVisible_2,
                        decoration: InputDecoration(
                          hintText: '**********',
                          hintStyle: bodyLarge?.copyWith(color: disabledColor),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible_2 = !isVisible_2;
                              });
                            },
                            icon: Icon(
                              isVisible_2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xFF999999),
                            ),
                          ),
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
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            //removes the previous routes
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (route) => false,
                          );
                        },
                        child: Text(
                          'Password Reset',
                          style: titleMedium?.copyWith(
                              color: const Color(0xFFFFFFFF)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40)
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
