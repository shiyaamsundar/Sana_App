import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

class Nxt1 extends StatefulWidget {
  @override
  _Nxt1State createState() => _Nxt1State();
}

class _Nxt1State extends State<Nxt1> {

  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedinuser;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

//  Future getimagefromcam() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.camera);
//    setState(() {
//      _image = image;
//    });
//   }
//
//  Future getimagefromgal() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//    setState(() {
//      _image = image;
//    });
//  }

  Future<File> imageFile;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  DateTime _datetime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurrentuser();
  }

  void getcurrentuser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedinuser = user;
        print(loggedinuser.email);
      }
    } catch (e) {
      print(e);
    }
  }
File _handleVideo;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('aa'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 200,
            child: Center(

            ),

          ),
          Container(
              child: _image == null
          ? Text('No image selected.')
        : Image.file(_image),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
//                FloatingActionButton(
//                  onPressed: getimagefromcam,
//                  tooltip: 'click image',
//                  child: Icon(Icons.add_a_photo),
//                ),
              FloatingActionButton(
                onPressed: () {
                  pickImageFromGallery(ImageSource.gallery);
                },
                tooltip: 'pick image',
                child: Icon(Icons.photo),
              ),
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
              )
            ],
          ),
        ],
      ),

    );
  }
}
