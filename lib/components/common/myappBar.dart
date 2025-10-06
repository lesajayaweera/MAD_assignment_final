import 'package:flutter/material.dart';
import 'package:my_app/Classes/apiService.dart';

import 'package:my_app/screens/Favourites.dart';

import 'package:my_app/screens/authWrapper.dart';

class myAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const myAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'poppins',
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>FavoritesPage()));
        }, icon: Icon(Icons.favorite))
        ,
        IconButton(
          onPressed: () async {
            ApiService.removeToken();
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const AuthWrapper()),
                (route) => false,
              );
            }

            
          },
          icon: Icon(Icons.logout_rounded),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
