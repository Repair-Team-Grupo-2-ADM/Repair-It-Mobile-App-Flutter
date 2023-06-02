import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_safetechnology/shared/clientNavBar.dart';
import 'package:mobile_safetechnology/shared/techNavBar.dart';
import 'package:mobile_safetechnology/views/report_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/colorFromHex.dart';
import '../shared/httpHelper.dart';
import '../shared/topbar.dart';

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  //String urlBase = 'backend-api.com';

  @override
  void initState() {}

  Future getReports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");
    var technician = await getTechnicianByUsername(username);
    var technicianData = json.decode(technician.body);

    var response =
        await getAllReportsByTechnicianId(technicianData["id"].toString());
    var reportsData = jsonDecode(response.body);
    print(reportsData.length);
    return reportsData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(title: "Reports"),
        bottomNavigationBar: TechNavBar(),
        body: SafeArea(
          minimum: EdgeInsets.only(left: 50.0, right: 50.0),
          child: FutureBuilder(
            future: getReports(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null || snapshot.data.length < 1) {
                return const Center(
                    child: Text("No reports available.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 25,
                        )));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        onTap: () {},
                        title: Text(
                          snapshot.data[index]["observation"],
                          style: const TextStyle(fontSize: 20),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data[index]["date"].toString(),
                              style: const TextStyle(
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.more),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReportDetailPage(
                                        snapshot.data[index],
                                        snapshot.data[index]["appointment"]["applianceModel"]
                                            ["urlToImage"])));
                          },
                        ),
                      ));
                    });
              }
            },
          ),
        ));
  }
}
