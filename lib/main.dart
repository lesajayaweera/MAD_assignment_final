import 'package:flutter/material.dart';
import 'package:my_app/components/common/myappBar.dart';
import 'package:my_app/components/common/mydrawer.dart';
import 'package:my_app/screens/CarListing.dart';
import 'package:my_app/screens/Cart.dart';
import 'package:my_app/screens/Notifications.dart';
import 'package:my_app/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selected = 0;

  final List<Widget> _pages = [Home(), ProductsPage(), Notifications(), Cart()];

  final List<String> _titles = [
    'Home',
    'Car Listings',
    'Notifications',
    'My Cart',
  ];

  void _onTapped(int index) {
    setState(() {
      selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LuxCars',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: myAppbar(title: _titles[selected]),
        drawer: myDrawer(
          onItemTap: (index) {
            setState(() {
              selected = index;
            });
          },
        ),

        body: _pages[selected],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selected,
          onTap: _onTapped,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.car_rental),
              label: 'Car Listing',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'My Cart',
            ),
          ],
        ),
      ),
    );
  }
}
