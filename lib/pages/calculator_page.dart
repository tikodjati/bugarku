import 'package:flutter/material.dart';
import '../utils/constants.dart';

enum _Operation { tambah, kurang, kali, bagi }

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();

  _Operation _operation = _Operation.tambah;
  String? _result;
  String? _errorMessage;

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  String? _validateNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Tidak boleh kosong';
    }
    if (double.tryParse(value.trim().replaceAll(',', '.')) == null) {
      return 'Harus berupa angka';
    }
    return null;
  }

  String _operationSymbol(_Operation op) {
    switch (op) {
      case _Operation.tambah:
        return '+';
      case _Operation.kurang:
        return '-';
      case _Operation.kali:
        return '×';
      case _Operation.bagi:
        return '÷';
    }
  }

  void _calculate() {
    setState(() => _errorMessage = null);

    if (!_formKey.currentState!.validate()) {
      setState(() => _result = null);
      return;
    }

    final a = double.parse(_firstController.text.trim().replaceAll(',', '.'));
    final b = double.parse(_secondController.text.trim().replaceAll(',', '.'));

    double result;
    switch (_operation) {
      case _Operation.tambah:
        result = a + b;
        break;
      case _Operation.kurang:
        result = a - b;
        break;
      case _Operation.kali:
        result = a * b;
        break;
      case _Operation.bagi:
        if (b == 0) {
          setState(() {
            _errorMessage = 'Tidak bisa membagi dengan 0.';
            _result = null;
          });
          return;
        }
        result = a / b;
        break;
    }

    setState(() {
      // Tampilkan tanpa desimal berlebih jika hasilnya bilangan bulat.
      _result = result == result.roundToDouble()
          ? result.toStringAsFixed(0)
          : result.toStringAsFixed(4).replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
    });
  }

  void _reset() {
    _firstController.clear();
    _secondController.clear();
    setState(() {
      _result = null;
      _errorMessage = null;
      _operation = _Operation.tambah;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Kalkulator Bugar'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _firstController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Angka pertama',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateNumber,
                ),
                const SizedBox(height: 16),

                const Text(
                  'Operasi',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  children: _Operation.values.map((op) {
                    final selected = _operation == op;
                    return ChoiceChip(
                      label: Text(_operationSymbol(op)),
                      selected: selected,
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      onSelected: (_) => setState(() => _operation = op),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _secondController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Angka kedua',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateNumber,
                ),
                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _calculate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Hitung'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: _reset,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Reset'),
                    ),
                  ],
                ),

                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.error),
                  ),
                ],

                if (_result != null) ...[
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Hasil',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _result!,
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}