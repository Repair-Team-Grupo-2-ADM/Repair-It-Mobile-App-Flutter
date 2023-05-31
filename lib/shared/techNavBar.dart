import 'package:flutter/material.dart';
import 'colorFromHex.dart';

class TechNavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: colorFromHex("39A2DB"),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      onTap: (value) {
        switch (value) {
          case 0:
            Navigator.of(context).pushReplacementNamed('/routes');
            break;
          case 1:
            Navigator.of(context).pushReplacementNamed('/reports');
            break;
          case 2:
            Navigator.of(context).pushReplacementNamed('/plans');
            break;
          case 3:
            Navigator.of(context).pushReplacementNamed('/profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          label: 'Routes',
          icon: Icon(Icons.route),
        ),
        BottomNavigationBarItem(
          label: 'Reports',
          icon: Icon(Icons.book),
        ),
        BottomNavigationBarItem(
          label: 'Plan',
          icon: Icon(Icons.payment),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
