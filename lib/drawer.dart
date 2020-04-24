import 'package:flutter/material.dart';

import 'draw/blog.dart';
import 'draw/questionans.dart';
import 'draw/homered.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:firebase_auth/firebase_auth.dart';


class Drawerr extends StatefulWidget {
  @override
  _DrawerrState createState() => _DrawerrState();
}
//
class _DrawerrState extends State<Drawerr> {

  final String url="https://jsoneditoronline.org/#left=local.pifeyi&right=local.jeveha";
  List data,udata;


Future<String> getjsondata()async{
    var response=await http.get(

        Uri.encodeFull(url),
      headers: {"Accept":"application/json"}
    );
data=jsonDecode(response.body)['array'];
setState(() {
  udata=data;
});
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Remedy'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
          ],

        ),


//        body:Container(
//          child: Center(
//            child: ListView.builder(itemCount: url==null?0:url.length,itemBuilder: (context,index){
//              return Card(
//                child: Row(
//                  children: <Widget>[
//                    Container(
//                      margin: EdgeInsets.all(18),
//                      child: Text("$udata['name']"),
//                    ),
//
////                    Container(
////                      margin: EdgeInsets.all(15),
////                      child: FutureBuilder(future: DefaultAssetBundle.of(context).loadString('assets/doc.json'),builder: (context,snapshot){
////                        var mydata=JsonDecode(snapshot.data.toString());
////                        return ListView.builder(itemBuilder: null)
////                      },),
////
////                    )
//                  ],
//                ),
//              );
//            },),
//          ),
//        )
    drawer: Drawer(
    child: ListView(
        children: <Widget>[
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

        ],

    )
    ),
    body: Container(
      child: Center(
        child: FutureBuilder(future:DefaultAssetBundle.of(context).loadString('assets/file.json'),builder: (context,snapshot){
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
                         Homered(index:mydata[index]['name'],count:mydata[index]['count'],common:mydata[index]['common']),
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






