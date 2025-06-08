import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'package:my_app/screens/Login.dart';


class myAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const myAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'poppins',
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
          icon: Icon(Icons.logout_rounded),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
