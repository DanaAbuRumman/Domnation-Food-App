import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int _currentIndex = 0;

  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold();
  }
}
