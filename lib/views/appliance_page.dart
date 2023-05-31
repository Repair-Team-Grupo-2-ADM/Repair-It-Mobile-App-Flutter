import 'package:flutter/material.dart';

class AppliancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 50.0,
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
                children: <Widget>[
                  _buildCard('Dry Machine', 'LG X9000',
                      'assets/washing_machine_lg.jpg', false, context),
                  _buildCard('Blender', 'Oster X',
                      'assets/blender_oster.jpg', false, context),
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildCard(
      String name, String model, String imgPath, bool added, context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {},
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  /*Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            isFavorite
                                ? Icon(Icons.favorite, color: Color(0xFFEF7532))
                                : Icon(Icons.favorite_border,
                                    color: Color(0xFFEF7532))
                          ])),*/
                  Hero(
                      tag: imgPath,
                      child: Container(
                          height: 75.0,
                          width: 75.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.contain)))),
                  SizedBox(height: 7.0),
                  Text(name,
                      style:
                          TextStyle(color: Color(0xFF575E67), fontSize: 14.0)),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                  Text(model,
                      style:
                          TextStyle(color: Color(0xFF575E67), fontSize: 14.0)),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                  Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (!added) ...[
                              /*Icon(Icons.shopping_basket,
                                  color: Color(0xFFD17E50), size: 12.0),*/
                              Text('Edit',
                                  style: TextStyle(
                                      /*fontFamily: 'Varela',
                                      color: Color(0xFFD17E50),*/
                                      fontSize: 8.0))
                            ],
                            if (added) ...[
                              Icon(Icons.remove_circle_outline,
                                  /*color: Color(0xFFD17E50),*/
                                  size: 12.0),
                              Text('3',
                                  style: TextStyle(
                                      fontFamily: 'Varela',
                                      /*color: Color(0xFFD17E50),*/
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0)),
                              Icon(Icons.add_circle_outline,
                                  /*color: Color(0xFFD17E50),*/
                                  size: 12.0),
                            ]
                          ]))
                ]))));
  }
}
