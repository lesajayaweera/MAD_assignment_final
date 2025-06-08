import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/components/common/myappBar.dart';
import 'package:my_app/components/common/mydrawer.dart';
import 'package:my_app/components/pages/Home/featuredItem.dart';
import 'package:my_app/components/pages/Home/product_container.dart';




class Home extends StatefulWidget {
   Home({super.key});

  

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final ScrollController _scrollController = ScrollController();
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: featuredImages.length + 1), (timer) {
      if (_scrollController.hasClients) {
        double nextPosition = _scrollController.offset + 300;
        if (nextPosition >= _scrollController.position.maxScrollExtent) {
          _scrollController.animateTo(0, duration: Duration(seconds: 1), curve: Curves.easeInOut);
        } else {
          _scrollController.animateTo(nextPosition, duration: Duration(seconds: 1), curve: Curves.easeInOut);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> featuredImages = [
    {'image': 'asset/image/car.jpg','text' :"Porche 911 Spider", 'isNew': true},
    {'image': 'asset/image/car2.jpg','text' :"BMW M3 CS", 'isNew': false},
    {'image': 'asset/image/car3.jpg','text' :"Chevelot Corvette Z06", 'isNew': true},
    {'image': 'asset/image/car4.jpg','text' :"Mercedes-Benz S-Class", 'isNew': false},
    {'image': 'asset/image/car5.jpg','text' :"BMW M4 Cs", 'isNew': true},
    {'image': 'asset/image/car6.jpg','text' :"Dodge Challenger", 'isNew': false},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(title: 'LuxCars'),
      drawer: myDrawer(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // search bar section
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for cars',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () {
                      // Handle filter action
                    },
                  ),
                ],
              ),
            ),
            // featured car section
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      textAlign: TextAlign.start,
                      'Featured Cars',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 170, // Set height for horizontal list
                    child: ListView.builder(
                      itemCount: featuredImages.length,
                      physics: BouncingScrollPhysics(),
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      itemBuilder: (context, index) {
                        return featuredItem(
                          imageUrl: featuredImages[index]['image'] ?? '',
                          text: featuredImages[index]['text'] ?? '',
                          isNew: featuredImages[index]['isNew'] ?? false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          textAlign: TextAlign.start,
                          'Latest Cars',
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: TextButton(
                          onPressed: () {
                            // Handle view all action
                          },
                          child: Text('View All'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 280, // Set height for horizontal list
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemBuilder: (context, index) {
                        return const ProductContainer();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Add some space between sections
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          textAlign: TextAlign.start,
                          'Popular Cars',
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: TextButton(
                          onPressed: () {
                            // Handle view all action
                          },
                          child: Text('View All'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 300, // Set height for horizontal list
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemBuilder: (context, index) {
                        return const ProductContainer();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental),
            label: 'Car Listing',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3_rounded),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}