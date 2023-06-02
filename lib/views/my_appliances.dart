import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_safetechnology/shared/clientNavBar.dart';
import 'package:mobile_safetechnology/views/appliance_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/colorFromHex.dart';
import '../shared/topbar.dart';

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

class MyAppliancesPage extends StatefulWidget {
  @override
  _MyAppliancesPageState createState() => _MyAppliancesPageState();
}

class _MyAppliancesPageState extends State<MyAppliancesPage>
    with SingleTickerProviderStateMixin {
  //String urlBase = 'backend-api.com';
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: TopBar(title: "My Appliances"),
      backgroundColor: colorFromHex("E8F0F2"),
      body: ListView(
        padding: EdgeInsets.only(left: 20.0),
        children: <Widget>[
          SizedBox(height: 15.0),
          /*Text('My Appliances',
              style: TextStyle(
                fontSize: 20.0,
              )),
          SizedBox(height: 15.0),*/
          TabBar(
              controller: _tabController,
              //indicatorColor: Colors.transparent,
              labelColor: Color.fromARGB(255, 0, 0, 0),
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 25.0),
              unselectedLabelColor: Color.fromARGB(255, 0, 0, 0),
              tabs: [
                Tab(
                    child: Text('My Appliances',
                        style: TextStyle(
                          fontSize: 15.0,
                        ))),
              ]),
          Container(
              height: MediaQuery.of(context).size.height - 10.0,
              width: double.infinity,
              child: TabBarView(controller: _tabController, children: [
                AppliancePage(),
              ]))
        ],
      ),
      bottomNavigationBar: ClientNavBar(),
    );
  }
}
/*
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_safetechnology/shared/clientNavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/colorFromHex.dart';
import '../shared/topbar.dart';

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

class MyAppliancesPage extends StatefulWidget {
  @override
  _MyAppliancesPageState createState() => _MyAppliancesPageState();
}

class _MyAppliancesPageState extends State<MyAppliancesPage> {
  //String urlBase = 'backend-api.com';

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: TopBar("My Appliances"),
      backgroundColor: colorFromHex("E8F0F2"),
      body: Text(
        "Appliances Page",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        textAlign: TextAlign.center,
      ),
      bottomNavigationBar: ClientNavBar(),
    );
  }
}

*/
/*import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_safetechnology/shared/clientNavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/colorFromHex.dart';
import '../shared/topbar.dart';

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

class MyAppliancesPage extends StatefulWidget {
  @override
  _MyAppliancesPageState createState() => _MyAppliancesPageState();
}

class _MyAppliancesPageState extends State<MyAppliancesPage> {
  //String urlBase = 'backend-api.com';

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: TopBar("My Appliances"),
      backgroundColor: colorFromHex("E8F0F2"),
      body: Text(
        "Appliances Page",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        textAlign: TextAlign.center,
      ),
      bottomNavigationBar: ClientNavBar(),
    );
  }
}
*/
/*
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_safetechnology/shared/clientNavBar.dart';
import 'package:mobile_safetechnology/shared/techNavBar.dart';
import 'package:mobile_safetechnology/views/report_detail.dart';
import 'package:mobile_safetechnology/views/appliance_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/colorFromHex.dart';
import '../shared/httpHelper.dart';
import '../shared/topbar.dart';

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

class MyAppliancesPage extends StatefulWidget {
  @override
  _MyAppliancesPageState createState() => _MyAppliancesPageState();
}

class _MyAppliancesPageState extends State<MyAppliancesPage> {
  //String urlBase = 'backend-api.com';

  @override
  void initState() {}

  @override
  Future getAppliances() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");
    var client = await getClientByUsername(username);
    var clientData = json.decode(client.body);

    var response =
        await getAllAppliancesByClientId(clientData["id"].toString());
    var appliancesData = jsonDecode(response.body);
    print(appliancesData.length);
    return appliancesData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar("Appliances"),
        bottomNavigationBar: ClientNavBar(),
        body: SafeArea(
          minimum: EdgeInsets.only(left: 50.0, right: 50.0),
          child: FutureBuilder(
            future: getAppliances(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null || snapshot.data.length < 1) {
                return const Center(
                    child: Text("No appliances available.",
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
                              snapshot.data[index]["name"].toString(),
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
                                    builder: (context) => ApplianceDetailPage(
                                        snapshot.data[index],
                                        snapshot.data[index]["name"]["model"]
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
*/