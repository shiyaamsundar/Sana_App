import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Sidrem extends StatefulWidget {

  var index, link, count, common;

  Sidrem({Key key, this.index, this.count, this.common}) : super(key: key);

  @override
  _SidremState createState() => _SidremState();
}

class _SidremState extends State<Sidrem> {
  var index,count,common;
  var collec =  List<String>();
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedinuser;

  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      index=widget.index;
      count=widget.count;
      common=widget.common;
    });
    getcurrentuser();
    p();
    super.initState();
  }
  String daataa;
  QuerySnapshot docs;
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
        print('email');
        print(loggedinuser.email);
        getdata().then((res){
          setState(() {
            docs=res;
            print('data');
            print(docs.documents[0]['data']);
            daataa=docs.documents[0]['data'];
            p();

          });

        });


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
  getdata()async{


    return Firestore.instance.collection(loggedinuser.email).getDocuments();


  }
  p() {

    var coll =  List<String>(int.parse(widget.count));

int cnt;

    print("zzzz");


    var c,v="",o=":";
    int l,ok=0;

    print("asdasdasdas");


    for (int i = 0; i < int.parse(widget.count); i++) {
      c=widget.common[i.toString()];
      l=c.length;
      v="";
      for (int j=0;j<l;j++)
      {
        if(widget.common[i.toString()][j]!=o){
          v+=widget.common[i.toString()][j];
        }
        if(widget.common[i.toString()][j]==o)
        {
          break;
        }
      }
      if(v.toLowerCase()!=daataa.toString().toLowerCase()){
        coll[ok]=widget.common[i.toString()].toString();

        ok++;
//        print(widget.common[i.toString()]);
      }

    }

    print('yess');

    setState(() {
      collec=coll;
      cnt=ok;
    });



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title: Text('Siddha Remedi'),),
      drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  backgroundImage: NetworkImage(aaa),
                ),
                accountEmail: Text(loggedinuser.email),
//            accountName: StreamBuilder(
//              stream:
//                  Firestore.instance.collection(loggedinuser.email).snapshots(),
//              builder: (context, snapshot) {
//                if (!snapshot.hasData) return Text('wait');
//                return Text(snapshot.data.documents[0]['uname']);
//              },
//            ),
                accountName: StreamBuilder(
                  stream:
                  Firestore.instance.collection(loggedinuser.email).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {

                      return Text(snapshot.data.documents[0]['uname']);
                    }
                  },
                ),
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
//                title: Text('questions'),
//                trailing: Icon(Icons.question_answer),
//                onTap: () {
//                  Navigator.pushNamed(context, '/ques');
//                },
//              ),
            ],
          ) // Populate the Drawer in the next step.
      ),
    body:
    ListView.builder(
    itemCount: collec==null?0:collec.length,
    itemBuilder: (BuildContext ctxt, int index) {
    if(collec[index]!=null){
    return Column(
    children: <Widget>[
    Card(
    elevation: 10,
    child: Column(
    children: <Widget>[
    Padding(
    padding: EdgeInsets.only(top: 5,bottom: 5),
    ),
    Text(collec[index],style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
    SizedBox(height: 20,)
    ],
    ),


    )

    ],


    );

    };

    }


   ),);
  }
}
