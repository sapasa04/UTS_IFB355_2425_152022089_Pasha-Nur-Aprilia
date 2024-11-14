import 'package:flutter/material.dart';

class MataUangScreen extends StatefulWidget {
  const MataUangScreen({super.key});

  @override
  _MataUangScreenState createState() => _MataUangScreenState();
}

class _MataUangScreenState extends State<MataUangScreen> {
  final TextEditingController amountController = TextEditingController();
  String selectedCurrency = 'USD';
  String conversionResult = '';

  // Fungsi untuk konversi mata uang
  double _convertCurrency(double amount) {
    switch (selectedCurrency) {
      case 'USD':
        return amount * 0.067; // Asumsikan 1 IDR = 0.067 USD
      case 'EUR':
        return amount * 0.062; // Asumsikan 1 IDR = 0.062 EUR
      case 'JPY':
        return amount * 9.5; // Asumsikan 1 IDR = 9.5 JPY
      default:
        return amount;
    }
  }

  void _convert() {
    double amount = double.tryParse(amountController.text) ?? 0;
    double result = _convertCurrency(amount);

    setState(() {
      conversionResult = '$result $selectedCurrency';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mata Uang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menambahkan gambar uang di atas input
            Row(
              children: [
                Image.asset(
                  'assets/image/uang.png', // Ganti dengan path gambar uang Anda
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 10),
                Text(
                  'Konversi Mata Uang',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan Jumlah IDR',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCurrency = newValue!;
                });
              },
              items: <String>['USD', 'EUR', 'JPY']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Konversi'),
            ),
            SizedBox(height: 20),
            // Menampilkan hasil konversi dengan gambar uang
            Row(
              children: [
                Image.asset(
                  'assets/image/money.png', // Ganti dengan path gambar uang Anda
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 10),
                Text(
                  'Hasil Konversi: $conversionResult',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
