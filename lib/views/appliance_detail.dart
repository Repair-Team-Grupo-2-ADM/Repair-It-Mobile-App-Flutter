import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:mobile_safetechnology/shared/httpHelper.dart';
import 'package:mobile_safetechnology/shared/topbar.dart';
import 'package:mobile_safetechnology/views/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/colorFromHex.dart';
import '../shared/techNavBar.dart';
import '../shared/clientNavBar.dart';

class ApplianceDetailPage extends StatefulWidget {
  final appliance;
  final imgUrl;

  ApplianceDetailPage(this.appliance, this.imgUrl);

  @override
  State<ApplianceDetailPage> createState() => _ApplianceDetailPage();
}

class _ApplianceDetailPage extends State<ApplianceDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar("Add Appliance"),
        bottomNavigationBar: ClientNavBar(),
        body: SafeArea(
          minimum: EdgeInsets.only(left: 50.0, right: 50.0, top: 20),
          child: ListView(
            children: <Widget>[
              Container(
                child: Image.network(
                  widget.imgUrl.toString(),
                  width: 150,
                  height: 150,
                ),
                margin: EdgeInsets.all(10.0),
              ),
              Container(
                child: Text(
                  widget.appliance["name"],
                  style: TextStyle(fontSize: 20),
                ),
                margin: EdgeInsets.all(10.0),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                child: Text(
                  widget.appliance["model"],
                  style: TextStyle(fontSize: 20),
                ),
                margin: EdgeInsets.all(10.0),
              ),
              Divider(
                color: Colors.grey,
              ), /*
              Container(
                child: Text(
                  widget.appliance["repairDescription"],
                  style: TextStyle(fontSize: 20),
                ),
                margin: EdgeInsets.all(10.0),
              ),
              Divider(
                color: Colors.grey,
              ),*/
            ],
          ),
        ));
  }
}
