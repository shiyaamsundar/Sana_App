import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Homered extends StatefulWidget {
  var index, link, count, common;

  Homered({Key key, this.index, this.count, this.common}) : super(key: key);

  @override
  _HomeredState createState() => _HomeredState();
}

class _HomeredState extends State<Homered> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedinuser;
  bool load = false;
String data;
int cnt,cnnt;

  QuerySnapshot docs;
  @override
  void initState() {
    // TODO: implement initState

  setState(() {
    cnnt=int.parse(widget.count);
  });
    getcurrentuser();


    super.initState();
  }

  String a,daataa;
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


  var al="pp1@gmail.com";
  var collec =  List<String>();

  getdata()async{


    return Firestore.instance.collection(loggedinuser.email).getDocuments();


  }

  p() {

    var coll =  List<String>(int.parse(widget.count));


print("zzzz");

//Map<int, String> coll = {};
//List<String> coll=List(int.parse(widget.count));

    var c,v="",o=":";
    int l,ok=0;
    //print(widget.common[0.toString()]);
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
    print(coll[0]);
    setState(() {
      collec=coll;
      cnt=ok;
    });
//    setState(() {
//      collec=coll;
//    });
//    return ListView(
//      children: <Widget>[
//      Text('hello'),
//      ],
//    );
    print(collec[2]);




//    return  ListView.builder(itemCount: coll==null?0:ok,itemBuilder: (BuildContext context,index){
//      return Column(
//        children: <Widget>[
//          Text(coll[index]),
//        ],
//      );
//    });

}

//hell()async{
//  StreamBuilder(
//    stream:
//    Firestore.instance.collection(loggedinuser.email).snapshots(),
//    builder: (context, snapshot) {
//      //if (snapshot.data != null) {
//
//        // ignore: missing_return
//        return Text(snapshot.data.documents[0]['data']);
//
//    },
//  );
//}

d() {
  pr.show();
  Future.delayed(Duration(seconds: 2)).then((value) {
    pr.hide().whenComplete(() {});
  });
}

ProgressDialog pr;

@override
Widget build(BuildContext context) {
  pr = new ProgressDialog(context);

  pr.style(
      message: 'Please Waiting...',
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
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
  return Scaffold(
    appBar: AppBar(
      title: Text('Home Remedy'),
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
                Navigator.pushNamed(context, 'myred');
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
    body:ListView.builder(
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

//
//    Container(
//      child: Column(
//        children: <Widget>[
//
//          SizedBox(height: 5,),
//          Text('${widget.index}',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold ),),
//          SizedBox(height: 15,),
//
////      ListView.builder(itemCount: collec==null?0:cnt,itemBuilder: (BuildContext context,index){
////      return Column(
////        children: <Widget>[
////          return Text(collec[index]),
////        ],
////      );
////    }),
//        Center(
//          child: ListView.builder(
//            itemCount: collec.length,
//            itemBuilder: (BuildContext ctxt, int index) {
//              return Text(collec[index]);
//            }
//        ),
//        )
//
//        ],
//      ),
//    ),

  ),

  );
}}
