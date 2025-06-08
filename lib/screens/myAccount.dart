import 'package:flutter/material.dart';
import 'package:my_app/components/common/myappBar.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(title: 'My Account'),
      body: Center(
        child: Text('this is the my Account page'),
      ),

    );
  }
}
