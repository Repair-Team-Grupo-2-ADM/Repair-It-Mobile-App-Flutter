import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_safetechnology/model/client.dart';
import 'package:mobile_safetechnology/shared/clientNavBar.dart';
import 'package:mobile_safetechnology/shared/techNavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/colorFromHex.dart';
import '../shared/httpHelper.dart';
import '../shared/topbar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //String urlBase = 'backend-api.com';

  bool _isEditing = false;
  String? userType;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cellphoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPassController = TextEditingController();

  void setEditing(bool value) {
    setState(() {
      _isEditing = value;
    });
  }

  void getUserData() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    String? username = userPref.getString("username");
    setState(() {
      userType = userPref.getString("userType");
    });
    print(username);
    if (username != null) {
      if (userType == "ROLE_CLIENT") {
        getClientByUsername(username).then((data) => {
              print(json.decode(data.body)),
              initControllerValues(json.decode(data.body))
            });
      } else {
        getTechnicianByUsername(username).then((data) => {
              print(json.decode(data.body)),
              initControllerValues(json.decode(data.body))
            });
      }
    }
  }

  void initControllerValues(data) {
    emailController.text = data["email"];
    firstnameController.text = data["names"];
    lastnameController.text = data["lastNames"];
    addressController.text = data["address"];
    cellphoneController.text = data["cellPhoneNumber"];
    passwordController.text = data["password"];
    repeatPassController.text = data["password"];
  }

  @override
  void initState() {
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: TopBar("Profile"),
      backgroundColor: colorFromHex("E8F0F2"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Row(
              children: [
                SizedBox(
                    width: 120,
                    child: const Text(
                      "Email",
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(width: 30),
                Expanded(
                    child: TextFormField(
                  enabled: _isEditing,
                  controller: emailController,
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Row(
              children: [
                SizedBox(
                    width: 120,
                    child: const Text(
                      "First Name",
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(width: 30),
                Expanded(
                    child: TextFormField(
                  enabled: _isEditing,
                  controller: firstnameController,
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Row(
              children: [
                SizedBox(
                    width: 120,
                    child: const Text(
                      "Last Name",
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(width: 30),
                Expanded(
                    child: TextFormField(
                  enabled: _isEditing,
                  controller: lastnameController,
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Row(
              children: [
                SizedBox(
                    width: 120,
                    child: const Text(
                      "Address",
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(width: 30),
                Expanded(
                    child: TextFormField(
                  enabled: _isEditing,
                  controller: addressController,
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Row(
              children: [
                SizedBox(
                    width: 120,
                    child: const Text(
                      "Phone Number",
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(width: 30),
                Expanded(
                    child: TextFormField(
                  enabled: _isEditing,
                  controller: cellphoneController,
                )),
              ],
            ),
          ),
          Visibility(
            visible: _isEditing,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Row(
                children: [
                  SizedBox(
                      width: 120,
                      child: const Text(
                        "Password",
                        style: TextStyle(fontSize: 20),
                      )),
                  SizedBox(width: 30),
                  Expanded(
                      child: TextFormField(
                    obscureText: true,
                    enabled: _isEditing,
                    controller: passwordController,
                  )),
                ],
              ),
            ),
          ),
          Visibility(
            visible: _isEditing,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Row(
                children: [
                  SizedBox(
                      width: 120,
                      child: const Text(
                        "Repeat Password",
                        style: TextStyle(fontSize: 20),
                      )),
                  SizedBox(width: 30),
                  Expanded(
                      child: TextFormField(
                    obscureText: true,
                    enabled: _isEditing,
                    controller: repeatPassController,
                  )),
                ],
              ),
            ),
          ),
          Visibility(
            visible: !_isEditing,
            child: MaterialButton(
              height: 50,
              minWidth: 225,
              color: colorFromHex('053742'),
              textColor: Colors.white,
              child: Text(
                "Edit",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                setEditing(true);
              },
              splashColor: colorFromHex('053742'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
          Visibility(
            visible: _isEditing,
            child: MaterialButton(
              height: 50,
              minWidth: 225,
              color: colorFromHex('053742'),
              textColor: Colors.white,
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                await updateClient(
                    emailController.text,
                    firstnameController.text,
                    lastnameController.text,
                    addressController.text,
                    passwordController.text,
                    cellphoneController.text);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Account updated!"),
                ));
                setEditing(false);
              },
              splashColor: colorFromHex('053742'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: userType == "ROLE_CLIENT"
          ? ClientNavBar()
          : TechNavBar(),
    );
  }
}
