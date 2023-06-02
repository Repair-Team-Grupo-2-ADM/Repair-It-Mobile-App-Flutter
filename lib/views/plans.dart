import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_safetechnology/shared/clientNavBar.dart';
import 'package:mobile_safetechnology/shared/topbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/colorFromHex.dart';
import '../shared/httpHelper.dart';
import '../shared/techNavBar.dart';
import '../shared/toast.dart';

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

class PlansPage extends StatefulWidget {
  @override
  _PlansPageState createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  //String urlBase = 'backend-api.com';
  var userPlan = "Basic";
  int _upgradeStep = 1;
  String _planToUpgradeTo = "Basic";
  var appointmentsCount = 0;
  var user = {};
  String? userType;
  final TextEditingController ownernameController = TextEditingController();
  final TextEditingController cardnumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController expirydateController = TextEditingController();

  void getUserData() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    String? username = userPref.getString("username");
    setState(() {
      userType = userPref.getString("userType");
    });
    print(username);
    print(userType);
    if (username != null) {
      if (userType == "ROLE_CLIENT") {
        getClientByUsername(username).then((data) async => {
              user = json.decode(data.body),
              await getAppointmentsCount(user["id"]),
              setState(() {
                userPlan = user["planType"];
              })
            });
      } else {
        getTechnicianByUsername(username).then((data) async => {
              user = json.decode(data.body),
              await getAppointmentsCount(user["id"]),
              setState(() {
                userPlan = "Basic";
                appointmentsCount = 0;
              })
            });
      }
    }
  }

  Future<int> getAppointmentsCount(userId) async {
    var data = await getAppointmentsByUserId(userId);
    var appointments = json.decode(data.body);
    setState(() {
      print(appointments.length);
      appointmentsCount = appointments.length;
    });
    return appointments.length;
  }

  @override
  void initState() {
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: TopBar(title: "Plans"),
      backgroundColor: colorFromHex("E8F0F2"),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Visibility(
                visible: _upgradeStep == 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Row(
                              children: [
                                SizedBox(width: 20),
                                MaterialButton(
                                  height: 100,
                                  minWidth: 175,
                                  color: colorFromHex('053742'),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Plan " + userPlan,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {},
                                  splashColor: colorFromHex('053742'),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                SizedBox(width: 20),
                                MaterialButton(
                                  height: 100,
                                  minWidth: 125,
                                  color: colorFromHex('053742'),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Upgrade",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _upgradeStep = 2;
                                    });
                                  },
                                  splashColor: colorFromHex('053742'),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 50),
                          Text(
                            "Total Appointments: ",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 20),
                          Text(
                            appointmentsCount.toString(),
                            style: TextStyle(fontSize: 25),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                  visible: _upgradeStep == 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      MaterialButton(
                        height: 125,
                        minWidth: 300,
                        color: colorFromHex('053742'),
                        textColor: Colors.white,
                        // ignore: sort_child_properties_last
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Basic",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "\$10.00 a month",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            _upgradeStep = 3;
                            _planToUpgradeTo = "Basic";
                          });
                        },
                        splashColor: colorFromHex('053742'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        height: 125,
                        minWidth: 300,
                        color: colorFromHex('053742'),
                        textColor: Colors.white,
                        // ignore: sort_child_properties_last
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Plus",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "\$20.00 a month",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            _upgradeStep = 3;
                            _planToUpgradeTo = "Plus";
                          });
                        },
                        splashColor: colorFromHex('053742'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        height: 125,
                        minWidth: 300,
                        color: colorFromHex('053742'),
                        textColor: Colors.white,
                        // ignore: sort_child_properties_last
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Plus Ultra",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "\$30.00 a month",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            _upgradeStep = 3;
                            _planToUpgradeTo = "Plus Ultra";
                          });
                        },
                        splashColor: colorFromHex('053742'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ],
                  )),
              Visibility(
                  visible: _upgradeStep == 3,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(height: 100),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                child: Row(
                                  children: [
                                    MaterialButton(
                                      height: 100,
                                      minWidth: 150,
                                      color: colorFromHex('053742'),
                                      textColor: Colors.white,
                                      child: Text(
                                        "Mastercard",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {},
                                      splashColor: colorFromHex('053742'),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    MaterialButton(
                                      height: 100,
                                      minWidth: 150,
                                      color: colorFromHex('053742'),
                                      textColor: Colors.white,
                                      child: Text(
                                        "Visa",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          //_upgradeStep = 2;
                                        });
                                      },
                                      splashColor: colorFromHex('053742'),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width: 120,
                                        child: const Text(
                                          "Owner Name",
                                          style: TextStyle(fontSize: 20),
                                        )),
                                    SizedBox(width: 30),
                                    Expanded(
                                        child: TextFormField(
                                      controller: ownernameController,
                                    )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width: 120,
                                        child: const Text(
                                          "Card Number",
                                          style: TextStyle(fontSize: 20),
                                        )),
                                    SizedBox(width: 30),
                                    Expanded(
                                        child: TextFormField(
                                      controller: cardnumberController,
                                    )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width: 120,
                                        child: const Text(
                                          "CVV",
                                          style: TextStyle(fontSize: 20),
                                        )),
                                    SizedBox(width: 30),
                                    Expanded(
                                        child: TextFormField(
                                      controller: cvvController,
                                    )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width: 120,
                                        child: const Text(
                                          "Expiry Date",
                                          style: TextStyle(fontSize: 20),
                                        )),
                                    SizedBox(width: 30),
                                    Expanded(
                                        child: TextFormField(
                                      controller: expirydateController,
                                    )),
                                  ],
                                ),
                              ),
                              MaterialButton(
                                height: 50,
                                minWidth: 225,
                                color: colorFromHex('053742'),
                                textColor: Colors.white,
                                child: Text(
                                  "Pay",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  updateClientPlan(_planToUpgradeTo)
                                      .then((response) => {
                                            if (response.statusCode == 200)
                                              {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content:
                                                      Text("Plan updated!"),
                                                )),
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        "/plans")
                                              }
                                          });
                                },
                                splashColor: colorFromHex('053742'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )))
            ],
          )),
      bottomNavigationBar:
          userType == "ROLE_CLIENT" ? ClientNavBar() : TechNavBar(),
    );
  }
}
