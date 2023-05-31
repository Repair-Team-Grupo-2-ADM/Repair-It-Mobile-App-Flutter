import 'package:flutter/material.dart';
import 'package:mobile_safetechnology/views/login.dart';
import 'package:mobile_safetechnology/views/my_appliances.dart';
import 'package:mobile_safetechnology/views/notifications.dart';
import 'package:mobile_safetechnology/views/plans.dart';
import 'package:mobile_safetechnology/views/profile.dart';
import 'package:mobile_safetechnology/views/recovery_password.dart';
import 'package:mobile_safetechnology/views/reports.dart';
import 'package:mobile_safetechnology/views/routes.dart';
import 'package:mobile_safetechnology/views/signup.dart';
//import 'package:flutter_offirent/main.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {

      //case '/':
      //return MaterialPageRoute(builder: (_) => FirstPage());

      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());

      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupPage());

      case '/recovery_password':
        return MaterialPageRoute(builder: (_) => RecoveryPasswordPage());

      case '/appliances':
        return MaterialPageRoute(builder: (_) => MyAppliancesPage());

      case '/routes':
        return MaterialPageRoute(builder: (_) => RoutesPage());

      case '/reports':
        return MaterialPageRoute(builder: (_) => ReportsPage());

      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());

      case '/plans':
        return MaterialPageRoute(builder: (_) => PlansPage());

      case '/notifications':
        return MaterialPageRoute(builder: (_) => NotificationsPage());
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
