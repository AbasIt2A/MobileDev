import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Make sure this is imported

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReTech',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Inter',
      ),
      home: const LoginScreen(), // This ensures LoginScreen is the first page
      debugShowCheckedModeBanner: false,
    );
  }
}