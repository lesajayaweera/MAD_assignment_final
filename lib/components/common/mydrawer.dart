import 'package:flutter/material.dart';

class myDrawer extends StatelessWidget {
  const myDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 100,
              child: DrawerHeader(
                decoration: const BoxDecoration(color: Colors.transparent),
                child: const Center(
                  child: Text(
                    'LuxCars',
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Handle home navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Car Listing'),
              onTap: () {
                // Handle settings navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              onTap: () {
                // Handle about navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_2),
              title: const Text('My Account'),
              onTap: () {
                // Handle about navigation
              },
            ),
          ],
        ),
      );
  }
}