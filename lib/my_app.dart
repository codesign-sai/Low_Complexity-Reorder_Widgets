import 'package:flutter/material.dart';

import 'package:low_complexity/new_home.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      //home: MyHomePage(title: 'Low Complexity - Reorder Widgets'),
      home: NewHome(),
    );
  }
}
