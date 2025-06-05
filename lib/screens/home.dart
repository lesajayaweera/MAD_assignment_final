import 'package:flutter/material.dart';
import 'package:my_app/components/common/myappBar.dart';
import 'package:my_app/components/common/mydrawer.dart';
import 'package:my_app/components/pages/Home/featuredItem.dart';
import 'package:my_app/components/pages/Home/product_container.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(title: 'LuxCars'),
      drawer: myDrawer(),
      body: SingleChildScrollView(
        child: Column(
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
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      itemBuilder: (context, index) {
                        return featuredItem();
                      },
                    ),
                  ),
                ],
              ),
            ),
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
            label: 'Products',
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
