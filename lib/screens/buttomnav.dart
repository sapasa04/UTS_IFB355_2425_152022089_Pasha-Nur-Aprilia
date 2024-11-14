import 'package:flutter/material.dart';
import 'package:kasir_aplikasi/screens/home.dart';
import 'package:kasir_aplikasi/screens/cart.dart';
import 'package:kasir_aplikasi/screens/profile.dart';
import 'package:kasir_aplikasi/screens/order.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Buttomnav extends StatefulWidget {
  final int selectedIndex;
  final String? orderName; // Nama produk yang dipesan
  final int? orderPrice; // Harga produk yang dipesan
  final String? imagePath; // Path gambar produk
  final String? deliveryType;
  final String? deliveryTime; // Waktu pengiriman
  final List<Map<String, dynamic>>? existingCartItems; // Tambahkan ini untuk menyimpan data keranjang yang sudah ada

  const Buttomnav({
    super.key,
    this.selectedIndex = 0, // Default buka Home
    this.orderName,
    this.orderPrice,
    this.imagePath,
    this.deliveryType,
    this.deliveryTime,
    this.existingCartItems, // Tambahkan ini juga
  });

  @override
  State<Buttomnav> createState() => _ButtomnavState();
}

class _ButtomnavState extends State<Buttomnav> {
  late int currentTabIndex;
  late List<Widget> pages;
  late Home homepage;
  late Profile profilePage;
  late CartPage cartPage;
  late OrderPage orderPage;
  late List<Map<String, dynamic>> cartItems; // List untuk menyimpan item di keranjang

  @override
  void initState() {
    super.initState();
    currentTabIndex = widget.selectedIndex;

    // Jika ada keranjang yang sudah ada, kita gunakan itu, jika tidak, buat list kosong
    cartItems = widget.existingCartItems ?? [];

    homepage = Home();
    cartPage = CartPage(cartItems: cartItems); // Keranjang berisi daftar produk
    orderPage = OrderPage(cartItems: cartItems, deliveryType: '',); // Ringkasan pesanan
    profilePage = Profile();

    pages = [homepage, cartPage, orderPage, profilePage];

    // Tambah produk ke keranjang jika ada detail produk yang diteruskan
    if (widget.orderName != null && widget.orderPrice != null) {
      cartItems.add({
        "name": widget.orderName,
        "price": widget.orderPrice,
        "imagePath": widget.imagePath,
        "deliveryType": widget.deliveryType,
        "deliveryTime": widget.deliveryTime,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.black,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(Icons.home_outlined, color: Colors.black),
          Icon(Icons.shopping_cart_outlined, color: Colors.black), // Keranjang
          Icon(Icons.receipt_long_outlined, color: Colors.black), // Pesanan
          Icon(Icons.person_outlined, color: Colors.black),
        ],
      ),
      body: pages[currentTabIndex], // Tampilkan halaman yang dipilih
    );
  }
}
