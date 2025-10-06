import 'package:flutter/material.dart';
import 'package:my_app/Classes/apiService.dart';
import 'package:my_app/Classes/model/ShakeService.dart';

import 'package:my_app/components/common/myappBar.dart';
import 'package:my_app/components/common/mydrawer.dart';
import 'package:my_app/screens/CarListing.dart';
import 'package:my_app/screens/Cart.dart';
import 'package:my_app/screens/Notifications.dart';
import 'package:my_app/screens/home.dart';
import 'package:my_app/screens/authWrapper.dart';

class Dashboard extends StatefulWidget {
  final String token;
  const Dashboard({super.key, required this.token});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selected = 0;
  bool _isLogin = false;
  final ShakeDetector _shakeDetector = ShakeDetector();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _startShakeDetection();
  }

  @override
  void dispose() {
    _shakeDetector.stopListening();
    super.dispose();
  }

  void _startShakeDetection() {
    _shakeDetector.startListening(() {
      _showLogoutDialog();
    });
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Shake detected! Do you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await ApiService.removeToken();
                if (!mounted) return;
                
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const AuthWrapper()),
                  (route) => false,
                );
              },
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _checkLoginStatus() async {
    final token = await ApiService.getToken();
    if (token != null) {
      setState(() {
        _isLogin = true;
      });
    }
  }

  void _login() {
    setState(() {
      _isLogin = true;
    });
  }

  final List<Widget> _pages = [
    Home(),
    ProductsPage(),
    Notifications(),
    Cart()
  ];

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
    return Scaffold(
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
    );
  }
}