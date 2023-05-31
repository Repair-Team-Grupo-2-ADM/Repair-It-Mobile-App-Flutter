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

class ReportDetailPage extends StatefulWidget {
  final report;
  final imgUrl;

  ReportDetailPage(this.report, this.imgUrl);

  @override
  State<ReportDetailPage> createState() => _ReportDetailPage();
}

class _ReportDetailPage extends State<ReportDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar("Create Report"),
                bottomNavigationBar: TechNavBar(),
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
                  widget.report["observation"],
                  style: TextStyle(fontSize: 20),
                ),
                margin: EdgeInsets.all(10.0),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                child: Text(
                  widget.report["diagnosis"],
                  style: TextStyle(fontSize: 20),
                ),
                margin: EdgeInsets.all(10.0),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                child: Text(
                  widget.report["repairDescription"],
                  style: TextStyle(fontSize: 20),
                ),
                margin: EdgeInsets.all(10.0),
              ),
              Divider(
                color: Colors.grey,
              ),
            ],
          ),
        ));
  }
}
