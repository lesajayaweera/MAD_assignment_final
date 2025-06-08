import 'package:flutter/material.dart';
import 'package:my_app/Data/cart.dart';
import 'package:my_app/Data/items.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key, required this.product, required this.remove});
  final Products product;
  final VoidCallback remove;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                widget.product.imageUrl,
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
                    widget.product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    widget.product.model,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '\$${widget.product.price}', // Add dollar sign
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: widget.remove,
              icon: Icon(Icons.delete_rounded, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
