import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/menu_card.dart';
import 'bmi_page.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openPage(BuildContext context, String label) {
    // TODO: ganti dengan Navigator.push ke halaman asli setiap fitur
    // sudah dibuat (calculator_page.dart, calorie_page.dart, dst).
    if (label == 'BMI Calculator') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const BmiPage()),
      );
      return;
    }
    // sudah dibuat (bmi_page.dart, calculator_page.dart, dst).
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label belum tersedia.')),
    );
  }

  void _logout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      (icon: Icons.monitor_weight_outlined, label: 'BMI Calculator'),
      (icon: Icons.calculate_outlined, label: 'Kalkulator'),
      (icon: Icons.restaurant_outlined, label: 'Daily Calories'),
      (icon: Icons.fitness_center_outlined, label: 'Workout Schedule'),
      (icon: Icons.groups_outlined, label: 'Data Kelompok'),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('BugarKu'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selamat datang! 👋',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Pilih menu di bawah untuk mulai.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  itemCount: menuItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    return MenuCard(
                      icon: item.icon,
                      label: item.label,
                      onTap: () => _openPage(context, item.label),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}