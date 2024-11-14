import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:kasir_aplikasi/screens/welcome_screen.dart';

class HalamanSplashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 5), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ),
        );
      });
    });

    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 78, 193, 170),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Aplikasi Bakery',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/image/foto.jpg'), // Ganti path sesuai dengan lokasi foto
            ),
            SizedBox(height: 10),
            Text(
              'Pasha Nur',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Text(
              '1520202089', // NIM Anda
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
