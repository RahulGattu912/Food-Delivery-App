import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  bool isVisible = true;
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final headlineMedium = Theme.of(context).textTheme.headlineMedium;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final titleMedium = Theme.of(context).textTheme.titleMedium;
    final labelSmall = Theme.of(context).textTheme.labelSmall;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

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
                  'Login',
                  style: headlineMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 10),
                child: Text(
                  'Welcome back to the app',
                  style: bodyLarge,
                ),
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
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Password',
                          style: titleMedium,
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Text(
                            'Forgot Password?',
                            style: labelSmall?.copyWith(color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 48,
                      width: 342,
                      child: TextField(
                        obscureText: isVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: Icon(
                              isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
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
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: isChecked
                                  ? primaryColor
                                  : const Color(0xFFD0D5DD),
                              border: Border.all(
                                color: isChecked
                                    ? primaryColor
                                    : const Color(0xFFD0D5DD),
                                width: 1.0,
                              ),
                            ),
                            child: isChecked
                                ? const Center(
                                    child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  ))
                                : null,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Keep me signed in',
                          style: bodyLarge?.copyWith(
                              color: const Color(0xFF333333)),
                        ),
                      ],
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PhoneLoginPage()),
                          );
                        },
                        child: Text(
                          'Login',
                          style: titleMedium?.copyWith(
                              color: const Color(0xFFFFFFFF)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Color(0xFFD0D5DD),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'or sign in with',
                            style: bodyMedium,
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Color(0xFFD0D5DD),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: 224,
                        height: 48,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 20),
                            SvgPicture.asset('assets/svg/facebook.svg'),
                            const SizedBox(width: 20),
                            SvgPicture.asset(
                              'assets/svg/google.svg',
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(width: 20),
                            SvgPicture.asset('assets/svg/apple.svg'),
                            const SizedBox(width: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Create an account',
                          style: titleMedium?.copyWith(color: primaryColor),
                        ),
                      ),
                    ),
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
