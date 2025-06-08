import 'package:flutter/material.dart';
import 'package:my_app/Data/items.dart';

import 'package:my_app/components/pages/CarListing/LogoButton.dart';
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
    return Column(
        children: [
          const SizedBox(height: 10),

          // Brand logos list
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 100,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: brands.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Logobutton(
                    name: brands[index]['name']!,
                    image: brands[index]['image']!,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 15),

          // Responsive Grid with LayoutBuilder
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive column count based on width
                int crossAxisCount = (constraints.maxWidth ~/ 300).clamp(1, 4);

                return GridView.builder(
                  itemCount:products.length, // Replace with actual product count
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio:1.3, // Adjust as needed
                  ),
                  itemBuilder: (context, index) {
                    final item = products[index];
                    return  ProductContainer(product: item,);
                  },
                );
              },
            ),
          ),
        ],
      );
  }
}
