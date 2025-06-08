import 'package:flutter/material.dart';
import 'package:my_app/components/common/myappBar.dart';

class ProductDetails extends StatefulWidget {
  final int productId;

  const ProductDetails({super.key,required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar :myAppbar(title: 'Vehicle Name'),
      body: Center(
        child: Text('Product Details'),
      ),

    );
  }
}
