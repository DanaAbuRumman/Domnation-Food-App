import 'package:final_project/provider/farms.provider.dart';
import 'package:final_project/screens/auth/splash_screen.dart';
import 'package:final_project/screens/user/home_page.dart';
import 'package:final_project/screens/user/my_farms.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth/phone_number.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  int reloadNumber = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx) => FarmsProvider(),
        child: Consumer<FarmsProvider>(builder:
            (BuildContext context, FarmsProvider userProvider, Widget? child) {
          if (userProvider.getPhone() == null) {
            reloadNumber++;
          }
          return MaterialApp(
            key: Key("$reloadNumber"),
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.

              primarySwatch: Colors.blue,
            ),
            routes: {
              '/PhoneAuth': (_) => PhoneAuth(),
              '/HomePage': (_) => HomePage(),
              '/MyFarms': (_) => MyFarms()
            },
            home: SplashScreen(),
          );
        }));
  }
}
