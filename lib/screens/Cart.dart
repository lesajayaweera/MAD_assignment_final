import 'package:flutter/material.dart';
import 'package:my_app/Data/cart.dart';

import 'package:my_app/components/pages/Cart/CartItem.dart';
import 'package:my_app/components/pages/Cart/EmptyCart.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    if(cart.isEmpty){
      return EmptyCart();
    }else{
       return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cart.length,
            itemBuilder: (_, index) {
              final product = cart[index];
              return CartItem(
                product: product,
                remove: () {
                  setState(() {
                    RemoveProduct(product);
                  });
                },
              );
            },
          ),
        ),
        _paymentContainer(),
      ],
    );
    }
  }
}

Widget _paymentContainer() {
  return Container(
    margin: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shipping Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 16),

        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              Image.asset(
                'asset/image/visa.png',
                height: 24,
                width: 40,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 12),
              Text(
                '**** **** **** 2143',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
        SizedBox(height: 32),

        _buildSummaryRow('Total (9 items)', '\$1,014.95'),
        _buildSummaryRow('Shipping Fee', '\$0.00'),
        _buildSummaryRow('Discount', '\$0.00'),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sub Total',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '\$1,014.95',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 40),

        Center(
          child: ElevatedButton(
            onPressed: () {
              print('Pay button pressed!');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              'Pay',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    ),
  );
}

Widget _buildSummaryRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
