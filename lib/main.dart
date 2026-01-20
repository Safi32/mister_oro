import 'package:flutter/material.dart';
import 'package:master_oro/screens/SplashScreen.dart';
import 'package:master_oro/screens/StakeholderSelectionScreen.dart';
import 'package:master_oro/screens/LoginScreen.dart';
import 'package:master_oro/screens/SignUpScreen.dart';
import 'package:master_oro/screens/VendorDashboardScreen.dart';
import 'package:master_oro/screens/EnterSalesScreen.dart';
import 'package:master_oro/screens/VerifierScreen.dart';
import 'package:master_oro/screens/AdminDashboardScreen.dart';

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
        '/stakeholder-selection': (context) =>
            const StakeholderSelectionScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/vendor-dashboard': (context) => const VendorDashboardScreen(),
        '/enter-sales': (context) => const EnterSalesScreen(),
        '/verifier': (context) => const VerifierScreen(),
        '/admin-dashboard': (context) => const AdminDashboardScreen(),
      },
    );
  }
}
