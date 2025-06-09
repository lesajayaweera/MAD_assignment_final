import 'package:flutter/material.dart';
import 'package:my_app/Data/cart.dart';
import 'package:my_app/Data/notifications.dart';
import 'package:my_app/Essentials/functions.dart';

import 'package:my_app/components/pages/Cart/CartItem.dart';
import 'package:my_app/components/pages/Cart/EmptyCart.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  void _handlePayment() {
    setState(() {
      // Add success notifications
      notifications.add(
        NotificationItem(
          title: 'Payment Successful',
          subtitle: 'Your payment of ${formatPrice(GetTotal())} was completed.',
          icon: Icons.check_circle,
          iconColor: Colors.green,
          date: DateTime.now().toString().split(' ')[0],
        ),
      );
      notifications.add(
        NotificationItem(
          title: 'Order Successful',
          subtitle: 'Your order was completed.',
          icon: Icons.check_circle,
          iconColor: Colors.orangeAccent,
          date: DateTime.now().toString().split(' ')[0],
        ),
      );

      // Clear the cart
      cart.clear();
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment successful!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (cart.isEmpty) {
      return EmptyCart();
    } else {
      return LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = MediaQuery.of(context).size.height;
          final screenWidth = MediaQuery.of(context).size.width;
          final isWide = screenWidth > 600;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.4,
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
                   SizedBox(height: 16),
                  _paymentContainer(isWide),
                  
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Widget _paymentContainer(bool isWide) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(12.0),
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping Information',
            style: TextStyle(
              fontSize: isWide ? 24 : 20,
              fontWeight: FontWeight.bold,
             
            ),
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
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
          _buildSummaryRow('Total (${cart.length} items)', formatPrice(GetTotal())),
          _buildSummaryRow('Shipping Fee', '\$0.00'),
          _buildSummaryRow('Discount', '\$0.00'),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sub Total',
                style: TextStyle(
                  fontSize: isWide ? 20 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                formatPrice(GetTotal()),
                style: TextStyle(
                  fontSize: isWide ? 20 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          Center(
            child: ElevatedButton(
              onPressed: _handlePayment,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Pay',
                style: TextStyle(
                  fontSize: isWide ? 20 : 18,
                  fontWeight: FontWeight.w600,
                ),
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
            ),
          ),
        ],
      ),
    );
  }
}
