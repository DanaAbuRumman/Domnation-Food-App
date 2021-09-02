import 'package:final_project/constant.dart';
import 'package:final_project/screens/auth/sign_up.dart';
import 'package:final_project/screens/user/home_page.dart';
import 'package:flutter/material.dart';

import 'forgot_password.dart';

class SignIn extends StatelessWidget {
  static const routeName = '/SignIn';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Login Page'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: getHeight(context) - 75,
          child: Column(
            children: <Widget>[
              Spacer(),
              Spacer(),
              Center(
                child: Image.asset(
                  'assests/Donate-Food.png',
                  height: getHeight(context) * 0.1,
                  width: getWidth(context) * 0.7,
                  fit: BoxFit.fill,
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ForgotPassword()));
                        },
                        child: Text(
                          "Forgot your password?",
                          style:
                              TextStyle(fontSize: 17, color: Colors.blue[800]),
                        ),
                      )
                    ],
                  )),
              Container(
                height: getHeight(context) * 0.06,
                width: getWidth(context) * 0.6,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: InkWell(
                    child: Text('New User? Create Account'),
                    onTap: () {
                      Navigator.of(context).pushNamed(SignUp.routeName);
                    }),
              ),
              Spacer(),
              Spacer(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
