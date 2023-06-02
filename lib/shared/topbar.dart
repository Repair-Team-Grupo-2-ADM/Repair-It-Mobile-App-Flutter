import 'package:flutter/material.dart';
import 'colorFromHex.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TopBar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: colorFromHex("#2196F3"),
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/appliances');
        },
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.logout, color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/login');
          },
        ),
      ],
      centerTitle: true,
    );
  }
}