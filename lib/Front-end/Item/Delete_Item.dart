import 'package:flutter/material.dart';
import 'class_data.dart';
import 'package:firebase_database/firebase_database.dart';
class DeleteItem extends StatefulWidget {
  @override
  _DeleteItemState createState() => _DeleteItemState();
}

class _DeleteItemState extends State<DeleteItem> {

  List<myData> alldata = [];
 
  @override
  void initState() {
    DatabaseReference getdata =
        FirebaseDatabase.instance.reference().child("Item");
    getdata.once().then((DataSnapshot dataSnapshot) {
      var keys = dataSnapshot.value.keys;
      var value = dataSnapshot.value;
      alldata.clear();
      for (var key in keys) {
        myData d = new myData(value[key]['itemID'], value[key]['itemName'],
            value[key]['itemPrice'], value[key]['itemCategory']);
        
        alldata.add(d);
      }
      print(alldata[1].id);
    });
    super.initState();
  }
  @override
 Widget build(BuildContext context) {
return Scaffold(
  body: Container(
    child: alldata.length==0 
    ? Text('Nothing To Show') 
    :new ListView.builder(
      itemCount: alldata.length,
      itemBuilder: (_,index){
        return UI(
          alldata[index].id,
          alldata[index].name,
          alldata[index].price,
          alldata[index].category,);
      },


    )

    ),
);
}
}

Widget UI(String id, String name, String price, String category) {
  var image =
      'https://media.istockphoto.com/photos/laptop-with-blank-screen-on-white-picture-id479520746';
return new Container(
  alignment: Alignment.centerLeft,
  margin: new EdgeInsets.all(8.0),
  padding: new EdgeInsets.all(8.0),
  height: 150.0,
  decoration: new BoxDecoration(
    color: Colors.lightBlue,
    borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
    boxShadow: [new BoxShadow(color: Colors.black54, offset: new Offset(2.0, 2.0),
    blurRadius: 5.0)]
  ),
  child: new Row(children: <Widget>[
    new Container(
      height: 150,
      width: 140,
      color: Colors.purple,
     decoration: new BoxDecoration(
                        
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(image)
                        )
                    )
    ), 
    new Expanded(child: new Padding(padding: new EdgeInsets.only(left: 8.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(name, style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          new Row(children: <Widget>[
            new Icon(Icons.star, color: Colors.white,),
            new Icon(Icons.star, color: Colors.white,),
            new Icon(Icons.star, color: Colors.white,),
            new Icon(Icons.star_half, color: Colors.white,),
            new Icon(Icons.star_border, color: Colors.white,),
          ],),
          new Wrap(spacing: 2.0,children: <Widget>[
            new Chip(label: new Text(id)),
            new Chip(label: new Text(price)),
            new Chip(label: new Text(category)),
          ],)
        ],),))
  ],),
);
}