import 'package:flutter/material.dart';
import 'package:master_oro/screens/SplashScreen.dart';
import 'package:master_oro/screens/LoginScreen.dart';
import 'package:master_oro/screens/VendorDashboardScreen.dart';
import 'package:master_oro/screens/EnterSalesScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MISTER ORO',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/vendor-dashboard': (context) => const VendorDashboardScreen(),
        '/enter-sales': (context) => const EnterSalesScreen(),
      },
    );
  }
}
