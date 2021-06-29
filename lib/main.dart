import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'package:michi_manager/viewHome.dart';

void main() {
  /*runApp(
    MaterialApp(
      title: 'Maneja tus Michis',
      theme: ThemeData(primarySwatch: Colors.lightBlue, fontFamily: 'Nunito'),
      darkTheme: ThemeData.dark(),
      home:LoginScreen(),
    )

  );*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maneja tus Michis',
      theme: ThemeData(primarySwatch: Colors.lightBlue, fontFamily: 'Nunito'),
      darkTheme: ThemeData.dark(),
      home: LoginScreen(),
    );
  }
}





