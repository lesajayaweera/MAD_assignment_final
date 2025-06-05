import 'package:flutter/material.dart';

class ProductContainer extends StatelessWidget {
  const ProductContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Image.asset(
            'asset/image/car.jpg',
            fit: BoxFit.cover,
            height: 150,
            width: 300,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Luxury Car Model',
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$100,000',
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 16,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}