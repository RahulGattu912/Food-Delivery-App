import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/pages/authentication/phone_signin.dart';
import 'package:food_delivery_app/pages/reset_password/forgot_password.dart';
import 'package:food_delivery_app/pages/homepage/home_page.dart';
import 'package:food_delivery_app/pages/sign_up/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isVisible = true;
  bool isChecked = true;
  bool isEmailSelected = true;
  bool isPhoneSelected = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } catch (e) {
        setState(() {
          _errorMessage = 'Invalid email or password.';
        });
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User canceled the sign-in

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Error signing in with Google: $e';
      });
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.tokenString);

        await FirebaseAuth.instance.signInWithCredential(credential);

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        setState(() {
          _errorMessage = 'Facebook login failed: ${result.status}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error during Facebook login: $e';
      });
    }
  }

  void _navigateToOtpScreen() {
    if (_formKey.currentState!.validate()) {
      try {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhoneSignIn(
              phoneNumber: _phoneController.text,
            ),
          ),
        );
      } catch (e) {
        setState(() {
          _errorMessage = 'Invalid Phone Number';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final indicatorColor = Theme.of(context).indicatorColor;
    final headlineMedium = Theme.of(context).textTheme.headlineMedium;
    final headlineMSmall = Theme.of(context).textTheme.headlineSmall;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final titleMedium = Theme.of(context).textTheme.titleMedium;
    final labelSmall = Theme.of(context).textTheme.labelSmall;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                      SizedBox(
                        height: 36,
                        width: 220,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEmailSelected = true;
                                  isPhoneSelected = false;
                                  _errorMessage = null;
                                });
                              },
                              child: Text(
                                'Email',
                                style: headlineMSmall?.copyWith(
                                    color: isEmailSelected
                                        ? primaryColor
                                        : Colors.black),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPhoneSelected = true;
                                  isEmailSelected = false;
                                  _errorMessage = null;
                                });
                              },
                              child: Text(
                                'Phone Number',
                                style: headlineMSmall?.copyWith(
                                    color: isPhoneSelected
                                        ? primaryColor
                                        : Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 36,
                        width: 220,
                        child: Row(
                          children: [
                            const SizedBox(
                              height: 1,
                              width: 20,
                            ),
                            Container(
                              height: 2,
                              width: 24,
                              decoration: BoxDecoration(
                                  color: isEmailSelected
                                      ? primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            const SizedBox(
                              width: 70,
                            ),
                            Container(
                              height: 2,
                              width: 64,
                              decoration: BoxDecoration(
                                  color: isPhoneSelected
                                      ? primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                            )
                          ],
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //password
                            if (isEmailSelected) ...[
                              Text(
                                'Email Address',
                                style: titleMedium,
                              ),

                              const SizedBox(height: 10),

                              //input form field
                              SizedBox(
                                height: 48,
                                width: 342,
                                child: TextFormField(
                                  cursorColor: primaryColor,
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    hintText: 'hello@example.com',
                                    hintStyle: bodyLarge,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: primaryColor),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: indicatorColor),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  style: bodyLarge?.copyWith(
                                      color: const Color(0xFF000000)),
                                  validator: (value) {
                                    if (isEmailSelected) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      // Email regex pattern
                                      String pattern =
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                                      if (!RegExp(pattern).hasMatch(value)) {
                                        return 'Please enter a valid email';
                                      }
                                    }
                                    return null;
                                  },
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
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ForgotPassword()));
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: labelSmall?.copyWith(
                                          color: primaryColor),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              //password input
                              SizedBox(
                                height: 48,
                                width: 342,
                                child: TextFormField(
                                  cursorColor: primaryColor,
                                  controller: _passwordController,
                                  obscureText: isVisible,
                                  decoration: InputDecoration(
                                    hintText: '.........',
                                    hintStyle: const TextStyle(
                                        color: Color(0xFF999999), fontSize: 36),
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
                                        color: const Color(0xFF999999),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: primaryColor),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: indicatorColor),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  style: bodyLarge?.copyWith(
                                      color: const Color(0xFF000000)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters long';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                            if (isPhoneSelected) ...[
                              Text(
                                'Phone Number',
                                style: titleMedium,
                              ),

                              const SizedBox(height: 10),

                              //input form field
                              SizedBox(
                                height: 48,
                                width: 342,
                                child: TextFormField(
                                  cursorColor: primaryColor,
                                  controller: _phoneController,
                                  decoration: InputDecoration(
                                    hintText: 'Phone Number',
                                    hintStyle: bodyLarge,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: primaryColor),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: indicatorColor),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  style: bodyLarge?.copyWith(
                                      color: const Color(0xFF000000)),
                                  validator: (value1) {
                                    if (value1 == null || value1.isEmpty) {
                                      return 'Please enter your Number';
                                    }
                                    // Email regex pattern

                                    if (value1.length < 10) {
                                      return 'Please enter a valid Phone number';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              const SizedBox(height: 20),

                              //password input
                            ],
                            //keep me signed in
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
                                          : indicatorColor,
                                      border: Border.all(
                                        color: isChecked
                                            ? primaryColor
                                            : indicatorColor,
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

                            const SizedBox(height: 20),
                            if (_errorMessage != null) ...[
                              Text(
                                _errorMessage!,
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(height: 20),
                            ],

                            const SizedBox(height: 10),

                            //login button
                            SizedBox(
                              height: 48,
                              width: 342,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(primaryColor),
                                  foregroundColor: WidgetStateProperty.all(
                                      const Color(0xFFFFFFFF)),
                                ),
                                onPressed: isPhoneSelected
                                    ? _navigateToOtpScreen
                                    : _login,
                                child: Text(
                                  isPhoneSelected ? 'Get OTP' : 'Login',
                                  style: titleMedium?.copyWith(
                                      color: const Color(0xFFFFFFFF)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Email login

                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: indicatorColor,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'or sign in with',
                              style: bodyMedium,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: indicatorColor,
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
                              GestureDetector(
                                  onTap: _signInWithFacebook,
                                  child: SvgPicture.asset(
                                      'assets/svg/facebook.svg')),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () => _signInWithGoogle(),
                                child: SvgPicture.asset(
                                  'assets/svg/google.svg',
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              const SizedBox(width: 20),
                              SvgPicture.asset('assets/svg/apple.svg'),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()));
                          },
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
      ),
    );
  }
}
