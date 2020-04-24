import 'package:flutter/material.dart';

class Ques extends StatefulWidget {
  @override
  _QuesState createState() => _QuesState();
}

class _QuesState extends State<Ques> {


//Future<List<Items>> fetchitems (BuildContext context)async{
//  final jsonstring =await DefaultAssetBundle.of(context).loadString('assets/file.json');
//




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Q&A'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: (){})
        ],

      ),
    );
  }
}
