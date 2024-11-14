import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import paket intl untuk format tanggal

class OrderPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final String? deliveryType;
  final DateTime? selectedDate;

  const OrderPage({
    super.key,
    required this.cartItems,
    this.deliveryType,
    this.selectedDate,
  });

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // Variable untuk menyimpan metode pembayaran yang dipilih
  String? selectedPaymentMethod = 'Cash';

  @override
  Widget build(BuildContext context) {
    int totalAmount = widget.cartItems.fold(0, (sum, item) => sum + (item['price'] as int));

    // Format tanggal pemesanan, jika ada
    String formattedDate = widget.selectedDate != null
        ? DateFormat('d MMMM yyyy').format(widget.selectedDate!)
        : "Tidak ada tanggal yang dipilih";

    return Scaffold(
      appBar: AppBar(
        title: Text("Order"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan total harga pesanan
            Text(
              "Total Pesanan: Rp $totalAmount",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Menampilkan tipe pengiriman
            Text(
              "Tipe Pengiriman: ${widget.deliveryType ?? 'Belum dipilih'}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Menampilkan tanggal pemesanan
            Text(
              "Tanggal Pemesanan: $formattedDate",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Menampilkan detail produk
            Text(
              "Detail Produk:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // List produk yang ada di keranjang
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  var item = widget.cartItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero, // Menghilangkan padding standar ListTile
                      title: Center( // Membuat konten title berada di tengah
                        child: Column(
                          children: [
                            item['imagePath'] != null
                                ? CircleAvatar(
                                    radius: 50, // Mengatur ukuran gambar lebih besar
                                    backgroundImage: AssetImage(item['imagePath']),
                                  )
                                : Container(), // Jika gambar tidak ada, tampilkan container kosong
                            SizedBox(height: 10),
                            Text(item['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Rp ${item['price']}"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Dropdown untuk memilih metode pembayaran
            SizedBox(height: 20),
            Text(
              "Metode Pembayaran:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedPaymentMethod,
              isExpanded: true,
              items: <String>['Cash', 'Debit', 'Transfer']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedPaymentMethod = newValue!;
                });
              },
            ),

            // Tombol konfirmasi pesanan (opsional)
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic untuk konfirmasi pesanan
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Pesanan Dikonfirmasi"),
                    content: Text("Metode pembayaran: $selectedPaymentMethod"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              child: Text("Konfirmasi Pesanan"),
            ),
          ],
        ),
      ),
    );
  }
}
