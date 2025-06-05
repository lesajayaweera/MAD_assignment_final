import 'package:flutter/material.dart';

class carContainer extends StatelessWidget {
  const carContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'asset/image/car.jpg',
                    fit: BoxFit.cover,
                    width: 200,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,

                      shape: BoxShape.circle,
                    ),

                    child: Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                      size: 13,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Car Name',
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Car Model',
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              '\$20,000',
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
