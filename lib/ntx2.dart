import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_appaa/main.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Nxt extends StatefulWidget {



  @override
  _NxtState createState() => _NxtState();
}

class _NxtState extends State<Nxt> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedinuser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentuser();
  }

  DateTime _datetime;

  void currentuser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          loggedinuser=user;
        });
        print(user.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<File> imageFile;
  File _image;

  DateTime date;
  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Future getimagefromcam() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }
    Future getimagefromgal() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });

  }

  String username, fname, lname, email, phone,dob,uname,data;


   savedata()async{
     final StorageReference firebaseStorageRef =
     FirebaseStorage.instance.ref().child('$email.jpg');
     final StorageUploadTask task =
     firebaseStorageRef.putFile(_image);
     final StorageReference ref=FirebaseStorage.instance.ref().child('$email.jpg');
     String aa=ref.toString();
      Firestore.instance.collection(loggedinuser.email).add({
        'fname':fname,
        'lname':lname,
        'data':data,
        'email':email,
        'phone':phone,
        'date':_datetime,
        'uname':uname,

            'photourl':aa,
      }) ;


   print('$fname');
   print('$lname');
   print('$uname');
   print('$email');
   print('$phone');
   print('$data');
   print('$_datetime');
   print('$_image');

    bookFlight(context);
}
  void bookFlight(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Your data has been saved successfully"),
      content: Text("Go back to main menu in signin!"),


    );

    Navigator.pushNamed(context, '/main');
  }
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);

    pr.style(
        message: 'Please Wait...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 490,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 26.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                  validator: (String value) {
    return 'Enter your first name';
    },

                    decoration: InputDecoration(
                      labelText: 'FirstName',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onSaved: (input) => fname = input,
                    onChanged: (value){
                      setState(() {
                        fname=value;
                      });
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),

                  TextFormField(
                    validator: (String input){
                        return 'provide an Last name';

                    },
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onSaved: (input) => lname = input,
                    onChanged: (value){
                      setState(() {
                        lname=value;
                      });
                    },

                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  TextFormField(
                    validator: (String input) {

                        return 'provide an Username';

                    },
                    decoration: InputDecoration(
                      labelText: 'User Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onSaved: (input) => uname = input,
                    onChanged: (value){
                      setState(() {
                        uname=value;
                      });
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  TextFormField(
                    validator: (String input) {

                        return 'provide an email';

                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onSaved: (input) => email = input,
                    onChanged: (value){
                      setState(() {
                        email=value;
                      });
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),

                  TextFormField(
                    validator: (String input) {
                        return 'provide an Phone number';

                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onSaved: (input) => phone = input,
                    onChanged: (value){
                      setState(() {
                        phone=value;
                      });
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(

                      hintText: "Details",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0,),),
                    onChanged: (value) {
                      setState(() {
                        data = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(15),
                  )

                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[


                    FloatingActionButton(
                      heroTag: 'btn1',
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
                            print(_datetime);
                          });
                        });
                      },
                    ),


//                  FloatingActionButton(
//                    heroTag: 'btn2',
//                    onPressed: getimagefromcam,
//                    tooltip: 'click image',
//                    child: Icon(Icons.add_a_photo),
//                  ),
                  FloatingActionButton(
                    heroTag: 'btn3',
                    onPressed: getimagefromgal,
                    tooltip: 'pick image',
                    child: Icon(Icons.photo),
                  ),




                ],
              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: <Widget>[
//                  Text('Date'),
//
//                  Text('image using camera'),
//                  Text('image form gallery'),
//                ],
//              ),
            SizedBox(height: 10,),
                Container(
                  width: 150,
                child: RaisedButton(
                  child: Text('Save info',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                  onPressed: (){

                    savedata();
                    pr.show();
                    Future.delayed(Duration(seconds: 2)).then((value) {
                      pr.hide().whenComplete(() {
                        Navigator.pushNamed(context, '/main');
                      });
                    });
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
                )


            ],
          )
        ],
      ),
    );
  }
}
