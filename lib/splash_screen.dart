import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter_appaa/mainpage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();

    _justCheck().then(
      (status){
        if(status){
          _navigateboy();
        }
        else{
          _navigateboy();
        }
      }
    );
  }

  Future<bool> _justCheck() async{
    await Future.delayed(Duration(milliseconds: 3000),(){});
    return true;
  }

  void _navigateboy(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context)=>MyApp()
      )
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/zedd2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Shimmer.fromColors(
              period: Duration(milliseconds: 1500),
              baseColor: Colors.blueAccent,
              highlightColor: Colors.white,
              child: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child:Text(
                  "Sana",
                  style: TextStyle(
                    fontSize: 120.0,
                    fontFamily: "Pacifico",
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 18.0,
                        color: Colors.black87,
                        offset: Offset.fromDirection(120,12)
                      )
                    ]
                  ),
                )
              ))),
    );
  }
}
