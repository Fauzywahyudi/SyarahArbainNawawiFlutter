import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {




  @override
  void initState() {
//    Timer(
//        Duration(seconds: 4),
//            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
//            builder: (BuildContext context) => isNew == true
//                ? new createName()
//                : havePass == true && isStatus == false
//                ? new inputPassword()
//                : new MyHomePage())));
    super.initState();
  }

  TextStyle judul = new TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.blueAccent,
    fontSize: 40,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Text(
                    "My Finance",
                    style: judul,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
