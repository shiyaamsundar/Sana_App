import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'siddremedi.dart';
import 'homered.dart';

class Myreda extends StatefulWidget {
  @override
  _MyredaState createState() => _MyredaState();
}

class _MyredaState extends State<Myreda> {

  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedinuser;

  @override
  void initState() {
    // TODO: implement initState

    getcurrentuser();

    super.initState();
  }
  var aaa="https://www.google.co.in/imgres?imgurl=https%3A%2F%2Fwww.pixelstalk.net%2Fwp-content%2Fuploads%2F2016%2F10%2FBlank-Wallpaper-HD.jpg&imgrefurl=https%3A%2F%2Fwww.pixelstalk.net%2Fblank-wallpaper-free-download%2F&tbnid=RrS1ZWxdO6ilJM&vet=12ahUKEwifqPW_qe_nAhUI6zgGHaHgCj0QMygIegUIARCVAg..i&docid=nZxpKuBdDAAZ6M&w=2560&h=1600&q=blank%20wallpaper&ved=2ahUKEwifqPW_qe_nAhUI6zgGHaHgCj0QMygIegUIARCVAg";
  void getcurrentuser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          loggedinuser = user;
        });

        //a=loggedinuser.email.toString();

        print(loggedinuser.email);
        final ref = FirebaseStorage.instance.ref().child(loggedinuser.email.toString()+'.jpg');




        var url = await ref.getDownloadURL();

        if(url!=null)
        {
          setState(() {
            aaa=url;
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
        title: Text('Siddha'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: (){})
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
                  stream: Firestore.instance.collection(loggedinuser.email).snapshots(),
                  builder: (context,snapshot){
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
        child: Center(
          child: FutureBuilder(future:DefaultAssetBundle.of(context).loadString('assets/siddha.json'),builder: (context,snapshot){
            var mydata=jsonDecode(snapshot.data.toString());
            return ListView.builder(itemCount: mydata==null?0:mydata.length,itemBuilder: (BuildContext context,index){
              return InkWell(


                child: Card(


                    child: Container(
                      margin: EdgeInsets.all(18),

                      child: InkWell(
                        onTap: (){
                          //Navigator.pushNamed(context, '/homered');
                          var rout=MaterialPageRoute(builder: (BuildContext conext)=>
                              Sidrem(index:mydata[index]['name'],count:mydata[index]['count'],common:mydata[index]['Description']),
//                         var link=MaterialPageRoute(builder: (BuildContext conext)=>
//                         Homered(index:mydata[index]['link']),
//                     var index=MaterialPageRoute(builder: (BuildContext conext)=>
//                     Homered(index:mydata[index]['index']),
                          );
                          Navigator.push(context,rout);

                          print("$mydata[index]['index']");
                        },
                        child: Column(
                          children: <Widget>[

                              Text(mydata[index]['name'].toString()),
                              SizedBox(height:10 ),


//                            Text(mydata[index]['description'].toString()),
                          ],
                        ),
                      ),
                    )

                ),
              );
            });
          } ,),
        ),
      ),
    );
  }
}
