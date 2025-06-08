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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(title: widget.product.name),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),

          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),

                child: Image.asset(
                  widget.product.imageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            formatPrice(widget.product.price),
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '4/5',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent.shade200,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.star, color: Colors.amberAccent.shade400),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.product.description,
                    style: TextStyle(fontFamily: 'poppins'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Features',
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Engine',
                            style: TextStyle(fontFamily: 'poppins'),
                          ),
                          SizedBox(height: 4),
                          Text(
                            widget.product.engine,
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transmission',
                            style: TextStyle(fontFamily: 'poppins'),
                          ),
                          SizedBox(height: 4),
                          Text(
                            widget.product.transmission,
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fuel Type',
                            style: TextStyle(fontFamily: 'poppins'),
                          ),
                          SizedBox(height: 4),
                          Text(
                            widget.product.fuelType,
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!cart.contains(widget.product)) {
                          AddtoCart(widget.product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${widget.product.name} added to cart!',

                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${widget.product.name} is already in the cart!',
                              ),
                            ),
                          );
                        }
                      },
                      child: Text('Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          // Padding inside button
                          vertical: 16,
                          horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          // Rounded corners
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
