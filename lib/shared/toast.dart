
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'colorFromHex.dart';

Future<bool?> displayToast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: colorFromHex('#eb097e'),
        textColor: Colors.white,
        fontSize: 14.0);
  }