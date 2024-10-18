import 'package:flutter/material.dart';
import 'preferences_manager.dart'; 
import 'screens/onboarding_page.dart'; 
import 'screens/dashboard_screen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure initialization before running the app

  final seenOnboarding = await PreferencesManager.getHasSeenOnboarding();

  runApp(MyApp(seenOnboarding: seenOnboarding));
}

class MyApp extends StatelessWidget {
  final bool seenOnboarding;

  const MyApp({super.key, required this.seenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Onboarding',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: seenOnboarding ? DashboardScreen() : OnboardingPage(),
    );
  }
}
