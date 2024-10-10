import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:food_delivery_app/insert_items_page.dart';
import 'package:food_delivery_app/pages/cart_pages/cart_provider.dart';
import 'package:food_delivery_app/pages/navigation_page/navigation_page.dart';
import 'package:food_delivery_app/pages/onboarding_page/onboarding.dart';
import 'package:food_delivery_app/pages/order_pages/order_history/order_provider.dart';
import 'package:food_delivery_app/pages/themes/themes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CartProvider()),
    ChangeNotifierProvider(create: (context) => OrderProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          indicatorColor: const Color(0xFFD0D5DD),
          primaryColor: const Color(0xFFFE724C),
          disabledColor: const Color(0xFF999999),
          shadowColor: const Color(0xFFC0C0C0),
          textTheme: mainTheme),
      //home: const InsertItemsPage(),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.data != null) {
              return const Scaffold(
                  backgroundColor: Colors.white, body: NavigationPage());
            } else {
              return const OnBoardingPage();
            }
          }),
    );
  }
}
