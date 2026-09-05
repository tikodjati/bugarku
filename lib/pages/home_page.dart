import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/menu_card.dart';
import 'bmi_page.dart';
import 'calorie_page.dart';
import 'login_page.dart';
import 'workout_page.dart';
import 'group_page.dart';

class _HomeMenuItem {
  final IconData icon;
  final String label;
  final WidgetBuilder? pageBuilder;

  const _HomeMenuItem({
    required this.icon,
    required this.label,
    this.pageBuilder,
  });
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openPage(
    BuildContext context, {
    required String label,
    required WidgetBuilder? pageBuilder,
  }) {
    if (pageBuilder != null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: pageBuilder),
      );
      return;
    }

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
    final menuItems = <_HomeMenuItem>[
      _HomeMenuItem(
        icon: Icons.monitor_weight_outlined,
        label: 'BMI Calculator',
        pageBuilder: (_) => const BmiPage(),
      ),
      const _HomeMenuItem(
        icon: Icons.calculate_outlined,
        label: 'Kalkulator',
      ),
      _HomeMenuItem(
        icon: Icons.restaurant_outlined,
        label: 'Daily Calories',
        pageBuilder: (_) => const CaloriePage(),
      ),
      _HomeMenuItem(
        icon: Icons.fitness_center_outlined,
        label: 'Workout Schedule',
        pageBuilder: (_) => const WorkoutPage(),
      ),
      _HomeMenuItem(
        icon: Icons.groups_outlined,
        label: 'Data Kelompok',
        pageBuilder: (_) => const GroupDataPage(),
      ),
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
                      onTap: () => _openPage(
                        context,
                        label: item.label,
                        pageBuilder: item.pageBuilder,
                      ),
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