import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'asset/image/emptyCart.png',
                  width: double.infinity,
                  
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Your Cart is Empty',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Add items to your cart to proceed with checkout.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
    );
  }
}