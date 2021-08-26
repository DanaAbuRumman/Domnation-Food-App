import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
   Timer:5;
    return Scaffold(
    
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Column(
              children: <Widget>[
                Text(
                  "Domnation Food",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Be The Reason Someone Smile Today",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )
              ],
            ),
            Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assests/welcome.jpg")))),
            Spacer()
          ],
        ),
      )),
    );
  }
}
