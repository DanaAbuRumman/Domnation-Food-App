import 'package:flutter/material.dart';

class AuthScreeen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient:   LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188 , 117 , 1).withOpacity(0.9),
                ]
                )
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 94),
                    child: (Text("Log In",
                    style: TextStyle(
                    color: Colors.white ,
                    fontSize: 25,
                

                    ),)
                  
                    )
                  )
                  ),
                ],
              ),

            ),
          )
        ],
      ),
    );
  }
}
