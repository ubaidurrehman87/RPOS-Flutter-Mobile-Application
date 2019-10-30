import 'package:flutter/material.dart';
import '../../Database/Item/item.dart';
import 'package:firebase_database/firebase_database.dart';
import 'class_data.dart';
import '../../Database/Item/item.dart' as item;
import '../../Database/Item/cart.dart' as cart;
// import 'class_data.dart';
class UpdateItem extends StatefulWidget {
  @override
  _UpdateItemState createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
  List<myCart> alldata = [];
  @override
  void initState() {
    DatabaseReference getdata =
        FirebaseDatabase.instance.reference().child("cart");
    getdata.once().then((DataSnapshot dataSnapshot) {
      var keys = dataSnapshot.value.keys;
      var value = dataSnapshot.value;
      alldata.clear();
      for (var key in keys) {
        myCart d = new myCart(value[key]['itemID'], value[key]['itemName'],
            value[key]['itemPrice'], value[key]['itemCategory']);
        print(key);
        alldata.add(d);
      }
      print(alldata[1].id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     
     body: 
       Container(
           
             child: alldata.length == 0
                ? Text('Nothing To Show')
                : ListView.builder(
                    itemCount: alldata.length,
                    itemBuilder: (_, index) {
                      return UI(
                        context,
                        alldata[index].id,
                        alldata[index].name,
                        alldata[index].price,
                        alldata[index].category,
                      );
                    },
                  ),
                  
                  ),
                
     );

  }
   @override
  bool get wantKeepAlive => true;
  }

  Widget UI(BuildContext context,String id, String name, String price, String category) {
 int intid = int.parse(id);
    assert(intid is int);

    print(intid); 
  var image =
      'https://media.istockphoto.com/photos/laptop-with-blank-screen-on-white-picture-id479520746';
  return new Container(
    alignment: Alignment.centerLeft,
    margin: new EdgeInsets.all(8.0),
    padding: new EdgeInsets.all(8.0),
    height: 150.0,
    decoration: new BoxDecoration(
        // color:  (intid%5)==0? Color.fromRGBO(74, 81, 206, 2)
        // :(intid%4)==0? Color.fromRGBO(169, 60, 224, 2)
        // :(intid%3)==0 ? Color.fromRGBO(190, 226, 59, 2)
        // :(intid%2)==0 ?Color.fromRGBO(229, 41, 41, 2)
        color: Colors.lightBlue,
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
        boxShadow: [
          new BoxShadow(
              color: Colors.black54,
              offset: new Offset(2.0, 2.0),
              blurRadius: 5.0)
        ]),
    child: new Row(
      children: <Widget>[
        new Container(
            height: 150,
            width: 140,
            decoration: new BoxDecoration(
             
              borderRadius: BorderRadius.circular(10),
               boxShadow: [
                new BoxShadow(
              color: Colors.black54,
              offset: new Offset(2.0, 2.0),
              blurRadius: 5.0)
                 ],
                shape: BoxShape.rectangle,
                image: new DecorationImage(
                    fit: BoxFit.fill, image: new NetworkImage(image)))),
        new Expanded(
            child: new Padding(
          padding: new EdgeInsets.only(left: 8.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                name,
                style:
                    new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              new Row(  
                children: <Widget>[
                  new Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  new Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  new Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  new Icon(
                    Icons.star_half,
                    color: Colors.white,
                  ),
                  new Icon(
                    Icons.star_border,
                    color: Colors.white,
                  ),
                ],
              ),
              new Wrap(
                spacing: 2.0,
                children: <Widget>[
                  new Chip(label: new Text(id)),
                  new Chip(label: new Text(price)),
                  new Chip(label: new Text(category)),
                ],
              )
            ],
          ),
        )),
        
        
      ],
    ),
  );
}