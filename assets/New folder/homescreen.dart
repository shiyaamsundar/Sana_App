import 'package:flutter/material.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Dynamo> listDyno = [];

  adddyna() {
    if(listDyno.length>=9){
      return;
    }
    listDyno.add(new Dynamo());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          centerTitle: true,
          title: Text("Let's add"),
        ),
        body: Container(
            //margin: EdgeInsets.all(15.0),
            child: new Column(children: <Widget>[
              Flexible(
                  child: ListView.builder(
                      itemBuilder: (_, index) => listDyno[index],
                      itemCount: listDyno.length,
                      
                      )
        ),
        new RaisedButton(onPressed: null,child: Text("Submit"),)])),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: adddyna,
          label: Text("ADD"),
          icon: Icon(Icons.add),
          backgroundColor: Colors.pinkAccent,
          hoverColor: Colors.blueAccent,
        ));
  }
}

class Dynamo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Enter the remedy"
        ),
      ),
    );
  }
}
