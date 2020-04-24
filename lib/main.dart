import 'package:flutter/material.dart';
import 'signup.dart';
import 'mainpage.dart';
import 'nxt1.dart';
import 'ntx2.dart';
import 'nxt3.dart';
import 'drawer.dart';
import 'draw/blog.dart';
import 'draw/questionans.dart';
import 'draw/homered.dart';
import 'draw/myredemi.dart';
import 'draw/grid.dart';
import 'draw/sidd.dart';
import 'splash_screen.dart';
import 'draw/siddremedi.dart';
void main() => runApp(MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/main': (BuildContext conttext) => MyApp(),
          '/signup': (BuildContext context) => Signup(),
          '/nxt':(BuildContext context)=>Nxt(),
          '/myred':(BuildContext context)=>Myred(),
          '/homered':(BuildContext context)=>Homered(),
          '/blog':(BuildContext context)=>Blog(),
          '/ques':(BuildContext context)=>Ques(),
          '/draw':(BuildContext context)=>Drawerr(),
          '/sid':(BuildContext context)=>Myreda(),
          '/sidrem':(BuildContext context)=>Sidrem(),

        }));
