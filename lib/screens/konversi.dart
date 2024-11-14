import 'package:flutter/material.dart';

class KonversiScreen extends StatefulWidget {
  const KonversiScreen({super.key});

  @override
  _KonversiScreenState createState() => _KonversiScreenState();
}

class _KonversiScreenState extends State<KonversiScreen> {
  final TextEditingController numberController = TextEditingController(); // Controller untuk input angka
  String selectedConversion = 'Binary'; // Pilihan konversi
  String conversionResult = ''; // Hasil konversi

  // Fungsi untuk mengonversi angka sesuai pilihan
  void _convertNumber() {
    int number = int.tryParse(numberController.text) ?? 0; // Parsing input angka dari TextField
    String result = '';
    switch (selectedConversion) {
      case 'Binary':
        result = _toBinary(number);
        break;
      case 'Hexadecimal':
        result = _toHexadecimal(number);
        break;
      case 'Octal':
        result = _toOctal(number);
        break;
      case 'Currency Format':
        result = _toCurrencyFormat(number);
        break;
      default:
        result = 'Pilih konversi terlebih dahulu';
    }

    setState(() {
      conversionResult = result; // Update hasil konversi
    });
  }

  // Fungsi untuk konversi ke biner
  String _toBinary(int number) {
    return number.toRadixString(2);
  }

  // Fungsi untuk konversi ke hexadecimal
  String _toHexadecimal(int number) {
    return number.toRadixString(16).toUpperCase();
  }

  // Fungsi untuk konversi ke octal
  String _toOctal(int number) {
    return number.toRadixString(8);
  }

  // Fungsi untuk konversi ke format mata uang
  String _toCurrencyFormat(int number) {
    return 'Rp ${number.toStringAsCurrency()}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Konversi Bilangan"),
      ),
      body: SingleChildScrollView( // Membungkus konten dengan SingleChildScrollView
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Menambahkan gambar di atas input angka
            Center(
              child: Image.asset(
                'assets/image/konversi.png', // Ganti dengan path gambar yang sesuai
                height: 150, // Sesuaikan ukuran gambar
                width: 150, // Sesuaikan ukuran gambar
              ),
            ),
            SizedBox(height: 20),
            // Input angka
            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan angka',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Dropdown untuk memilih jenis konversi
            DropdownButton<String>(
              value: selectedConversion,
              onChanged: (String? newValue) {
                setState(() {
                  selectedConversion = newValue!;
                  _convertNumber(); // Panggil konversi setelah memilih dropdown
                });
              },
              items: <String>['Binary', 'Hexadecimal', 'Octal', 'Currency Format']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Menampilkan hasil konversi
            Text(
              'Hasil Konversi: $conversionResult',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _convertNumber, // Tombol untuk melakukan konversi
              child: Text("Konversi"),
            ),
          ],
        ),
      ),
    );
  }
}

extension on int {
  String toStringAsCurrency() {
    // Fungsi untuk format angka ke format mata uang
    return this.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: KonversiScreen(),
  ));
}
