import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/pages/login_pages/login_page.dart';
import 'package:food_delivery_app/pages/sign_up/signup_page.dart';
import 'dart:async';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: Text(
                    'Login',
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
                          builder: (context) => const SignupPage()));
                },
                child: Text(
                  'Create an account',
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
