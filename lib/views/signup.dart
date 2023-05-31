import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_safetechnology/model/user.dart';
import 'package:mobile_safetechnology/views/my_appliances.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/colorFromHex.dart';
import '../shared/httpHelper.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _passwordVisible = false;
  List<bool> selections = [false, false];
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController namesController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController repeatPassController = TextEditingController();
  //String urlBase = 'backend-api.com';

  void signupAndCreateClient() async {
    var userType = selections[0] == true ? "ROLE_CLIENT": "ROLE_TECHNICIAN";
    var signUpResponse = await signupUser(
        emailController.text, usernameController.text, passController.text, userType);
    if (signUpResponse.statusCode == 200) {
      var createResponse;
      await login(usernameController.text, passController.text);
      if (selections[0] == true) {
        createResponse = await createClient(
            emailController.text,
            usernameController.text,
            namesController.text,
            namesController.text,
            addressController.text,
            passController.text,
            telephoneController.text,
            "Basic");
      } else {
        createResponse = await createTechnician(
            emailController.text,
            usernameController.text,
            namesController.text,
            namesController.text,
            addressController.text,
            passController.text,
            telephoneController.text);
      }
      print(createResponse.statusCode);
      if (createResponse.statusCode == 200) {
        // ignore: use_build_context_synchronously
        if (userType == "ROLE_CLIENT") Navigator.of(context).pushReplacementNamed("/appliances");
        else Navigator.of(context).pushReplacementNamed("/routes");
      }
    }
  }

  void checkLogin() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    String? token = userPref.getString("token");

    if (token != null) {
      Navigator.of(context).pushReplacementNamed("/appliances");
    }
  }

  @override
  void initState() {
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(children: [
            SizedBox(
              height: 50,
            ),
            const Text(
              "Safe Technology",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: colorFromHex('A2DBFA'),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      bottomRight: Radius.zero,
                      topLeft: Radius.circular(15.0),
                      bottomLeft: Radius.zero),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Signup",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                    ),
                    Form(
                      child: Theme(
                        data: ThemeData(
                            brightness: Brightness.light,
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
                                    hoverColor: Colors.white,
                                    labelText: "Email"),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const Padding(padding: EdgeInsets.all(5)),
                              TextFormField(
                                controller: usernameController,
                                decoration: const InputDecoration(
                                    hoverColor: Colors.white,
                                    labelText: "Username"),
                              ),
                              const Padding(padding: EdgeInsets.all(5)),
                              TextFormField(
                                controller: namesController,
                                decoration:
                                    const InputDecoration(labelText: "Names"),
                                keyboardType: TextInputType.name,
                              ),
                              const Padding(padding: EdgeInsets.all(5)),
                              TextFormField(
                                controller: addressController,
                                decoration:
                                    const InputDecoration(labelText: "Address"),
                                keyboardType: TextInputType.streetAddress,
                              ),
                              const Padding(padding: EdgeInsets.all(5)),
                              TextFormField(
                                controller: telephoneController,
                                decoration: const InputDecoration(
                                    labelText: "Telephone"),
                                keyboardType: TextInputType.phone,
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
                              const Padding(padding: EdgeInsets.only(top: 15)),
                              TextFormField(
                                controller: repeatPassController,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.vpn_key),
                                    labelText: "Repeat Password",
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
                              SizedBox(height: 10),
                              ToggleButtons(
                                  children: [
                                    Text(
                                      "Client",
                                    ),
                                    Text(
                                      "Technician",
                                    ),
                                  ],
                                  onPressed: (int index) => {
                                        setState(
                                          () {
                                            selections[index] =
                                                !selections[index];
                                            for (var i = 0; i < 2; i++) {
                                              if (i != index)
                                                selections[i] = false;
                                            }
                                            print(selections);
                                          },
                                        )
                                      },
                                  borderRadius: BorderRadius.circular(10),
                                  borderWidth: 2,
                                  selectedColor: Colors.blue,
                                  selectedBorderColor: Colors.lightBlue,
                                  splashColor: Color.fromARGB(255, 0, 94, 255),
                                  isSelected: selections),
                              const Padding(padding: EdgeInsets.only(top: 15)),
                              MaterialButton(
                                height: 50,
                                minWidth: 150,
                                color: colorFromHex('053742'),
                                textColor: Colors.white,
                                child: Text(
                                  "Go!",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  signupAndCreateClient();
                                },
                                splashColor: colorFromHex('053742'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed("/login");
                                      //Navigator.of(context).pushNamed('/signup');
                                    },
                                    child: Text(
                                      "Already have an account? Login here!",
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
            )
          ]),
        ],
      ),
    );
  }
}
