import 'package:flutter/material.dart';

class featuredItem extends StatelessWidget {
  const featuredItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'asset/image/car.jpg',
              fit: BoxFit.cover,
              width: 250,
              height: 150,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Text(
              'Welcome to LuxCars',
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
