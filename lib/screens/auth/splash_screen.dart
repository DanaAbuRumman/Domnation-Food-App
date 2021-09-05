import 'dart:async';

import 'package:final_project/provider/farms.provider.dart';
import 'package:final_project/screens/user/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Provider.of<FarmsProvider>(context, listen: false).initFarms();
    const oneSec = const Duration(seconds: 1);

    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 1) {
          setState(() {
            timer.cancel();
          });
          if (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.phoneNumber != null)
            Provider.of<FarmsProvider>(context, listen: false)
                .addPhone(FirebaseAuth.instance.currentUser!.phoneNumber!);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (_) => FirebaseAuth.instance.currentUser != null
                      ? HomePage()
                      : PhoneAuth()),
              (route) => false);
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
          child: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assests/logo.JPG"),
                      fit: BoxFit.cover))),
          Container(
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
                    Container(
                        height: MediaQuery.of(context).size.height / 2,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assests/logo.JPG")))),
                    Text(
                      "Vacation mood",
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
                Spacer()
              ],
            ),
          ),
        ],
      )),
    );
  }
}
