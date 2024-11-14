import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart'; // Impor package expressions
import 'dart:math'; // Impor dart:math untuk sqrt dan pow

class KalkulatorScreen extends StatefulWidget {
  @override
  _KalkulatorScreenState createState() => _KalkulatorScreenState();
}

class _KalkulatorScreenState extends State<KalkulatorScreen> {
  String input = '';
  String output = '';

  void tombolDitekan(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        input = '';
        output = '';
      } else if (buttonText == '=') {
        try {
          String finalInput = input;

          // Gantikan '√' dengan 'sqrt(' dan tambahkan kurung di akhir
          finalInput = finalInput.replaceAllMapped(
              RegExp(r'√(\d+\.?\d*)'), (match) => 'sqrt(${match[1]})');
          // Gantikan '^2' dengan pangkat dua menggunakan 'pow'
          finalInput = finalInput.replaceAllMapped(
              RegExp(r'(\d+\.?\d*)\^2'), (match) => 'pow(${match[1]}, 2)');

          // Evaluasi ekspresi menggunakan package expressions
          final expression = Expression.parse(finalInput);
          final evaluator = ExpressionEvaluator();
          final result = evaluator.eval(expression, {
            'sqrt': (num x) => sqrt(x),       // Fungsi akar kuadrat
            'pow': (num x, num y) => pow(x, y) // Fungsi pangkat
          });

          if (result != null) {
            output = result.toString();
          } else {
            output = 'Error';
          }
        } catch (e) {
          output = 'Error';
        }
      } else {
        input += buttonText;
      }
    });
  }

  Widget buildTombol(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => tombolDitekan(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 30),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kalkulator")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Kolom input
            Text(
              input,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Kolom output
            Text(
              output,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Tombol Kalkulator
            Row(
              children: [
                buildTombol('7'),
                buildTombol('8'),
                buildTombol('9'),
                buildTombol('/'),
              ],
            ),
            Row(
              children: [
                buildTombol('4'),
                buildTombol('5'),
                buildTombol('6'),
                buildTombol('*'),
              ],
            ),
            Row(
              children: [
                buildTombol('1'),
                buildTombol('2'),
                buildTombol('3'),
                buildTombol('-'),
              ],
            ),
            Row(
              children: [
                buildTombol('0'),
                buildTombol('.'),
                buildTombol('C'),
                buildTombol('+'),
              ],
            ),
            Row(
              children: [
                buildTombol('√'), // Tombol Akar
                buildTombol('^2'), // Tombol Kuadrat
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => tombolDitekan('='),
                    child: Text(
                      '=',
                      style: TextStyle(fontSize: 30),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
