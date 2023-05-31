import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/colorFromHex.dart';

class RecoveryPasswordPage extends StatefulWidget {
  @override
  _RecoveryPasswordPageState createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  //String urlBase = 'backend-api.com';

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(
                height: 40,
              ),
              const Text(
                "Safe Technology",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.80,
                decoration: BoxDecoration(
                  color: colorFromHex('A2DBFA'),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      bottomRight: Radius.zero,
                      topLeft: Radius.circular(15.0),
                      bottomLeft: Radius.zero),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                    ),
                    const Text(
                      "Recover Password",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Form(
                      child: Theme(
                        data: ThemeData(
                            brightness: Brightness.light,
                            primarySwatch: Colors.indigo,
                            inputDecorationTheme: const InputDecorationTheme(
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 20))),
                        child: Container(
                          padding: EdgeInsets.all(18),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.email),
                                    labelText: "Email"),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                      height: 30,
                    ),
                              MaterialButton(
                                height: 60,
                                minWidth: 250,
                                color: colorFromHex('053742'),
                                textColor: Colors.white,
                                child: Text(
                                  "Send Link",
                                  style: TextStyle(
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed("/login");
                                },
                                splashColor: colorFromHex('053742'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
