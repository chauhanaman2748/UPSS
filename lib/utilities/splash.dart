import 'dart:async';
import 'package:urbanparivarsevasamiti/screens/home_screen.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  bool isLogin = false;

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), () =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen())));
  }


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
              height: 3000,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 10,
                    left: 20,
                    width: 300,
                    height: 250,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/2_logo.png')
                          )
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 25,
                    width: 300,
                    height: 700,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/lady.jpeg')
                          )
                      ),
                    ),
                  ),
                  Positioned(
                    top:20,
                    height: 1100,
                    left: 80,
                    width: 200,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/MIN2.png')
                          )
                      ),
                    ),
                  ),
                  Positioned(
                    top:20,
                    height: 1300,
                    left: 80,
                    width: 200,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/MIN.png')
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
    );
  }
}