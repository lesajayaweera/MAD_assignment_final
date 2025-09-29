// import 'package:flutter/material.dart';
// import 'package:my_app/Data/items.dart';
// import 'package:my_app/Essentials/functions.dart';
// import 'package:my_app/components/common/myappBar.dart';
// import 'package:my_app/Data/cart.dart';

// class ProductDetails extends StatefulWidget {
//   const ProductDetails({super.key, required this.product});
//   final Products product;

//   @override
//   State<ProductDetails> createState() => _ProductDetailsState();
// }

// class _ProductDetailsState extends State<ProductDetails> {
//   @override
//   Widget build(BuildContext context) {
//     Orientation view = MediaQuery.of(context).orientation;
//     return Scaffold(
//       appBar: myAppbar(title: widget.product.name),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),

//           child: Column(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(16),

//                 child: Image.asset(
//                   widget.product.imageUrl,
//                   width: view == Orientation.landscape ? 400 :300,
//                   height: 300,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,

//                 children: [
//                   SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,

//                     children: [
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             widget.product.name,
//                             style: TextStyle(
//                               fontFamily: 'poppins',
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             formatPrice(widget.product.price),
//                             style: TextStyle(fontSize: 20, color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             '4/5',
//                             style: TextStyle(
//                               fontSize: 21,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.amberAccent.shade200,
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Icon(Icons.star, color: Colors.amberAccent.shade400),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     widget.product.description,
//                     style: TextStyle(fontFamily: 'poppins'),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Features',
//                     style: TextStyle(
//                       fontFamily: 'poppins',
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Engine',
//                             style: TextStyle(fontFamily: 'poppins'),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             widget.product.engine,
//                             style: TextStyle(color: Colors.blueGrey),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Transmission',
//                             style: TextStyle(fontFamily: 'poppins'),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             widget.product.transmission,
//                             style: TextStyle(color: Colors.blueGrey),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Fuel Type',
//                             style: TextStyle(fontFamily: 'poppins'),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             widget.product.fuelType,
//                             style: TextStyle(color: Colors.blueGrey),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),

//                   SizedBox(height: 16),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (!cart.contains(widget.product)) {
//                           AddtoCart(widget.product);
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text(
//                                 '${widget.product.name} added to cart!',

//                               ),
//                               duration: Duration(seconds: 2),
//                             ),
//                           );
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text(
//                                 '${widget.product.name} is already in the cart!',
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                       child: Text('Add to Cart'),
//                       style: ElevatedButton.styleFrom(
                        
//                         padding: const EdgeInsets.symmetric(
//                           // Padding inside button
//                           vertical: 16,
//                           horizontal: 24,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           // Rounded corners
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:my_app/Data/items.dart';
import 'package:my_app/Essentials/functions.dart';
import 'package:my_app/components/common/myappBar.dart';
import 'package:my_app/Data/cart.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});
  final Products product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorite = false;

  Widget _buildFeatureCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.blue.shade600,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Orientation view = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: myAppbar(title: widget.product.name),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Image Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        widget.product.imageUrl,
                        width: view == Orientation.landscape ? 500 : double.infinity,
                        height: 320,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Favorite Button
                    Positioned(
                      top: 12,
                      right: 12,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey.shade700,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Details Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Rating Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.product.name,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1A1A1A),
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.product.model,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Rating Badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade50,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber.shade600,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '4.0',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Price
                        Row(
                          children: [
                            Text(
                              'Price',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              formatPrice(widget.product.price),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 28,
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Description Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.product.description,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            height: 1.6,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Features Section
                  const Text(
                    'Specifications',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildFeatureCard(
                          icon: Icons.speed,
                          label: 'Engine',
                          value: widget.product.engine,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFeatureCard(
                          icon: Icons.settings,
                          label: 'Transmission',
                          value: widget.product.transmission,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFeatureCard(
                          icon: Icons.local_gas_station,
                          label: 'Fuel Type',
                          value: widget.product.fuelType,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!cart.contains(widget.product)) {
                          AddtoCart(widget.product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      '${widget.product.name} added to cart!',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.green.shade600,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      '${widget.product.name} is already in the cart!',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.orange.shade600,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.shopping_cart_outlined, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
