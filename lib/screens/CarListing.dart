import 'package:flutter/material.dart';
import 'package:my_app/components/common/myappBar.dart';
import 'package:my_app/components/common/mydrawer.dart';
import 'package:my_app/components/pages/Home/product_container.dart';

class ProductsPage extends StatelessWidget {
   ProductsPage({super.key});
  List<String> images = [
    'asset/image/car.jpg',
    'asset/image/car2.jpg',
    'asset/image/car3.jpg',
    'asset/image/car4.jpg',
    'asset/image/car5.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(title: 'Car Listings'),
      drawer: myDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Expanded(
            child:
              ListView.builder(itemBuilder: (_, index) {
                return Center(child: ProductContainer());
              }, itemCount: images.length),
          ),
        ],
      ),
    );
  }
}