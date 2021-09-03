import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
import 'opt_code.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  bool _load = false;
  String error = "";
  var phoneKey = GlobalKey<FormState>();
  var phoneNumber = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> sendCode() async {
    await firebaseAuth
        .verifyPhoneNumber(
            phoneNumber: "+962${phoneNumber.text}",
            timeout: Duration(seconds: 120),
            verificationCompleted: (AuthCredential authCredential) {
              setState(() {
                _load = false;
              });
            },
            verificationFailed: (FirebaseAuthException authException) {
              print(authException.message);
              setState(() {
                error = "This phone is not valid";
                _load = false;
              });
            },
            codeSent: (String verificationId, [int? forceResendingToken]) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => OPTCode(
                        phone: "+962${phoneNumber.text}",
                        code: verificationId,
                      )));
              print("send");

              setState(() {
                _load = false;
              });
            },
            codeAutoRetrievalTimeout: (String verificationId) {
              print(verificationId);
              error = "";
              setState(() {
                _load = false;
              });
            })
        .catchError((e) {
      setState(() {
        _load = false;
      });
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Form(
            key: phoneKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: getHeight(context) * 0.15,
                    ),
                    Image.asset(
                      "assests/Donate-Food.png",
                      height: getWidth(context) * 0.5,
                      width: getWidth(context) * 0.5,
                    ),
                    SizedBox(
                      height: getHeight(context) * 0.05,
                    ),
                    Row(
                      children: [
                        Text(
                          "Please, enter your phone: ",
                          style: TextStyle(
                              fontSize: getWidth(context) * 0.05,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(context) * 0.03,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      maxLength: 9,
                      validator: (value) {
                        if (value!.isEmpty) return "Enter your phone";
                        if (value.length < 9) return "Phone is too short";

                        return null;
                      },
                      controller: phoneNumber,
                      decoration: InputDecoration(
                        prefixText: "+962",
                        labelText: "Phone",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                    if (error != "")
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          width: getWidth(context),
                          child: Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: getHeight(context) * 0.05,
                    ),
                    ElevatedButton(
                        onPressed: _load
                            ? null
                            : () {
                                if (phoneKey.currentState!.validate()) {
                                  setState(() {
                                    _load = true;
                                  });
                                  sendCode();
                                }
                              },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                        child: SizedBox(
                          height: 50,
                          width: getWidth(context) * 0.60,
                          child: Center(
                            child: Text(
                              "Send Code",
                              style: TextStyle(
                                fontSize: getWidth(context) * 0.043,
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: getWidth(context) * 0.1,
                    ),
                  ],
                ),
              ),
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
  }
}
