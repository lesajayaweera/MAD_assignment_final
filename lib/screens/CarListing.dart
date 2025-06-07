import 'package:flutter/material.dart';
import 'package:my_app/components/common/myappBar.dart';
import 'package:my_app/components/common/mydrawer.dart';
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
    return Scaffold(
      appBar: myAppbar(title: 'Car Listings'),
      drawer: myDrawer(),
      body: Column(
        children: [
          const SizedBox(height: 10),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 100,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
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

          Expanded(
            child: GridView.builder(
              itemCount: 6, // Change this based on your actual product list
              padding: const EdgeInsets.symmetric(horizontal: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // 2 items per row
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3 / 2,
              ),
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ProductContainer()],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
