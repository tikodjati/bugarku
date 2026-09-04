import 'package:flutter/material.dart';
import 'pages/workout_page.dart';

void main() {
  runApp(const BugarKuApp());
}

class BugarKuApp extends StatelessWidget {
  const BugarKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BugarKu',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const WorkoutPage(),
    );
  }
}