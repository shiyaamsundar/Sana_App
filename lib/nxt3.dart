import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Nxt3 extends StatefulWidget {
  @override
  _Nxt3State createState() => _Nxt3State();
}

class _Nxt3State extends State<Nxt3> {

  Future<File> imageFile;
  String username,fname,lname,email,phone;
  DateTime _datetime;
  File _image;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text('aa'),
),
  body: ListView(
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        height: 350,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
          child: Column(
            children: <Widget>[
              TextField(

                decoration: InputDecoration(
                    hintText: "Firstname",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                onChanged: (value) {
                  setState(() {
                    fname = value;
                  });
                },
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              TextField(

                decoration: InputDecoration(
                    hintText: "Lastname",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                onChanged: (value) {
                  setState(() {
                    lname = value;
                  });
                },
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              TextField(

                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Phone",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                onChanged: (value) {
                  setState(() {
                    fname = value;
                  });
                },
              )
            ],
          ),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          FloatingActionButton(
            child: Icon(Icons.calendar_today),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime(2000),
                firstDate: DateTime(1990),
                lastDate: DateTime.now(),
              ).then((value) {
                setState(() {
                  _datetime = value;
                });
              });
            },
          ),
          FloatingActionButton(
            heroTag:"btn2",
            onPressed: (){
              //getimagefromcam
            },
            tooltip: 'click image',
            child: Icon(Icons.add_a_photo),
          ),
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
             // pickImageFromGallery(ImageSource.gallery);
            },
            tooltip: 'pick image',
            child: Icon(Icons.photo),
          ),

        ],
      )
    ],
  ),
);

  }
}
