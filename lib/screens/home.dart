import 'package:flutter/material.dart';
import 'package:kasir_aplikasi/screens/details.dart';
import 'package:kasir_aplikasi/widgets/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool bakery = false, biskuit = false, cakes = false, pastry = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hello Sweet,",
                  style: AppWidget.boldTextFieldStyle(),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              "Delicious Bakery",
              style: AppWidget.HeadlineTextFieldStyle(),
            ),
            Text(
              "Discover and Get Great Bakes",
              style: AppWidget.LightTextFieldStyle(),
            ),
            SizedBox(height: 20.0),
            Container(child: showItem()),
            SizedBox(height: 30.0),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(right: 20.0),
                children: bakeryItems.map((item) {
                  return buildItemRow(
                    item['name']!,
                    item['image']!,
                    item['description']!,
                    item['price']!,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildCategoryButton("Bakery", "assets/image/bakery.jpg", bakery, () {
          setState(() {
            bakery = true;
            biskuit = false;
            cakes = false;
            pastry = false;
          });
        }),
        buildCategoryButton("Biskuit", "assets/image/biskuit.jpg", biskuit, () {
          setState(() {
            bakery = false;
            biskuit = true;
            cakes = false;
            pastry = false;
          });
        }),
        buildCategoryButton("Cakes", "assets/image/cakes.jpg", cakes, () {
          setState(() {
            bakery = false;
            biskuit = false;
            cakes = true;
            pastry = false;
          });
        }),
        buildCategoryButton("Pastry", "assets/image/pastry.jpg", pastry, () {
          setState(() {
            bakery = false;
            biskuit = false;
            cakes = false;
            pastry = true;
          });
        }),
      ],
    );
  }

  Widget buildCategoryButton(
      String label, String image, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(8),
          child: Image.asset(image, height: 40, width: 40, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget buildItemRow(
      String title, String imagePath, String description, String price) {
    String? companionImagePath;
    String? companionName;
    String? companionDescription;
    String? companionPrice;

    // Define companion items with new prices
    if (title == "Baguette") {
      companionName = "Sourdough";
      companionImagePath = "assets/image/Sourdough.jpg";
      companionDescription = "Tangy, chewy bread.";
      companionPrice = "Rp 20.000";
    } else if (title == "Ciabatta") {
      companionName = "Shortbread";
      companionImagePath = "assets/image/Shortbread.jpg";
      companionDescription = "Crisp and buttery biscuits.";
      companionPrice = "Rp 12.000";
    } else if (title == "Focaccia") {
      companionName = "Milk Bread";
      companionImagePath = "assets/image/milk bread.jpg";
      companionDescription = "Soft and slightly sweet bread.";
      companionPrice = "Rp 40.000";
    } else if (title == "Roti Gandum") {
      companionName = "Roti Sosis";
      companionImagePath = "assets/image/roti sosis.jpg";
      companionDescription = "Savory sausage bread.";
      companionPrice = "Rp 30.000";
    } else if (title == "Roti Manis") {
      companionName = "Garlic Bread";
      companionImagePath = "assets/image/garlic bread.jpg";
      companionDescription = "Buttery, garlic-flavored bread.";
      companionPrice = "Rp 25.000";
    } else if (title == "Roti Sobek") {
      companionName = "Roti Abon";
      companionImagePath = "assets/image/roti abon.jpg";
      companionDescription = "Soft bread filled with savory shredded beef.";
      companionPrice = "Rp 32.000";
    } else if (title == "Roti Tawar") {
      companionName = "Roti Keju";
      companionImagePath = "assets/image/roti keju.jpg";
      companionDescription = "Cheesy, soft bread with a rich flavor.";
      companionPrice = "Rp 18.000";
    }

    return Row(
      children: [
        Flexible(child: buildItemCard(title, imagePath, description, price)),
        if (companionName != null && companionImagePath != null)
          Flexible(
            child: buildItemCard(
                companionName, companionImagePath, companionDescription!, companionPrice!)),
      ],
    );
  }

  Widget buildItemCard(
      String title, String imagePath, String description, String price) {
    int? priceInt = int.tryParse(price.replaceAll("Rp ", "").replaceAll(".", ""));
    if (priceInt == null) {
      return Container(); // Return empty container if price is invalid
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(
              name: title,
              description: description,
              imagePath: imagePath,
              price: priceInt,
            ),
          ),
        );
      },
      child: Container(
        width: 170,  // Ukuran yang sama untuk semua item
        height: 300, // Tinggi yang sama untuk semua item
        margin: EdgeInsets.all(8),  // Margin antar item
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar dengan ukuran yang konsisten
                Image.asset(imagePath,
                    height: 120,  // Tinggi gambar yang seragam
                    width: double.infinity, // Lebar gambar mengikuti kontainer
                    fit: BoxFit.cover),  // Gambar ditampilkan dengan mode cover
                SizedBox(height: 10.0),
                // Nama produk dengan penekanan lebih
                Text(
                  title,
                  style: AppWidget.boldTextFieldStyle().copyWith(fontSize: 18),
                ),
                SizedBox(height: 5.0),
                // Deskripsi produk dengan gaya ringan
                Text(
                  description,
                  style: AppWidget.LightTextFieldStyle().copyWith(fontSize: 14),
                ),
                SizedBox(height: 10.0),
                // Harga dengan gaya tebal dan menonjol
                Text(
                  price,
                  style: AppWidget.boldTextFieldStyle().copyWith(
                      fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Data bakery items
final List<Map<String, String>> bakeryItems = [
  {
    "name": "Baguette",
    "image": "assets/image/Baguette.jpg",
    "description": "Crispy with a crunchy crust.",
    "price": "Rp 10.000"
  },
  {
    "name": "Ciabatta",
    "image": "assets/image/Ciabatta.jpg",
    "description": "Soft and airy with olive oil.",
    "price": "Rp 15.000"
  },
  {
    "name": "Focaccia",
    "image": "assets/image/Focaccia.jpg",
    "description": "Flavorful with herbs and olive oil.",
    "price": "Rp 30.000"
  },
  {
    "name": "Roti Gandum",
    "image": "assets/image/roti gandum.jpg",
    "description": "Healthy whole wheat bread.",
    "price": "Rp 15.000"
  },
   {
    "name": "Roti Manis",
    "image": "assets/image/roti manis.jpg",
    "description": "Soft, sweet bread perfect for breakfast.",
    "price": "Rp 20.000"
  },
  {
    "name": "Roti Sobek",
    "image": "assets/image/roti sobek.jpg",
    "description": "Soft and fluffy pull-apart bread.",
    "price": "Rp 25.000"
  },
  {
    "name": "Roti Tawar",
    "image": "assets/image/roti tawar.jpg",
    "description": "Plain white bread with a soft texture.",
    "price": "Rp 12.000"
  },
];

