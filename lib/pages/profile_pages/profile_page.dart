import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/pages/login_pages/initial_page.dart';
// import 'package:food_delivery_app/pages/onboarding_page/onboarding.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:food_delivery_app/pages/navigation_page/navigation_page.dart';
import 'package:food_delivery_app/pages/profile_pages/communication_preferences.dart';
import 'package:food_delivery_app/pages/profile_pages/language.dart';
import 'package:food_delivery_app/pages/profile_pages/myaddresses.dart';
import 'package:food_delivery_app/pages/profile_pages/notifications.dart';
import 'package:food_delivery_app/pages/profile_pages/privacy_and_policies.dart';
import 'package:food_delivery_app/pages/profile_pages/terms_and_conditions.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;
  @override
  void initState() {
    _user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const InitialPage()),
          (Route<void> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    final ThemeData colorTheme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NavigationPage()));
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          )),
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _user?.displayName ?? 'User Name',
                  style: theme.headlineMedium?.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 20),
                Text(
                  '+91 0123456789',
                  style:
                      theme.bodyLarge?.copyWith(color: const Color(0xFF333333)),
                ),
                Text(
                  _user?.email ?? 'email@example.com',
                  style:
                      theme.bodyLarge?.copyWith(color: colorTheme.primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: colorTheme.indicatorColor,
                ),
                InkWell(
                  splashColor: colorTheme.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Myaddresses()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Text(
                          'My Addresses',
                          style: theme.titleMedium,
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Myaddresses()));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: colorTheme.indicatorColor,
                ),
                InkWell(
                  splashColor: colorTheme.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Notifications()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Text(
                          'Notifications',
                          style: theme.titleMedium,
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Notifications()));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: colorTheme.indicatorColor,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/svg/icons/settings.svg'),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Settings',
                      style: theme.titleMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 32,
                    ),
                    Text(
                      'Set according to your preferences',
                      style: theme.bodyMedium
                          ?.copyWith(color: const Color(0xFF333333)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  splashColor: colorTheme.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Languages()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 32,
                        ),
                        Text(
                          'Language',
                          style: theme.titleMedium
                              ?.copyWith(color: const Color(0xFF767676)),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Languages()));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Divider(
                        color: colorTheme.indicatorColor,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  splashColor: colorTheme.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CommunicationPreferences()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 32,
                        ),
                        Text(
                          'Communication Preferences',
                          style: theme.titleMedium
                              ?.copyWith(color: const Color(0xFF767676)),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CommunicationPreferences()));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: colorTheme.indicatorColor,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/svg/icons/safety.svg'),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Safety and Privacy',
                      style: theme.titleMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 32,
                    ),
                    Text(
                      'Check your orders and plan according to it.',
                      style: theme.bodyMedium
                          ?.copyWith(color: const Color(0xFF333333)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  splashColor: colorTheme.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrivacyAndPolicies()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 32,
                        ),
                        Text(
                          'Privacy & Policies',
                          style: theme.titleMedium
                              ?.copyWith(color: const Color(0xFF767676)),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PrivacyAndPolicies()));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Divider(
                        color: colorTheme.indicatorColor,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  splashColor: colorTheme.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TermsAndConditions()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 32,
                        ),
                        Text(
                          'Terms & Conditions',
                          style: theme.titleMedium
                              ?.copyWith(color: const Color(0xFF767676)),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TermsAndConditions()));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: colorTheme.indicatorColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: _signOut,
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/icons/log_out.svg'),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Log Out',
                        style: theme.titleMedium
                            ?.copyWith(color: colorTheme.primaryColor),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
              right: 20,
              child: SvgPicture.asset('assets/svg/profile/profile_image.svg'))
        ],
      )),
    );
  }
}
