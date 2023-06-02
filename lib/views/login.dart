// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:convert';
import 'dart:io';
//import 'dart:js_interop';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_safetechnology/shared/colorFromHex.dart';
import 'package:mobile_safetechnology/views/appliance_page.dart';
import 'package:mobile_safetechnology/views/my_appliances.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/httpHelper.dart';
import '../shared/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  //String urlBase = 'backend-api.com';

  /*void checkLogin() async {
    /*
    SharedPreferences userPref = await SharedPreferences.getInstance();
    String? user = userPref.getString("email");

    if(user != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PublicOffices()), (route) => false);
    }*/

    Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MyAppliancesPage()), (route) => false);
  }*/

  @override
  void initState() {
    //checkLogin();
  }

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
                "Repair It",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.80,
                decoration: BoxDecoration(
                  color: colorFromHex('#2196F3'),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      bottomRight: Radius.zero,
                      topLeft: Radius.circular(15.0),
                      bottomLeft: Radius.zero),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Login",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
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
                                    labelText: "Username"),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const Padding(padding: EdgeInsets.all(5)),
                              TextFormField(
                                controller: passController,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.vpn_key),
                                    labelText: "Password",
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                      icon: Icon(Icons.visibility),
                                    )),
                                keyboardType: TextInputType.text,
                                obscureText: !_passwordVisible,
                              ),
                              const Padding(padding: EdgeInsets.only(top: 25)),
                              MaterialButton(
                                height: 50,
                                minWidth: 225,
                                color: colorFromHex('053742'),
                                textColor: Colors.white,
                                child: Text(
                                  "Go!",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  if((passController.text != '') && (emailController.text != '')){
                                    Navigator.of(context).pushReplacementNamed('/appliances');
                                  }
                                  else {
                                    displayToast('Por favor ingrese sus datos');
                                  }
/*
                                  var isLogedIn = await login(
                                      emailController.text,
                                      passController.text);
                                  if (isLogedIn.statusCode == 200) {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    String? userType =
                                        prefs.getString("userType");
                                    if (userType == "ROLE_CLIENT")
                                      Navigator.of(context)
                                          .pushReplacementNamed("/appliances");
                                    else
                                      Navigator.of(context)
                                          .pushReplacementNamed("/routes");
                                  }*/
                                },
                                splashColor: colorFromHex('053742'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 20)),
                              MaterialButton(
                                height: 40,
                                minWidth: 200,
                                color: Colors.white,
                                textColor: Colors.black,
                                child: Text(
                                  "Login with Facebook",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {},
                                splashColor: colorFromHex('053742'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 8)),
                              MaterialButton(
                                height: 40,
                                minWidth: 200,
                                color: Colors.white,
                                textColor: Colors.black,
                                child: const Text(
                                  "Login with Google",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {},
                                splashColor: Colors.indigoAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 25)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Don't have an account?"),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed("/signup");
                                      //Navigator.of(context).pushNamed('/signup');
                                    },
                                    child: Text(
                                      " Signup here!",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              "/recovery_password");
                                      //Navigator.of(context).pushNamed('/signup');
                                    },
                                    child: Text(
                                      "Forgot password?",
                                    ),
                                  )
                                ],
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
