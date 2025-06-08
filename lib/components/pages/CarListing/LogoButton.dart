import 'package:flutter/material.dart';

class Logobutton extends StatelessWidget {
  final String name;
  final String image;

  const Logobutton({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey)
          )
      ),
      onPressed: () {},
      child: Container(
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, width: 60, height: 60),
            Text(name, style: TextStyle(fontFamily: 'poppins', fontSize: 16,fontWeight: FontWeight.w700)),
          ],

        ),
      ),

    );
  }
}
