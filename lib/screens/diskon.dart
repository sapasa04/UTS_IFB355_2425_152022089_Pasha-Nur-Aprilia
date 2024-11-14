import 'package:flutter/material.dart';

class DiskonScreen extends StatefulWidget {
  @override
  _DiskonScreenState createState() => _DiskonScreenState();
}

class _DiskonScreenState extends State<DiskonScreen> {
  final TextEditingController priceController = TextEditingController(); // Controller untuk input harga
  double discountPrice = 0.0; // Harga setelah diskon
  String selectedDiscount = '10'; // Pilihan diskon awal, bisa 10% atau 20%

  // Fungsi untuk menghitung harga setelah diskon
  void _calculateDiscount() {
    double price = double.tryParse(priceController.text) ?? 0.0;
    double discountPercent = double.tryParse(selectedDiscount) ?? 0.0;
    setState(() {
      discountPrice = price - (price * discountPercent / 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diskon"),
      ),
      body: SingleChildScrollView( // Membungkus dengan SingleChildScrollView untuk menghindari overflow
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menambahkan gambar diskon di atas input harga barang
            Center(
              child: Image.asset(
                'assets/image/salee.png', // Ganti dengan path gambar yang sesuai
                height: 250, // Sesuaikan ukuran gambar (lebih besar)
                width: 250, // Sesuaikan ukuran gambar (lebih besar)
              ),
            ),
            SizedBox(height: 20),
            // Input harga barang
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan Harga Barang',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Menampilkan label untuk pilihan diskon
            Text("Pilih Diskon (%)"),
            SizedBox(height: 10),
            // Membuat dua kolom untuk radio button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Membuat dua sisi
              children: [
                Column(
                  children: [
                    for (int i = 10; i <= 50; i += 10)
                      Row(
                        children: [
                          Radio<String>(
                            value: '$i',
                            groupValue: selectedDiscount,
                            onChanged: (String? value) {
                              setState(() {
                                selectedDiscount = value!;
                              });
                            },
                          ),
                          Text("$i%"),
                        ],
                      ),
                  ],
                ),
                Column(
                  children: [
                    for (int i = 60; i <= 90; i += 10)
                      Row(
                        children: [
                          Radio<String>(
                            value: '$i',
                            groupValue: selectedDiscount,
                            onChanged: (String? value) {
                              setState(() {
                                selectedDiscount = value!;
                              });
                            },
                          ),
                          Text("$i%"),
                        ],
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // Tombol untuk menghitung harga setelah diskon
            ElevatedButton(
              onPressed: _calculateDiscount,
              child: Text("Hitung Diskon"),
            ),
            SizedBox(height: 20),
            // Menampilkan harga setelah diskon
            Text(
              'Harga Setelah Diskon: Rp ${discountPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
