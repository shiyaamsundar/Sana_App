import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Myred extends StatefulWidget {
  @override
  _MyredState createState() => _MyredState();
}

class _MyredState extends State<Myred> {
  List<Dynamo> listDyno = [];

  adddyna() {
    if (listDyno.length >= 9) {
      return;
    }
    listDyno.add(new Dynamo());
    setState(() {});
  }

  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedinuser;

  @override
  void initState() {
    // TODO: implement initState

    getcurrentuser();

    super.initState();
  }

  var aaa =
      "https://www.google.co.in/imgres?imgurl=https%3A%2F%2Fwww.pixelstalk.net%2Fwp-content%2Fuploads%2F2016%2F10%2FBlank-Wallpaper-HD.jpg&imgrefurl=https%3A%2F%2Fwww.pixelstalk.net%2Fblank-wallpaper-free-download%2F&tbnid=RrS1ZWxdO6ilJM&vet=12ahUKEwifqPW_qe_nAhUI6zgGHaHgCj0QMygIegUIARCVAg..i&docid=nZxpKuBdDAAZ6M&w=2560&h=1600&q=blank%20wallpaper&ved=2ahUKEwifqPW_qe_nAhUI6zgGHaHgCj0QMygIegUIARCVAg";

  void getcurrentuser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          loggedinuser = user;
        });

        //a=loggedinuser.email.toString();

        print(loggedinuser.email);
        final ref = FirebaseStorage.instance
            .ref()
            .child(loggedinuser.email.toString() + '.jpg');

        var url = await ref.getDownloadURL();

        if (url != null) {
          setState(() {
            aaa = url;
          });
        }

        print(aaa);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Remedy'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
          ],
        ),
        drawer: Drawer(
            child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                backgroundImage: NetworkImage(aaa),
              ),
              accountName: StreamBuilder(
                stream: Firestore.instance
                    .collection(loggedinuser.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  return Text(snapshot.data.documents[0]['uname']);
                },
              ),
              accountEmail: Text(loggedinuser.email),
            ),
            ListTile(
              title: Text('My Remedy'),
              trailing: Icon(Icons.add),
              onTap: () {
                Navigator.pushNamed(context, '/myred');
              },
            ),
            ListTile(
              title: Text('Home Remedy'),
              trailing: Icon(Icons.home),
              onTap: () {
                Navigator.pushNamed(context, '/draw');
              },
            ),
            ListTile(
              title: Text('Siddha'),
              trailing: Icon(Icons.spa),
              onTap: () {
                Navigator.pushNamed(context, '/sid');
              },
            ),
//              ListTile(
//                title: Text('blog'),
//                trailing: Icon(Icons.pageview),
//                onTap: () {
//                  Navigator.pushNamed(context, '/blog');
//                },
//              ),
//              ListTile(
//                title: Text('questions'),
//                trailing: Icon(Icons.question_answer),
//                onTap: () {
//                  Navigator.pushNamed(context, '/ques');
//                },
//              ),
          ],
        ) // Populate the Drawer in the next step.
            ),
        body: Container(
            //margin: EdgeInsets.all(15.0),
            child: new Column(children: <Widget>[
          Flexible(
              child: ListView.builder(
            itemBuilder: (_, index) => listDyno[index],
            itemCount: listDyno.length,
          )),
//          RaisedButton(
//            onPressed: null,
//            child: Text(
//              "Submit",
//              style: TextStyle(color: Colors.white),
//            ),
//            color: Colors.green,
//            splashColor: Colors.teal,
//          ),

        ])),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: adddyna,
          label: Text("ADD"),
          icon: Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
          hoverColor: Colors.blueAccent,
        ));
  }
}


class Dynamo extends StatefulWidget {
  @override
  _DynamoState createState() => _DynamoState();
}

class _DynamoState extends State<Dynamo> {

  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedinuser;

  @override
  void initState() {
    // TODO: implement initState
    getcurrentuser();
    super.initState();
  }
  void getcurrentuser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          loggedinuser = user;
        });
      }}
  catch(e){
      print(e);
  }
  }
  var a;
  savedata()async{



    Firestore.instance.collection('myremedi').add({
      'remedi': a,
      'email':loggedinuser.email,

    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(

      children: <Widget>[


       TextField(
        decoration: InputDecoration(hintText: "Enter the remedy"),
        onChanged: (value) {
          setState(() {
            a = value;
          });
        },
      ),
        RaisedButton(
          child: Text(" Submit "),
          onPressed: (){
savedata();
          },
          color: Colors.blue,
          textColor: Colors.white,
          splashColor: Colors.grey,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        ),
    ],

    );
  }
}


