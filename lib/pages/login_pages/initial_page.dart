import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/pages/navigation_page/navigation_page.dart';
import 'dart:async';
import 'package:food_delivery_app/pages/onboarding_page/onboarding.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  Future<void> _signInWithGoogle() async {
    try {
      // Trigger Google Sign-In process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return;
      }

      // Obtain authentication details from Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a credential for Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // print(credential);
      // Sign in to Firebase using the Google credential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      //print(userCredential);

      // Ensure the user has signed in successfully
      if (userCredential.user != null) {
        debugPrint("Google sign-in successful!");

        await _sendUserDataToServer(googleAuth.idToken!, userCredential);
      }

      // Only proceed if the widget is still in the tree
      if (!mounted) return;

      // Navigate to your main application page (or wherever you want)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const NavigationPage(
                  initialIndex: 0,
                )),
      );
    } catch (e) {
      // Display or log the error if something went wrong during sign-in
      // setState(() {
      //   _errorMessage = 'Error signing in with Google: $e';
      // });
      debugPrint("Google sign-in error: $e");
    }
  }

  Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwtToken', token);
    debugPrint('JWT Token ${prefs.getString('jwtToken')}');
  }

  Future<void> _sendUserDataToServer(
      String idToken, UserCredential userCredential) async {
    final url = Uri.parse('http://192.168.50.131:8000/users/save');

    // Prepare the data to send to the server
    Map<String, dynamic> userData = {
      // 'idToken': idToken,
      // 'uid': userCredential.user?.uid,
      'displayName': userCredential.user?.displayName,
      'email': userCredential.user?.email,
    };
    // print(userData['email']);
    try {
      // Make the POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Specify that we're sending JSON
        },
        body: json.encode(userData), // Convert the data to JSON
      );

      // Check for a successful response
      if (response.statusCode == 201 || response.statusCode == 409) {
        final token = jsonDecode(response.body)['jwtToken'];
        // print('Response body');
        // print(jsonDecode(response.body)['jwtToken']);
        // print(token);
        await storeToken(token); // Store the token in SharedPreferences
        debugPrint('User data sent successfully: ${response.body}');
      } else {
        debugPrint(
            'Failed to send user data: ${response.statusCode} - ${response.body}');
      }
    } catch (error) {
      debugPrint('Error occurred while sending user data: $error');
    }
    return;
  }

  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 1.5);
  Timer? _timer;
  final List<String> _textTitles = [
    'We\'re excited to help you book and manage\n your service appointments with ease.',
    'We\'re excited to help you book and manage\n your service appointments with ease.',
    'We\'re excited to help you book and manage\n your service appointments with ease.',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < _textTitles.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget textTile({required String text}) {
    return Text(text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontFamily: 'DMSans',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF999999)));
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final shadowColor = Theme.of(context).shadowColor;
    final headlineMedium = Theme.of(context).textTheme.headlineMedium;
    final titleMedium = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            SvgPicture.asset('assets/svg/welcome_rafiki.svg'),
            const SizedBox(
              height: 50,
            ),
            Text('Welcome to the app', style: headlineMedium),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 48,
              width: double.maxFinite,
              child: PageView.builder(
                  itemCount: _textTitles.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return textTile(text: _textTitles[index]);
                  }),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_textTitles.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 8 : 7,
                  height: _currentIndex == index ? 8 : 7,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? primaryColor : shadowColor,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 56,
              width: 342,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(primaryColor),
                    foregroundColor:
                        const WidgetStatePropertyAll(Color(0xFFFFFFFF)),
                  ),
                  onPressed: () {
                    _signInWithGoogle();
                  },
                  child: Text(
                    'Continue with Google',
                    style: titleMedium?.copyWith(
                        //override properties
                        color: const Color(0xFFFFFFFF)),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OnBoardingPage()));
                },
                child: Text(
                  'Skip',
                  style: titleMedium?.copyWith(
                    //override color
                    color: Theme.of(context).primaryColor,
                  ),
                )),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
