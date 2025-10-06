// import 'package:flutter/material.dart';
// import 'package:my_app/Classes/orderService.dart';
// import 'package:my_app/Data/notifications.dart';
// import 'package:my_app/Essentials/functions.dart';
// import 'package:my_app/components/pages/Cart/EmptyCart.dart';
// import 'package:my_app/Classes/model/Orders.dart';

// class Cart extends StatefulWidget {
//   const Cart({super.key});

//   @override
//   State<Cart> createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   late Future<Map<String, dynamic>> _cartDataFuture;
//   bool _isProcessing = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadCartData();
//   }

//   void _loadCartData() {
//     _cartDataFuture = _fetchCartData();
//   }

//   Future<Map<String, dynamic>> _fetchCartData() async {
//     final orders = await OrderService.getOrders();
//     double total = 0.0;
    
//     for (var order in orders) {
//       total += double.parse(order.finalPrice);
//     }
    
//     return {
//       'orders': orders,
//       'total': total,
//     };
//   }

//   Future<void> _handleRemoveItem(String orderId) async {
//     try {
//       await OrderService.cancelOrder(orderId);
      
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Item removed from cart'),
//             backgroundColor: Colors.orange,
//             duration: Duration(seconds: 2),
//           ),
//         );
        
//         setState(() {
//           _loadCartData();
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to remove item: $e'),
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 2),
//           ),
//         );
//       }
//     }
//   }

//   Future<void> _handleCheckout(List<Order> orders, double total) async {
//     if (_isProcessing) return;
    
//     setState(() {
//       _isProcessing = true;
//     });

//     try {
//       final billingInfo = {
//         'card_number': '**** **** **** 2143',
//         'shipping_address': 'Rajagiriya, Athurugiriya',
//       };

//       await OrderService.checkout(billingInfo);

//       // Add notifications
//       notifications.add(
//         NotificationItem(
//           title: 'Payment Successful',
//           subtitle: 'Your payment of ${formatPrice(total)} was completed.',
//           icon: Icons.check_circle,
//           iconColor: Colors.green,
//           date: DateTime.now().toString().split(' ')[0],
//         ),
//       );
      
//       notifications.add(
//         NotificationItem(
//           title: 'Order Confirmed',
//           subtitle: '${orders.length} items ordered successfully.',
//           icon: Icons.shopping_bag,
//           iconColor: Colors.orangeAccent,
//           date: DateTime.now().toString().split(' ')[0],
//         ),
//       );

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Payment successful! Orders confirmed.'),
//             backgroundColor: Colors.green,
//             duration: Duration(seconds: 3),
//           ),
//         );
        
//         setState(() {
//           _loadCartData();
//           _isProcessing = false;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Payment failed: $e'),
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 3),
//           ),
//         );
        
//         setState(() {
//           _isProcessing = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map<String, dynamic>>(
//       future: _cartDataFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         if (snapshot.hasError) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Error loading cart',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.red[700],
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   '${snapshot.error}',
//                   style: const TextStyle(color: Colors.grey),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 24),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     setState(() {
//                       _loadCartData();
//                     });
//                   },
//                   icon: const Icon(Icons.refresh),
//                   label: const Text('Retry'),
//                 ),
//               ],
//             ),
//           );
//         }

//         if (!snapshot.hasData) {
//           return const EmptyCart();
//         }

//         final orders = snapshot.data!['orders'] as List<Order>;
//         final total = snapshot.data!['total'] as double;

//         if (orders.isEmpty) {
//           return const EmptyCart();
//         }

//         return _buildCartContent(orders, total);
//       },
//     );
//   }

//   Widget _buildCartContent(List<Order> orders, double total) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isWide = screenWidth > 600;

//     return Column(
//       children: [
//         Expanded(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Shopping Cart',
//                     style: TextStyle(
//                       fontSize: isWide ? 28 : 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     '${orders.length} ${orders.length == 1 ? 'item' : 'items'}',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   ListView.separated(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: orders.length,
//                     separatorBuilder: (_, __) => const SizedBox(height: 16),
//                     itemBuilder: (context, index) {
//                       final order = orders[index];
//                       return _buildCartItem(order);
//                     },
//                   ),
//                   const SizedBox(height: 24),
//                   _buildOrderSummary(orders, total, isWide),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         _buildCheckoutButton(orders, total),
//       ],
//     );
//   }

//   Widget _buildCartItem(Order order) {
//     final vehicle = order.vehicle;
//     final imageUrl = vehicle.imageUrls.isNotEmpty 
//         ? vehicle.imageUrls[0] 
//         : '';

//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: imageUrl.isNotEmpty
//                   ? Image.network(
//                       imageUrl,
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                       errorBuilder: (_, __, ___) => Container(
//                         width: 100,
//                         height: 100,
//                         color: Colors.grey[300],
//                         child: const Icon(Icons.directions_car, size: 40),
//                       ),
//                     )
//                   : Container(
//                       width: 100,
//                       height: 100,
//                       color: Colors.grey[300],
//                       child: const Icon(Icons.directions_car, size: 40),
//                     ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '${vehicle.make} ${vehicle.model}',
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '${vehicle.year} • ${vehicle.condition}',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '${vehicle.transmission} • ${vehicle.fuelType}',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         formatPrice(double.parse(order.finalPrice)),
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue,
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.delete_outline, color: Colors.red),
//                         onPressed: () => _handleRemoveItem(order.orderId),
//                         tooltip: 'Remove',
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOrderSummary(List<Order> orders, double total, bool isWide) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Order Summary',
//               style: TextStyle(
//                 fontSize: isWide ? 22 : 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             _buildSummaryRow('Subtotal (${orders.length} items)', formatPrice(total)),
//             const SizedBox(height: 8),
//             _buildSummaryRow('Shipping Fee', '\$0.00'),
//             const SizedBox(height: 8),
//             _buildSummaryRow('Tax', formatPrice(total *0.09)),
//             const SizedBox(height: 8),
//             _buildSummaryRow('Discount', '\$0.00', isDiscount: true),
//             const Divider(height: 24, thickness: 1.5),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Total',
//                   style: TextStyle(
//                     fontSize: isWide ? 22 : 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   formatPrice(total + (total *0.09)),
//                   style: TextStyle(
//                     fontSize: isWide ? 22 : 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.grey[300]!),
//               ),
//               child: Row(
//                 children: [
//                   Image.asset(
//                     'asset/image/visa.png',
//                     height: 24,
//                     width: 40,
//                     fit: BoxFit.contain,
//                     errorBuilder: (_, __, ___) => const Icon(
//                       Icons.credit_card,
//                       size: 24,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     '**** **** **** 2143',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const Spacer(),
//                   Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSummaryRow(String label, String value, {bool isDiscount = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey[700],
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             color: isDiscount ? Colors.green : null,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCheckoutButton(List<Order> orders, double total) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: ElevatedButton(
//           onPressed: _isProcessing ? null : () => _handleCheckout(orders, total),
//           style: ElevatedButton.styleFrom(
//             minimumSize: const Size(double.infinity, 56),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             elevation: 0,
//           ),
//           child: _isProcessing
//               ? const SizedBox(
//                   height: 24,
//                   width: 24,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                   ),
//                 )
//               : Text(
//                   'Proceed to Checkout • ${formatPrice(total)}',
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:my_app/Classes/orderService.dart';
import 'package:my_app/Essentials/functions.dart';
import 'package:my_app/components/pages/Cart/EmptyCart.dart';
import 'package:my_app/Classes/model/Orders.dart';

import 'package:my_app/screens/BillingInfor.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late Future<Map<String, dynamic>> _cartDataFuture;

  @override
  void initState() {
    super.initState();
    _loadCartData();
  }

  void _loadCartData() {
    _cartDataFuture = _fetchCartData();
  }

  Future<Map<String, dynamic>> _fetchCartData() async {
    final orders = await OrderService.getOrders();
    double total = 0.0;
    
    for (var order in orders) {
      total += double.parse(order.finalPrice);
    }
    
    return {
      'orders': orders,
      'total': total,
    };
  }

  Future<void> _handleRemoveItem(String orderId) async {
    try {
      await OrderService.cancelOrder(orderId);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item removed from cart'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
        
        setState(() {
          _loadCartData();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to remove item: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _navigateToBilling(List<Order> orders, double total) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BillingInfoScreen(
          orders: orders,
          total: total,
        ),
      ),
    ).then((_) {
      // Refresh cart data when returning from billing screen
      setState(() {
        _loadCartData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _cartDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text(
                  'Error loading cart',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${snapshot.error}',
                  style: const TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _loadCartData();
                    });
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (!snapshot.hasData) {
          return const EmptyCart();
        }

        final orders = snapshot.data!['orders'] as List<Order>;
        final total = snapshot.data!['total'] as double;

        if (orders.isEmpty) {
          return const EmptyCart();
        }

        return _buildCartContent(orders, total);
      },
    );
  }

  Widget _buildCartContent(List<Order> orders, double total) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 600;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shopping Cart',
                    style: TextStyle(
                      fontSize: isWide ? 28 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${orders.length} ${orders.length == 1 ? 'item' : 'items'}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orders.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return _buildCartItem(order);
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildOrderSummary(orders, total, isWide),
                ],
              ),
            ),
          ),
        ),
        _buildCheckoutButton(orders, total),
      ],
    );
  }

  Widget _buildCartItem(Order order) {
    final vehicle = order.vehicle;
    final imageUrl = vehicle.imageUrls.isNotEmpty 
        ? vehicle.imageUrls[0] 
        : '';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                        child: const Icon(Icons.directions_car, size: 40),
                      ),
                    )
                  : Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[300],
                      child: const Icon(Icons.directions_car, size: 40),
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${vehicle.make} ${vehicle.model}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${vehicle.year} • ${vehicle.condition}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${vehicle.transmission} • ${vehicle.fuelType}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatPrice(double.parse(order.finalPrice)),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => _handleRemoveItem(order.orderId),
                        tooltip: 'Remove',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(List<Order> orders, double total, bool isWide) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(
                fontSize: isWide ? 22 : 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow('Subtotal (${orders.length} items)', formatPrice(total)),
            const SizedBox(height: 8),
            _buildSummaryRow('Shipping Fee', '\$0.00'),
            const SizedBox(height: 8),
            _buildSummaryRow('Tax (9%)', formatPrice(total * 0.09)),
            const SizedBox(height: 8),
            _buildSummaryRow('Discount', '\$0.00', isDiscount: true),
            const Divider(height: 24, thickness: 1.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: isWide ? 22 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  formatPrice(total + (total * 0.09)),
                  style: TextStyle(
                    fontSize: isWide ? 22 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Container(
            //   padding: const EdgeInsets.all(12),
            //   decoration: BoxDecoration(
            //     color: Colors.grey[100],
            //     borderRadius: BorderRadius.circular(8),
            //     border: Border.all(color: Colors.grey[300]!),
            //   ),
            //   child: Row(
            //     children: [
            //       Image.asset(
            //         'asset/image/visa.png',
            //         height: 24,
            //         width: 40,
            //         fit: BoxFit.contain,
            //         errorBuilder: (_, __, ___) => const Icon(
            //           Icons.credit_card,
            //           size: 24,
            //         ),
            //       ),
            //       const SizedBox(width: 12),
            //       const Text(
            //         '**** **** **** 2143',
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //       const Spacer(),
            //       Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDiscount ? Colors.green : null,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton(List<Order> orders, double total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: () => _navigateToBilling(orders, total),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Text(
            'Proceed to Checkout • ${formatPrice(total)}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}