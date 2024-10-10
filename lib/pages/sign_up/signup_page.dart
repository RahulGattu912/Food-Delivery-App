import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/pages/homepage/home_page.dart';
import 'package:food_delivery_app/pages/login_pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isVisible = true;
  bool isChecked = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _errorMessage;

  bool _isEmailValid(String email) {
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegExp.hasMatch(email);
  }

  Future<void> _signup() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (!_isEmailValid(email)) {
      _showErrorDialog('Invalid email address!');
      return;
    }

    if (password.length < 8) {
      _showErrorDialog('Password must be at least 8 characters long!');
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _successSignupDialog('Sign Up Successful');
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _successSignupDialog(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Success'),
            content: Text(message),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).primaryColor),
                      foregroundColor:
                          const WidgetStatePropertyAll(Color(0xFFFFFFFF))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Theme.of(context).primaryColor),
                  foregroundColor:
                      const WidgetStatePropertyAll(Color(0xFFFFFFFF))),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
      }
      // else {
      //   setState(() {
      //     _errorMessage = 'Facebook login failed: ${result.status}';
      //   });
      // }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error during Facebook login: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final headlineMedium = Theme.of(context).textTheme.headlineMedium;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final titleMedium = Theme.of(context).textTheme.titleMedium;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Create an Account',
                  style: headlineMedium,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: titleMedium,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: TextFormField(
                              cursorColor: primaryColor,
                              style: bodyLarge?.copyWith(
                                  color: const Color(0xFF000000)),
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: 'hello',
                                hintStyle: bodyLarge,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFFD0D5DD)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Email Address',
                            style: titleMedium,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: TextFormField(
                              cursorColor: primaryColor,
                              style: bodyLarge?.copyWith(
                                  color: const Color(0xFF000000)),
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'hello@example.com',
                                hintStyle: bodyLarge,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFFD0D5DD)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Password',
                            style: titleMedium,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: TextFormField(
                              cursorColor: primaryColor,
                              style: bodyLarge?.copyWith(
                                  color: const Color(0xFF000000)),
                              obscureText: isVisible,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                hintText: '*********',
                                hintStyle: const TextStyle(
                                  color: Color(0xFF999999),
                                ),
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
                                  borderSide: BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFFD0D5DD)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'By continuing, you agree to our',
                                style: TextStyle(fontSize: 12),
                              ),
                              Flexible(
                                child: GestureDetector(
                                  child: Text(
                                    ' Terms and Conditions',
                                    style: bodyMedium?.copyWith(
                                        color: primaryColor, fontSize: 12),
                                    overflow: TextOverflow
                                        .ellipsis, // Handle overflow
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (_errorMessage != null) ...[
                            Text(
                              _errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),
                            const SizedBox(height: 20),
                          ],
                          const SizedBox(height: 30),
                          SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(primaryColor),
                                foregroundColor: WidgetStateProperty.all(
                                    const Color(0xFFFFFFFF)),
                              ),
                              onPressed: _signup,
                              child: Text(
                                'Sign Up',
                                style: titleMedium?.copyWith(
                                    color: const Color(0xFFFFFFFF)),
                              ),
                            ),
                          ),
                        ],
                      )),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
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
                              GestureDetector(
                                  onTap: () => _signInWithFacebook(),
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
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: titleMedium,
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false,
                                );
                              },
                              child: Text(
                                'Sign in',
                                style: titleMedium?.copyWith(
                                    color: primaryColor, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
