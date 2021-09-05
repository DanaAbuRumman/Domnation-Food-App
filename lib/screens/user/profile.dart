import 'package:final_project/provider/farms.provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assests/logo.JPG"),
                      fit: BoxFit.cover))),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Text(
                  "Vacation mood",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              "My Farms",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            ),
            leading: Icon(
              Icons.home,
              size: 30,
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),
          ListTile(
            title: Text(
              "About app",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            ),
            leading: Icon(
              Icons.info,
              size: 30,
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                print("1");
                Provider.of<FarmsProvider>(context, listen: false).addPhone("");
              });
            },
            title: Text(
              "Sign out",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            ),
            leading: Icon(
              Icons.logout,
              size: 30,
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }
}
