import 'package:flutter/material.dart';

class carContainer extends StatelessWidget {
  const carContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'asset/image/car.jpg',
              fit: BoxFit.cover,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}
