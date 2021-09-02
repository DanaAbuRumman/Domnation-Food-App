import 'dart:async';

import 'package:final_project/screens/auth/sign_in.dart';
import 'package:flutter/material.dart';

import 'phone_number.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  int _start = 5;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 1) {
          setState(() {
            timer.cancel();
          });
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => PhoneAuth()), (route) => false);
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text("$_start")],
            ),
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
