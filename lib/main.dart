import 'package:flutter/material.dart';
import 'package:kasir_aplikasi/screens/signin_screen.dart';
import 'package:kasir_aplikasi/screens/splashscreen.dart';
import 'package:kasir_aplikasi/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kasir Aplikasi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       home: HalamanSplashscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
