import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  // final String name;
  // final String image;
  // final int price;
  // final int quaniity;
  int item = 1;
  // required this.name, required this.image, required this.price, required this.quaniity
  CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2.0, // Adds a subtle shadow
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                'asset/image/car.jpg',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'title',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    'description',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '\$50', // Add dollar sign
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.remove_circle_outline),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    '15',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            SizedBox(width: 8.0),
            Icon(Icons.more_vert, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}
