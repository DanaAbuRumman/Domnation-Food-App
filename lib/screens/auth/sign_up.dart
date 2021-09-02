import 'package:final_project/constant.dart';
import 'package:final_project/widgets.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/SignUp';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formGlobalKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var name = TextEditingController();

  var password = TextEditingController();
  var conPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign up Page'),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: getHeight(context),
            child: Column(children: [
              Container(
                height: 150.0,
                width: 190.0,
                padding: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Center(),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: formGlobalKey,
                    child: Column(children: [
                      const SizedBox(height: 50),
                      textFiled(
                        controller: email,
                        label: "Email",
                        function: (email) {
                          if (isEmailValid(email))
                            return null;
                          else
                            return 'Enter a valid email address';
                        },
                      ),
                      textFiled(
                        controller: name,
                        label: "Name",
                        function: (text) {
                          if (text.isEmpty) return "Name can't be empty";
                          if (text.length < 3) return "Name is too short!";
                        },
                      ),
                      textFiled(
                        controller: password,
                        label: "Password",
                        isPassword: true,
                        function: (text) {
                          if (text.isEmpty) return "Password can't be empty";
                          if (text.length < 4) return "Password is too short!";
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'confirm password',
                              hintText: 'Enter your password'),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        child: ElevatedButton(
                          onPressed: () {
                            if (formGlobalKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Registerd')),
                              );
                            }
                          },
                          child: const Text('Register Now'),
                        ),
                      ),
                    ]),
                  ))
            ]),
          ),
        ));
  }

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  bool isPasswordValid(String password) => password.length == 6;
}
