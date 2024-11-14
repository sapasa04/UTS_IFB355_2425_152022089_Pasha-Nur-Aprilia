import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import paket intl untuk format tanggal
import 'package:kasir_aplikasi/screens/order.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Variabel untuk menampung tanggal yang dipilih
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    int totalAmount = widget.cartItems.fold(
        0, (sum, item) => sum + (item['price'] as int)); // Hitung total harga

    // Ambil deliveryType dari item pertama atau set default jika tidak ada
    String deliveryType = widget.cartItems.isNotEmpty
        ? widget.cartItems[0]['deliveryType'] ?? ''
        : 'Takeaway'; // Default jika keranjang kosong

    // Fungsi untuk memilih tanggal
    Future<void> _selectDate(BuildContext context) async {
      final DateTime picked = (await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2101),
      ))!;
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked; // Simpan tanggal yang dipilih
        });
    }

    // Format tanggal menggunakan intl
    String formattedDate = selectedDate != null
        ? DateFormat('d MMMM yyyy').format(selectedDate!) // Misalnya: 13 November 2024
        : "Pilih Tanggal Pemesanan";

    return Scaffold(
      appBar: AppBar(title: Text("Keranjang Belanja")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Pusatkan elemen-elemen
          children: [
            // Gambar besar di atas
            Center(
              child: CircleAvatar(
                backgroundImage: widget.cartItems.isNotEmpty &&
                        widget.cartItems[0]['imagePath'] != null
                    ? AssetImage(widget.cartItems[0]['imagePath'])
                    : null,
                radius: 80, // Ukuran gambar besar
                child: widget.cartItems.isEmpty ||
                        widget.cartItems[0]['imagePath'] == null
                    ? Icon(Icons.image_not_supported, size: 80)
                    : null,
              ),
            ),
            SizedBox(height: 20), // Jarak antara gambar dan elemen lainnya

            // Total harga dan jumlah total
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.attach_money, size: 30),
                  SizedBox(width: 8),
                  Text(
                    "Total: Rp $totalAmount",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Tampilkan tipe pengiriman jika ada
            if (widget.cartItems.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Tipe Pengiriman: $deliveryType",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],

            // Tampilkan pilihan tanggal pemesanan
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, size: 30),
                  SizedBox(width: 8),
                  Text(
                    formattedDate, // Tampilkan tanggal yang diformat
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text("Pilih Tanggal"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      backgroundColor: Colors.white, // Tombol dengan background putih
                      foregroundColor: Colors.blue, // Warna teks tombol biru
                    ),
                  ),
                ],
              ),
            ),

            // Tampilkan tanggal yang dipilih hanya setelah memilih
            if (selectedDate != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Tanggal Pemesanan: $formattedDate", // Tampilkan tanggal terpilih
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

            // Tombol untuk konfirmasi pesanan
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedDate == null) {
                      // Jika tanggal belum dipilih, beri peringatan
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Harap pilih tanggal pemesanan")),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Apakah sudah sesuai pesanan?"),
                          content: Text("Pastikan pesanan Anda sudah benar."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderPage(
                                      cartItems: widget.cartItems,
                                      deliveryType: deliveryType, // Kirim tipe pengiriman
                                      selectedDate: selectedDate, // Kirim tanggal yang dipilih
                                    ),
                                  ),
                                );
                              },
                              child: Text("Ya, Sudah Sesuai"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Tidak"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text("Konfirmasi Pesanan"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
