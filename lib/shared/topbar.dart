import 'package:flutter/material.dart';
import 'colorFromHex.dart';

// ignore: non_constant_identifier_names
AppBar TopBar(String title) {
  return AppBar(
      backgroundColor: colorFromHex("39A2DB"),
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
        onPressed: () {},
      ),
      title: Text(title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.notifications_none,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {},
        ),
      ],
      centerTitle: true);
}
