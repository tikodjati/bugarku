import 'package:flutter/material.dart';

import '../utils/constants.dart';

/// Model sederhana untuk satu entri makanan.
class FoodItem {
  final String name;
  final int calories;

  FoodItem({required this.name, required this.calories});
}

/// Status hasil perbandingan kalori masuk terhadap target harian.
enum CalorieStatus { deficit, surplus, onTarget }

class CaloriePage extends StatefulWidget {
  const CaloriePage({super.key});

  @override
  State<CaloriePage> createState() => _CaloriePageState();
}

class _CaloriePageState extends State<CaloriePage> {
  final List<FoodItem> _foodItems = [];

  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _foodCalorieController = TextEditingController();
  final TextEditingController _targetController = TextEditingController(
    text: '2000',
  );

  final _formKey = GlobalKey<FormState>();

  int get _totalCalories =>
      _foodItems.fold(0, (sum, item) => sum + item.calories);

  int get _targetCalories => int.tryParse(_targetController.text) ?? 0;

  /// Menghitung status berdasarkan logika:
  /// - kalori_masuk < target => Defisit
  /// - kalori_masuk > target => Surplus
  /// - kalori_masuk == target => Sesuai target
  CalorieStatus get _status {
    if (_totalCalories < _targetCalories) return CalorieStatus.deficit;
    if (_totalCalories > _targetCalories) return CalorieStatus.surplus;
    return CalorieStatus.onTarget;
  }

  int get _difference => (_totalCalories - _targetCalories).abs();

  void _addFood() {
    if (!_formKey.currentState!.validate()) return;

    final name = _foodNameController.text.trim();
    final calories = int.parse(_foodCalorieController.text.trim());

    setState(() {
      _foodItems.add(FoodItem(name: name, calories: calories));
      _foodNameController.clear();
      _foodCalorieController.clear();
    });

    FocusScope.of(context).unfocus();
  }

  void _removeFood(int index) {
    setState(() {
      _foodItems.removeAt(index);
    });
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _foodCalorieController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Daily Calories'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildTargetCard(),
                  const SizedBox(height: 16),
                  _buildAddFoodCard(),
                  const SizedBox(height: 16),
                  _buildFoodListCard(),
                  const SizedBox(height: 16),
                  _buildSummaryCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Target kalori harian ----------
  Widget _buildTargetCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.flag, color: AppColors.primary),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Target Kalori Harian',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              width: 100,
              child: TextField(
                controller: _targetController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  suffixText: 'kcal',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Form tambah makanan ----------
  Widget _buildAddFoodCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tambah Makanan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _foodNameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Makanan',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Wajib diisi';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _foodCalorieController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Kalori',
                        suffixText: 'kcal',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Wajib diisi';
                        }
                        final parsed = int.tryParse(value.trim());
                        if (parsed == null || parsed <= 0) {
                          return 'Tidak valid';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _addFood,
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Daftar makanan yang sudah ditambahkan ----------
  Widget _buildFoodListCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                'Daftar Makanan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            if (_foodItems.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Belum ada makanan ditambahkan.',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _foodItems.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = _foodItems[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.restaurant,
                      color: AppColors.primary,
                    ),
                    title: Text(item.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${item.calories} kcal',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: AppColors.error,
                          ),
                          onPressed: () => _removeFood(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  // ---------- Ringkasan total & status ----------
  Widget _buildSummaryCard() {
    final Color statusColor;
    final String statusLabel;
    final IconData statusIcon;

    switch (_status) {
      case CalorieStatus.deficit:
        statusColor = Colors.blue;
        statusLabel = 'Defisit $_difference kcal';
        statusIcon = Icons.trending_down;
        break;
      case CalorieStatus.surplus:
        statusColor = AppColors.error;
        statusLabel = 'Surplus $_difference kcal';
        statusIcon = Icons.trending_up;
        break;
      case CalorieStatus.onTarget:
        statusColor = AppColors.primary;
        statusLabel = 'Sesuai Target';
        statusIcon = Icons.check_circle;
        break;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Kalori',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  '$_totalCalories kcal',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Target Kalori'),
                Text('$_targetCalories kcal'),
              ],
            ),
            const Divider(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: statusColor),
              ),
              child: Row(
                children: [
                  Icon(statusIcon, color: statusColor),
                  const SizedBox(width: 8),
                  Text(
                    statusLabel,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
