import 'package:flutter/material.dart';
import 'package:my_app/Essentials/themeData.dart';
import 'package:my_app/components/common/myappBar.dart';
import 'package:my_app/components/common/mydrawer.dart';
import 'package:my_app/screens/CarListing.dart';
import 'package:my_app/screens/Cart.dart';
import 'package:my_app/screens/Login.dart';
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
  bool _isLogin = false;

  void _login() {
    setState(() {
      _isLogin = true;
    });
  }

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
      theme: customLightTheme,
      darkTheme: customDarkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: _isLogin
          ? Scaffold(
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
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
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
            )
          : Login(login: _login),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:my_app/TestScreen.dart';


// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'API Test App',
//       home: WebTestScreen(), // Start with test screen first
//       theme: ThemeData(primarySwatch: Colors.blue),
//     );
//   }
// }