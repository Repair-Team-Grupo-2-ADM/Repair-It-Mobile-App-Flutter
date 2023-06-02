import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_safetechnology/shared/clientNavBar.dart';
import 'package:mobile_safetechnology/shared/techNavBar.dart';
import 'package:mobile_safetechnology/views/route_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/colorFromHex.dart';
import '../shared/httpHelper.dart';
import '../shared/topbar.dart';

class RoutesPage extends StatefulWidget {
  @override
  _RoutesPageState createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  //String urlBase = 'backend-api.com';

  @override
  void initState() {}

  Future getRoutes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");
    var technician = await getTechnicianByUsername(username);
    var technicianData = json.decode(technician.body);
    print("Tech id: " + technicianData["id"].toString());

    var response = await getAllAppointmentsByTechnicianId(technicianData["id"].toString());
    var reportsData = jsonDecode(response.body);
    print(reportsData.length);
    return reportsData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(title: "Routes"),
        bottomNavigationBar: TechNavBar(),
        body: SafeArea(
                    minimum: EdgeInsets.only(left: 50.0, right: 50.0),
          child: FutureBuilder(
            future: getRoutes(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null || snapshot.data.length < 1) {
                return const Center(
                    child: Text("No routes available.",
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
                          snapshot.data[index]["applianceModel"]["name"].toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          snapshot.data[index]["dateReserve"].toString() + " to " + snapshot.data[index]["dateAttention"].toString(),
                          style: const TextStyle(
                              color: Colors.lightBlueAccent),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.forward),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RouteDetailPage(snapshot.data[index])));
                          },
                        ),
                      ));
                    });
              }
            },
          ),
        ));
  }
/*
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: TopBar("Routes"),
      backgroundColor: colorFromHex("E8F0F2"),
      body: Text(
        "My Routes",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        textAlign: TextAlign.center,
      ),
      bottomNavigationBar: TechNavBar(),
    );
  }*/
}
