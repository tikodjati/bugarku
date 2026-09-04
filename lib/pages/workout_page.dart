import 'package:flutter/material.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    final int tanggal = today.day;

    final bool isGenap = tanggal % 2 == 0;

    final String jenisWorkout =
        isGenap ? 'STRENGTH' : 'CARDIO';

    final String keterangan =
        isGenap ? 'Tanggal Genap' : 'Tanggal Ganjil';

    final List<Map<String, String>> workouts = isGenap
        ? [
            {
              'nama': 'Squat',
              'detail': '3 set × 12 repetisi',
              'icon': '🏋️',
            },
            {
              'nama': 'Push Up',
              'detail': '3 set × 10 repetisi',
              'icon': '💪',
            },
            {
              'nama': 'Lunges',
              'detail': '3 set × 10 repetisi',
              'icon': '🦵',
            },
            {
              'nama': 'Plank',
              'detail': '3 set × 30 detik',
              'icon': '🔥',
            },
          ]
        : [
            {
              'nama': 'Jogging',
              'detail': '20 menit',
              'icon': '🏃',
            },
            {
              'nama': 'Jumping Jack',
              'detail': '3 set × 20 repetisi',
              'icon': '🤸',
            },
            {
              'nama': 'High Knees',
              'detail': '3 set × 30 detik',
              'icon': '🏃',
            },
            {
              'nama': 'Mountain Climber',
              'detail': '3 set × 15 repetisi',
              'icon': '🔥',
            },
          ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Judul
            const Text(
              '🏋️ Workout Hari Ini',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              _formatTanggal(today),
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),

            const SizedBox(height: 25),

            // Card jenis workout
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue.shade50,
              ),
              child: Column(
                children: [

                  const Text(
                    'Jadwal Olahraga',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    jenisWorkout,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    keterangan,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Rekomendasi Latihan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // Daftar workout
            ...workouts.map(
              (workout) => _workoutCard(
                nama: workout['nama']!,
                detail: workout['detail']!,
                icon: workout['icon']!,
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
    required String icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [

          Text(
            icon,
            style: const TextStyle(
              fontSize: 30,
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
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  detail,
                  style: TextStyle(
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