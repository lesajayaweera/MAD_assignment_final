import 'package:flutter/material.dart';

class featuredItem extends StatelessWidget {
  const featuredItem({super.key, required this.imageUrl, required this.text, required this.isNew});
  // Constructor to accept the image URL
  final String imageUrl;
  final bool isNew;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              width: 300,
              height: 200,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Text(
              text,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: isNew ? Colors.redAccent : Colors.orangeAccent,
              ),
              child: Text(
                isNew ? 'New' : 'Used',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
