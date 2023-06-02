import 'package:flutter/material.dart';
import 'package:mobile_safetechnology/shared/topbar.dart';
import 'package:mobile_safetechnology/views/create_report.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/colorFromHex.dart';
import '../shared/techNavBar.dart';

class RouteDetailPage extends StatefulWidget {
  final route;

  RouteDetailPage(this.route);

  @override
  State<RouteDetailPage> createState() => _RouteDetailPage();
}

class _RouteDetailPage extends State<RouteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: "Route Detail"),
              bottomNavigationBar: TechNavBar(),
      body: ListView(
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  height: 50,
                  minWidth: 150,
                  color: Colors.lightBlueAccent,
                  textColor: Colors.white,
                  child: Text(
                    "Report",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateReportPage(
                                widget.route["id"],
                                widget.route["applianceModel"]["urlToImage"])));
                  },
                  splashColor: colorFromHex('053742'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                const SizedBox(
                  height: 10,
                  width: 25,
                ),
              ],
            ),
            margin: EdgeInsets.all(10.0),
          ),
          Container(
            child: Image.network(
              widget.route["applianceModel"]["urlToImage"].toString(),
              width: 150,
              height: 150,
            ),
            margin: EdgeInsets.all(10.0),
          ),
          Container(
            child: Text(
              "Fecha de Reserva: ${widget.route["dateReserve"]}",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            margin: EdgeInsets.all(10.0),
          ),
          Container(
            child: Text(
              "Fecha de Atención: ${widget.route["dateAttention"]}",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            margin: EdgeInsets.all(10.0),
          ),
          Container(
            child: Text(
              "Cliente: ${widget.route["client"]["names"]}",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            margin: EdgeInsets.all(10.0),
          ),
          Container(
            child: Text(
              "Dirección: ${widget.route["client"]["address"]}",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            margin: EdgeInsets.all(10.0),
          ),
          Container(
            child: Text(
              "Electrodoméstico: ${widget.route["applianceModel"]["name"]}",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            margin: EdgeInsets.all(10.0),
          ),
        ],
      ),
    );
  }
}
