import 'package:flutter/material.dart';
import 'package:urbanparivarsevasamiti/utilities/splash.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Urban Parivar Seva Samiti',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.black,
          buttonColor: Colors.black,
          primaryIconTheme: IconThemeData(color: Colors.black),
          primaryTextTheme: TextTheme(
              body1: TextStyle(color: Colors.black, fontFamily: "Aveny")),
          textTheme: TextTheme(body1: TextStyle(color: Colors.black))),
      home: new Splash(),
    );
  }
}