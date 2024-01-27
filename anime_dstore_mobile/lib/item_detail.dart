import 'package:flutter/material.dart';

class ItemDetailPage extends StatelessWidget {
  final String itemName;
  final String itemImage;
  final double itemPrice;

  ItemDetailPage({
    required this.itemName,
    required this.itemImage,
    required this.itemPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          itemName,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "BebasNeue",
            fontSize: 24,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              itemImage,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              itemName,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Raleway",
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              '\$$itemPrice',
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Raleway",
              ),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
