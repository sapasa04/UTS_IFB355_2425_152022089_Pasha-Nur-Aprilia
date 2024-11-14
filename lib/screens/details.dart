import 'package:flutter/material.dart';
import 'package:kasir_aplikasi/screens/buttomnav.dart'; // Import halaman Buttomnav

class Details extends StatefulWidget {
  final String name;
  final String description;
  final String imagePath;
  final int price;

  const Details({
    super.key,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  String? selectedDeliveryType = 'Takeaway'; // Menyimpan pilihan delivery type (Takeaway atau Dine In)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      widget.imagePath,
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        quantity.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(width: 20.0),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    widget.description,
                    maxLines: 3,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "This is a delicious and fresh made with premium ingredients!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Text("Delivery Time", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 5.0),
                      Icon(Icons.alarm, color: Colors.black54),
                      SizedBox(width: 5.0),
                      Text("30 min"),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Pilihan untuk Takeaway atau Dine In menggunakan Radio Buttons
                  Row(
                    children: [
                      // Add any other options if needed
                    ],
                  ),
                  ListTile(
                    title: Text("Takeaway"),
                    leading: Radio<String>(
                      value: 'Takeaway',
                      groupValue: selectedDeliveryType,
                      onChanged: (String? value) {
                        setState(() {
                          selectedDeliveryType = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text("Dine In"),
                    leading: Radio<String>(
                      value: 'Dine In',
                      groupValue: selectedDeliveryType,
                      onChanged: (String? value) {
                        setState(() {
                          selectedDeliveryType = value;
                        });
                      },
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Price", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              "\Rp ${widget.price * quantity}",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            // Pindah ke halaman Buttomnav dan mengubah tab ke Order
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Buttomnav(
                                  selectedIndex: 1, // Membuka tab Order
                                  orderName: widget.name,
                                  orderPrice: widget.price * quantity,
                                  imagePath: widget.imagePath,
                                  deliveryType: selectedDeliveryType, // Pass delivery type
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.black),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Add to cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                                SizedBox(width: 30.0),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(Icons.shopping_cart_outlined, color: Colors.white),
                                ),
                                SizedBox(width: 10.0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 40.0,
            left: 20.0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
                size: 24.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
