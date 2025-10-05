// import 'dart:async';

// import 'package:flutter/material.dart';

// import 'package:my_app/components/pages/Home/featuredItem.dart';
// import 'package:my_app/components/pages/Home/product_container.dart';

// import 'package:my_app/Data/items.dart';

// class Home extends StatefulWidget {
//   Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   final ScrollController _scrollController = ScrollController();
//   late final Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(Duration(seconds: featuredImages.length + 1), (
//       timer,
//     ) {
//       if (_scrollController.hasClients) {
//         double nextPosition = _scrollController.offset + 300;
//         if (nextPosition >= _scrollController.position.maxScrollExtent) {
//           _scrollController.animateTo(
//             0,
//             duration: Duration(seconds: 1),
//             curve: Curves.easeInOut,
//           );
//         } else {
//           _scrollController.animateTo(
//             nextPosition,
//             duration: Duration(seconds: 1),
//             curve: Curves.easeInOut,
//           );
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   final List<Map<String, dynamic>> featuredImages = [
//     {
//       'image': 'asset/image/car.jpg',
//       'text': "Porche 911 Spider",
//       'isNew': true,
//     },
//     {'image': 'asset/image/car2.jpg', 'text': "BMW M3 CS", 'isNew': false},
//     {
//       'image': 'asset/image/car3.jpg',
//       'text': "Chevelot Corvette Z06",
//       'isNew': true,
//     },
//     {
//       'image': 'asset/image/car4.jpg',
//       'text': "Mercedes-Benz S-Class",
//       'isNew': false,
//     },
//     {'image': 'asset/image/car5.jpg', 'text': "BMW M4 Cs", 'isNew': true},
//     {
//       'image': 'asset/image/car6.jpg',
//       'text': "Dodge Challenger",
//       'isNew': false,
//     },
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: BouncingScrollPhysics(),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // search bar section
//           Container(
//             padding: EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search for cars',
//                       prefixIcon: Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8.0),
//                 IconButton(
//                   icon: Icon(Icons.filter_list),
//                   onPressed: () {
//                     // Handle filter action
//                   },
//                 ),
//               ],
//             ),
//           ),
//           // featured car section
//           Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15.0),
//                   child: Text(
//                     textAlign: TextAlign.start,
//                     'Featured Cars',
//                     style: TextStyle(
//                       fontFamily: 'poppins',
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 170,
//                   child: ListView.builder(
//                     itemCount: products.length,
//                     physics: BouncingScrollPhysics(),
//                     controller: _scrollController,
//                     scrollDirection: Axis.horizontal,
//                     padding: EdgeInsets.symmetric(horizontal: 16.0),
//                     itemBuilder: (context, index) {
//                       final car = products[index];
//                       return featuredItem(product: car);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20),
//           Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15.0),
//                       child: Text(
//                         textAlign: TextAlign.start,
//                         'Latest Cars',
//                         style: TextStyle(
//                           fontFamily: 'poppins',
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),

//                   ],
//                 ),
//                 SizedBox(
//                   height: 280,
//                   child: ListView.builder(
//                     itemCount: products.length,
//                     scrollDirection: Axis.horizontal,
//                     physics: BouncingScrollPhysics(),
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     itemBuilder: (context, index) {
//                       final item = products[index];
//                       return ProductContainer(product: item);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20),
//           Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15.0),
//                       child: Text(
//                         textAlign: TextAlign.start,
//                         'Popular Cars',
//                         style: TextStyle(
//                           fontFamily: 'poppins',
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),

//                   ],
//                 ),
//                 SizedBox(
//                   height: 300,
//                   child: ListView.builder(
//                     itemCount: products.length,
//                     scrollDirection: Axis.horizontal,
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     itemBuilder: (context, index) {
//                       final items = products[index];
//                       return ProductContainer(product: items);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/Classes/model/Vehicles.dart';
import 'package:my_app/Classes/vehicle_service.dart';

import 'package:my_app/components/pages/Home/featuredItem.dart';
import 'package:my_app/components/pages/Home/product_container.dart';

import 'package:my_app/Data/items.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  late final Timer _timer;

  List<Vehicle> _vehicles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _fetchVehicle();

  
    _timer = Timer.periodic(Duration(seconds: featuredImages.length + 1), (
      timer,
    ) {
      if (_scrollController.hasClients) {
        double nextPosition = _scrollController.offset + 300;
        if (nextPosition >= _scrollController.position.maxScrollExtent) {
          _scrollController.animateTo(
            0,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            nextPosition,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  Future<void> _fetchVehicle() async {
    try{
      final response = await VehicleService.getVehicles();
      setState((){
        _vehicles = response.map<Vehicle>((json) => Vehicle.fromJson(json)).toList();
          print(_vehicles);
        _isLoading = false;

      });
    }
    catch(e){
      print('Error fetching vehicles: $e');
      setState((){
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> featuredImages = [
    {
      'image': 'asset/image/car.jpg',
      'text': "Porche 911 Spider",
      'isNew': true,
    },
    {'image': 'asset/image/car2.jpg', 'text': "BMW M3 CS", 'isNew': false},
    {
      'image': 'asset/image/car3.jpg',
      'text': "Chevelot Corvette Z06",
      'isNew': true,
    },
    {
      'image': 'asset/image/car4.jpg',
      'text': "Mercedes-Benz S-Class",
      'isNew': false,
    },
    {'image': 'asset/image/car5.jpg', 'text': "BMW M4 Cs", 'isNew': true},
    {
      'image': 'asset/image/car6.jpg',
      'text': "Dodge Challenger",
      'isNew': false,
    },
  ];

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
              letterSpacing: -0.5,
            ),
          ),
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'See All',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.blue.shade700,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),

            // Search bar section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 12.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for cars...',
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey.shade600,
                            size: 22,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.tune, color: Colors.grey.shade700),
                      onPressed: () {
                        // Handle filter action
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Featured Cars section
            _buildSectionHeader('Featured Cars'),
            SizedBox(
              height: 180,
              child: ListView.builder(
                itemCount: products.length,
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                itemBuilder: (context, index) {
                  final car = products[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: featuredItem(product: car),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Latest Cars section
            _buildSectionHeader(
              'Latest Cars',
              onSeeAll: () {
                // Handle see all action
              },
            ),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: _vehicles.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                itemBuilder: (context, index) {
                  final item = _vehicles[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: ProductContainer(product: item),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Popular Cars section
            _buildSectionHeader(
              'Popular Cars',
              onSeeAll: () {
                // Handle see all action
              },
            ),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: _vehicles.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                itemBuilder: (context, index) {
                  final items = _vehicles[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: ProductContainer(product: items),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
