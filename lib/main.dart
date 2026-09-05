import 'package:flutter/material.dart';
import 'pages/workout_page.dart';
import 'pages/calorie_page.dart'; 
import 'pages/login_page.dart';
import 'utils/constants.dart';

void main() {
  runApp(const BugarKuApp());
}

class BugarKuApp extends StatelessWidget {
  const BugarKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BugarKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: AppColors.primary,
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}