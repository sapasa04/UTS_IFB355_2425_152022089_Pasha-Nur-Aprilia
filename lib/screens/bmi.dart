import 'package:flutter/material.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double? _bmiResult;
  String _status = "";

  void _calculateBMI() {
    final double height = double.tryParse(_heightController.text) ?? 0;
    final double weight = double.tryParse(_weightController.text) ?? 0;
    if (height > 0 && weight > 0) {
      setState(() {
        _bmiResult = weight / ((height / 100) * (height / 100));
        if (_bmiResult! < 18.5) {
          _status = "Underweight";
        } else if (_bmiResult! < 24.9) {
          _status = "Normal weight";
        } else if (_bmiResult! < 29.9) {
          _status = "Overweight";
        } else {
          _status = "Obesity";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
      ),
      body: SingleChildScrollView( // Membungkus body dengan SingleChildScrollView
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Menambahkan gambar di atas input Height
            Center(
              child: Image.asset(
                'assets/image/bmii.png', // Ganti dengan path gambar yang sesuai
                height: 150, // Sesuaikan ukuran gambar
                width: 150, // Sesuaikan ukuran gambar
              ),
            ),
            SizedBox(height: 20),
            // Input Height
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Height (cm)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Input Weight
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Weight (kg)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: Text("Calculate BMI"),
            ),
            SizedBox(height: 20),
            if (_bmiResult != null)
              Column(
                children: [
                  Text("BMI: ${_bmiResult!.toStringAsFixed(1)}",
                      style: TextStyle(fontSize: 24)),
                  Text("Status: $_status", style: TextStyle(fontSize: 18)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
