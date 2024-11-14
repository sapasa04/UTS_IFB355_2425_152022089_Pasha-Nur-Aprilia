import 'package:flutter/material.dart';
import 'package:kasir_aplikasi/screens/bmi.dart';
import 'package:kasir_aplikasi/screens/signin_screen.dart';
import 'package:kasir_aplikasi/widgets/widget_support.dart';
import 'package:kasir_aplikasi/screens/kalkulator.dart';
import 'package:kasir_aplikasi/screens/diskon.dart'; // Impor halaman Diskon yang baru
import 'package:kasir_aplikasi/screens/matauang.dart'; // Import MataUangScreen
import 'package:kasir_aplikasi/screens/suhu.dart'; // Import SuhuScreen

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "Pasha"; // Inisialisasi dengan nilai default
  String email = "pasha@gmail.com"; // Inisialisasi dengan nilai default
  String birthDate = "01 Januari 1995"; // Inisialisasi dengan nilai default
  String address = "Jl. Merdeka No. 1, Jakarta"; // Inisialisasi dengan nilai default

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = name;
    emailController.text = email;
    birthDateController.text = birthDate;
    addressController.text = address;
  }

  // Fungsi untuk menampilkan form edit nama, email, tanggal lahir, atau alamat
  void _editProfile(String field) {
    TextEditingController controller;

    // Tentukan controller sesuai dengan field yang dipilih
    if (field == 'name') {
      controller = nameController;
    } else if (field == 'email') {
      controller = emailController;
    } else if (field == 'birthDate') {
      controller = birthDateController;
    } else {
      controller = addressController;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: field == 'name' ? 'Nama' : field == 'email' ? 'Email' : field == 'birthDate' ? 'Tanggal Lahir' : 'Alamat',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  // Update data sesuai field yang dipilih
                  if (field == 'name') {
                    name = nameController.text;
                  } else if (field == 'email') {
                    email = emailController.text;
                  } else if (field == 'birthDate') {
                    birthDate = birthDateController.text;
                  } else {
                    address = addressController.text;
                  }
                });
                Navigator.pop(context);
              },
              child: Text('Simpan'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: AppWidget.boldTextFieldStyle()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/image/foto.jpg"), // Ganti dengan path foto profil
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _editProfile('name');
              },
              child: Text(
                name,
                style: AppWidget.boldTextFieldStyle().copyWith(fontSize: 22),
              ),
            ),
            GestureDetector(
              onTap: () {
                _editProfile('email');
              },
              child: Text(
                email,
                style: AppWidget.LightTextFieldStyle(),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _editProfile('birthDate');
              },
              child: Text(
                birthDate,
                style: AppWidget.LightTextFieldStyle(),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _editProfile('address');
              },
              child: Text(
                address,
                style: AppWidget.LightTextFieldStyle(),
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Tanggal Lahir"),
              onTap: () {
                _editProfile('birthDate');
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("Alamat"),
              onTap: () {
                _editProfile('address');
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text("Kalkulator"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KalkulatorScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.fitness_center),
              title: Text("BMI Calculator"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BMI()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text("Mata Uang"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MataUangScreen()), // Navigasi ke MataUangScreen
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.thermostat),
              title: Text("Suhu"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SuhuScreen()), // Navigasi ke halaman Suhu
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.percent),
              title: Text("Diskon"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiskonScreen()), // Navigasi ke halaman Diskon
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Keluar"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
