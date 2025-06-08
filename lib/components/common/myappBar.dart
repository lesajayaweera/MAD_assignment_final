import 'package:flutter/material.dart';
import 'package:my_app/screens/Login.dart';
import 'package:my_app/screens/Notifications.dart';

class myAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isNotificationEnabled;

  const myAppbar({
    Key? key,
    required this.title,
    this.isNotificationEnabled = true,
  }) : super(key: key);

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
      actions: isNotificationEnabled
          ? [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Notifications(),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 10,
                    right: 11,
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.redAccent,
                      ),
                      child: Text(
                        '3',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                icon: Icon(Icons.logout_rounded),
              ),
            ]
          : [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
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
