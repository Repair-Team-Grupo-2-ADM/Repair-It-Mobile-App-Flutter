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

class CreateReportPage extends StatefulWidget {
  final appointmentId;
  final imgUrl;

  CreateReportPage(this.appointmentId, this.imgUrl);

  @override
  State<CreateReportPage> createState() => _CreateReportPage();
}

class _CreateReportPage extends State<CreateReportPage> {
  final TextEditingController observationController = TextEditingController();
  final TextEditingController diagnosisController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title:"Create Report"),
              bottomNavigationBar: TechNavBar(),
      body: ListView(
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
            child: TextFormField(
              controller: observationController,
              decoration: InputDecoration(hintText: "Observación"),
              validator: (value) {},
            ),
            margin: EdgeInsets.all(10.0),
          ),
          Container(
            child: TextFormField(
              controller: diagnosisController,
              decoration: InputDecoration(hintText: "Diagnóstico"),
              validator: (value) {},
            ),
            margin: EdgeInsets.all(10.0),
          ),
          Container(
            child: TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(hintText: "Reparación"),
              validator: (value) {},
            ),
            margin: EdgeInsets.all(10.0),
          ),
          MaterialButton(
            height: 50,
            minWidth: 150,
            color: Colors.lightBlueAccent,
            textColor: Colors.white,
            child: Text(
              "Send",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              if (descriptionController.text != "" &&
                  observationController.text != "" &&
                  diagnosisController.text != "") {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                String? username = prefs.getString("username");

                var technicianResponse =
                    await getTechnicianByUsername(username);
                var user = json.decode(technicianResponse.body); 
                DateTime currentTime = new DateTime.now();

                var response = await createReport(
                    user["id"].toString(),
                    widget.appointmentId.toString(),
                    observationController.text,
                    diagnosisController.text,
                    descriptionController.text,
                    DateFormat('yyyy-MM-dd').format(currentTime));
                if (response.statusCode == HttpStatus.ok) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RoutesPage()));
                }
              }
            },
            splashColor: colorFromHex('053742'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ],
      ),
    );
  }
}
