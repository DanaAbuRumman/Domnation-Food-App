import 'package:final_project/provider/farms.provider.dart';
import 'package:final_project/screens/user/all_farms/all_farm.dart';
import 'package:final_project/screens/user/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_farm.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  List<Widget>? page;
  int index = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    page = [AllFarm(), CreateFarm(), Profile()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: page!),
      bottomNavigationBar: BottomNavigationBar(
        key: _bottomNavigationKey,
        // backgroundColor: Helper.PrimaryColor,
        fixedColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        // selectedItemColor: Helper.PrimaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create Farm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervisor_account),
            label: 'Profile',
          ),
        ],
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
