import 'package:flutter/material.dart';

class SuhuScreen extends StatefulWidget {
  const SuhuScreen({super.key});

  @override
  _SuhuScreenState createState() => _SuhuScreenState();
}

class _SuhuScreenState extends State<SuhuScreen> {
  final TextEditingController suhuController = TextEditingController();
  String selectedFromUnit = 'Celsius';
  String selectedToUnit = 'Fahrenheit';
  String conversionResult = '';

  // Fungsi untuk mengonversi suhu
  double _convertSuhu(double value) {
    switch (selectedFromUnit) {
      case 'Celsius':
        if (selectedToUnit == 'Fahrenheit') {
          return (value * 9 / 5) + 32;
        } else if (selectedToUnit == 'Kelvin') {
          return value + 273.15;
        }
        break;
      case 'Fahrenheit':
        if (selectedToUnit == 'Celsius') {
          return (value - 32) * 5 / 9;
        } else if (selectedToUnit == 'Kelvin') {
          return ((value - 32) * 5 / 9) + 273.15;
        }
        break;
      case 'Kelvin':
        if (selectedToUnit == 'Celsius') {
          return value - 273.15;
        } else if (selectedToUnit == 'Fahrenheit') {
          return ((value - 273.15) * 9 / 5) + 32;
        }
        break;
    }
    return value;
  }

  void _convert() {
    double value = double.tryParse(suhuController.text) ?? 0;
    double result = _convertSuhu(value);

    setState(() {
      conversionResult = '$result $selectedToUnit';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Suhu'),
      ),
      body: SingleChildScrollView( // Membungkus seluruh body dengan SingleChildScrollView
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menambahkan gambar suhu di atas input suhu
            Image.asset(
              'assets/image/suhu.jpg', // Pastikan gambar sudah ada di folder assets
              height: 150, // Menyesuaikan ukuran gambar
              width: double.infinity, // Membuat gambar memenuhi lebar layar
              fit: BoxFit.cover, // Agar gambar terlihat proporsional
            ),
            SizedBox(height: 20),

            // Input suhu
            TextField(
              controller: suhuController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan Nilai Suhu',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Dropdown untuk memilih satuan suhu asal
            DropdownButton<String>(
              value: selectedFromUnit,
              onChanged: (String? newValue) {
                setState(() {
                  selectedFromUnit = newValue!;
                });
              },
              items: <String>['Celsius', 'Fahrenheit', 'Kelvin']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Dropdown untuk memilih satuan suhu tujuan
            DropdownButton<String>(
              value: selectedToUnit,
              onChanged: (String? newValue) {
                setState(() {
                  selectedToUnit = newValue!;
                });
              },
              items: <String>['Celsius', 'Fahrenheit', 'Kelvin']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Tombol konversi
            ElevatedButton(
              onPressed: _convert,
              child: Text('Konversi'),
            ),
            SizedBox(height: 20),

            // Hasil konversi
            Text(
              'Hasil Konversi: $conversionResult',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
