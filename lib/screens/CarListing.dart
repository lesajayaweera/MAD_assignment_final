import 'package:flutter/material.dart';
import 'package:my_app/Data/items.dart';
import 'package:my_app/components/pages/Home/product_container.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({super.key});

  final List<Map<String, String>> brands = [
    {'name': 'BMW', 'image': 'asset/image/bmw_logo.png'},
    {'name': 'Benz', 'image': 'asset/image/benz_logo.png'},
    {'name': 'Rolls Royce', 'image': 'asset/image/royce_logo.png'},
    {'name': 'Lamborghini', 'image': 'asset/image/lamborghini_logo.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;

        
        int crossAxisCount = orientation == Orientation.landscape
            ? (screenWidth ~/ 250).clamp(2, 6)
            : (screenWidth ~/ 300).clamp(1, 4);

        
        double aspectRatio = orientation == Orientation.landscape ? 1 : 1.3;

        return GridView.builder(
          itemCount: products.length,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: aspectRatio,
          ),
          itemBuilder: (context, index) {
            final item = products[index];
            return ProductContainer(product: item);
          },
        );
      },
    );
  }
}
