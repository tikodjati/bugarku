import 'package:flutter/material.dart';
import '../utils/constants.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    final int tanggal = today.day;

    final bool isGenap = tanggal % 2 == 0;

    final String jenisWorkout =
        isGenap ? 'STRENGTH' : 'CARDIO';

    final List<Map<String, String>> workouts = isGenap
        ? [
            {
              'nama': 'Squat',
              'detail': '3 set × 12 repetisi',
              'icon': 'fitness_center',
            },
            {
              'nama': 'Push Up',
              'detail': '3 set × 10 repetisi',
              'icon': 'accessibility_new',
            },
            {
              'nama': 'Lunges',
              'detail': '3 set × 10 repetisi',
              'icon': 'directions_run',
            },
            {
              'nama': 'Plank',
              'detail': '3 set × 30 detik',
              'icon': 'timer',
            },
          ]
        : [
            {
              'nama': 'Jogging',
              'detail': '20 menit',
              'icon': 'directions_run',
            },
            {
              'nama': 'Jumping Jack',
              'detail': '3 set × 20 repetisi',
              'icon': 'accessibility_run',
            },
            {
              'nama': 'High Knees',
              'detail': '3 set × 30 detik',
              'icon': 'directions_run',
            },
            {
              'nama': 'Mountain Climber',
              'detail': '3 set × 15 repetisi',
              'icon': 'fitness_center',
            },
          ];

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text(
          'Workout', 
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Workout Hari Ini',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              _formatTanggal(today),
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.fitness_center,
                    color: Colors.white,
                    size: 42,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Jadwal Olahraga',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    jenisWorkout,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Rekomendasi Latihan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            ...workouts.map(
              (workout) => _workoutCard(
                nama: workout['nama']!,
                detail: workout['detail']!,
                icon: _getIcon(workout['icon']!),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _workoutCard({
    required String nama,
    required String detail,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
        ), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6, 
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            child: Icon(
              icon, 
              color: AppColors.primary,
              size: 25,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  detail,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String icon) {
    switch (icon) {
      case 'fitness_center':
        return Icons.fitness_center;
      case 'accessibility_new':
        return Icons.accessibility_new;
      case 'directions_run':
        return Icons.directions_run;
      case 'timer':
        return Icons.timer;
      default:
        return Icons.fitness_center;
    }
  }

  String _formatTanggal(DateTime date) {
    const List<String> namaHari = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];

    const List<String> namaBulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${namaHari[date.weekday - 1]}, '
        '${date.day} ${namaBulan[date.month - 1]} ${date.year}';
  }
}