// import 'package:flutter/material.dart';
// import 'package:my_app/Data/items.dart';
// import 'package:my_app/components/pages/Home/product_container.dart';

// class ProductsPage extends StatelessWidget {
//   ProductsPage({super.key});

//   final List<Map<String, String>> brands = [
//     {'name': 'BMW', 'image': 'asset/image/bmw_logo.png'},
//     {'name': 'Benz', 'image': 'asset/image/benz_logo.png'},
//     {'name': 'Rolls Royce', 'image': 'asset/image/royce_logo.png'},
//     {'name': 'Lamborghini', 'image': 'asset/image/lamborghini_logo.png'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final orientation = MediaQuery.of(context).orientation;

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double screenWidth = constraints.maxWidth;

        
//         int crossAxisCount = orientation == Orientation.landscape
//             ? (screenWidth ~/ 250).clamp(2, 6)
//             : (screenWidth ~/ 300).clamp(1, 4);

        
//         double aspectRatio = orientation == Orientation.landscape ? 1 : 1.3;

//         return GridView.builder(
//           itemCount: products.length,
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: crossAxisCount,
//             mainAxisSpacing: 16,
//             crossAxisSpacing: 16,
//             childAspectRatio: aspectRatio,
//           ),
//           itemBuilder: (context, index) {
//             final item = products[index];
//             return ProductContainer(product: item);
//           },
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:my_app/Data/items.dart';
import 'package:my_app/components/pages/Home/product_container.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String selectedBrand = 'All';
  String sortBy = 'newest';

  final List<Map<String, String>> brands = [
    {'name': 'All', 'image': ''},
    {'name': 'BMW', 'image': 'asset/image/bmw_logo.png'},
    {'name': 'Benz', 'image': 'asset/image/benz_logo.png'},
    {'name': 'Rolls Royce', 'image': 'asset/image/royce_logo.png'},
    {'name': 'Lamborghini', 'image': 'asset/image/lamborghini_logo.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          // Header Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'All Cars',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${products.length} cars',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                // Brand Filter Chips
                SizedBox(
                  height: 44,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: brands.length,
                    itemBuilder: (context, index) {
                      final brand = brands[index];
                      final isSelected = selectedBrand == brand['name'];
                      
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: FilterChip(
                          selected: isSelected,
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (brand['image']!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Image.asset(
                                    brand['image']!,
                                    height: 20,
                                    width: 20,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ),
                              Text(
                                brand['name']!,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: Colors.white,
                          selectedColor: Colors.blue.shade600,
                          checkmarkColor: Colors.white,
                          side: BorderSide(
                            color: isSelected
                                ? Colors.blue.shade600
                                : Colors.grey.shade300,
                            width: 1.5,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          onSelected: (selected) {
                            setState(() {
                              selectedBrand = brand['name']!;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Sort and Filter Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: sortBy,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey.shade700,
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'newest',
                                child: Text('Newest First'),
                              ),
                              DropdownMenuItem(
                                value: 'price_low',
                                child: Text('Price: Low to High'),
                              ),
                              DropdownMenuItem(
                                value: 'price_high',
                                child: Text('Price: High to Low'),
                              ),
                              DropdownMenuItem(
                                value: 'name',
                                child: Text('Name: A to Z'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                sortBy = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.tune,
                          color: Colors.grey.shade700,
                        ),
                        onPressed: () {
                          // Advanced filter action
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Grid Section
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double screenWidth = constraints.maxWidth;

                int crossAxisCount = orientation == Orientation.landscape
                    ? (screenWidth ~/ 280).clamp(2, 6)
                    : (screenWidth ~/ 320).clamp(1, 4);

                double aspectRatio =
                    orientation == Orientation.landscape ? 0.85 : 0.95;

                return GridView.builder(
                  itemCount: products.length,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: aspectRatio,
                  ),
                  itemBuilder: (context, index) {
                    final item = products[index];
                    return ProductContainer(product: item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}