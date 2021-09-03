import 'dart:async';

import 'package:final_project/screens/user/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../../constant.dart';

class OPTCode extends StatefulWidget {
  String phone;
  String? code;
  OPTCode({Key? key, required this.phone, this.code}) : super(key: key);

  @override
  _OPTCodeState createState() => _OPTCodeState();
}

class _OPTCodeState extends State<OPTCode> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String error = "";
  String? validationCode;
  var signInKey = GlobalKey<FormState>();
  late Timer _timer;
  int start = 120;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
          Navigator.of(context).pop();
        } else {
          start--;
        }
      },
    );
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(5.0),
    );
  }

  bool _load = false;
  void valid() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    AuthCredential _credential = PhoneAuthProvider.credential(
        verificationId: widget.code!, smsCode: validationCode!);
    await auth.signInWithCredential(_credential).then((result) async {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/HomePage', (route) => false);
    }).catchError((e) {
      setState(() {
        _load = false;
      });
      print("error");
      error = "The verification code is invalid";
      print(e);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Stack(
            children: [
              Form(
                key: signInKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: getWidth(context) * 0.1,
                    ),
                    Image.asset(
                      "images/label.png",
                      height: getWidth(context) * 0.5,
                      width: getWidth(context) * 0.5,
                    ),
                    SizedBox(
                      height: getWidth(context) * 0.1,
                    ),
                    Text(
                      "OPT Code",
                      style: TextStyle(
                          fontSize: getWidth(context) * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: getWidth(context) * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Please, enter code that sent to your phone.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getWidth(context) * 0.037,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20.0),
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: PinPut(
                        eachFieldWidth: getWidth(context) * 0.1,
                        fieldsCount: 6,
                        validator: (value) {
                          if (value!.isEmpty) return "Enter OPT code";
                          if (value.length < 6)
                            return "OPT code should equal 6";
                        },
                        onChanged: (value) {
                          validationCode = value;
                        },
                        eachFieldHeight: getWidth(context) * 0.13,
                        onSubmit: (String pin) {
                          validationCode = pin;
                        },
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                        submittedFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        selectedFieldDecoration: _pinPutDecoration,
                        followingFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getWidth(context) * 0.1,
                    ),
                    ElevatedButton(
                        onPressed: _load
                            ? null
                            : () {
                                setState(() {
                                  _load = true;
                                });
                                valid();
                              },
                        child: SizedBox(
                          height: 50,
                          width: getWidth(context) * 0.60,
                          child: Center(
                            child: Text(
                              "Verfy",
                              style: TextStyle(
                                fontSize: getWidth(context) * 0.04,
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              if (_load)
                Container(
                  height: getHeight(context),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
