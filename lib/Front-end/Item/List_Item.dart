import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'class_data.dart';
import 'Update_item.dart' as update;
import '../../Database/Item/item.dart' as item;
import '../Others/QR_scanner.dart';
import '../../Database/Item/cart.dart' as cart;

class NewHome extends StatefulWidget {
  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome>with AutomaticKeepAliveClientMixin<NewHome> {
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
        body: Container(
            child: alldata.length == 0
                ? Center(
                  child: Image.network('https://cdn.dribbble.com/users/634336/screenshots/2246883/_____.png'),
                )
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
                  )),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(
            Icons.camera_alt,
          ),
          label: Text('Scan'),
          onPressed: () {
          Future<String> futureString = new QRCodeReader().scan();
          print(futureString);
          
          },
          backgroundColor: Colors.deepPurple,
        )
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
            height: 140,
            width: 120,
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
        new Column(
          children: <Widget>[
            new GestureDetector(
           onTap: (){
           _editItemDialog(context,id,name,price,category);
           },
        child:new Container(
          
         height: 40,
         width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
             boxShadow: [
          new BoxShadow(
              color: Colors.black54,
              offset: new Offset(2.0, 2.0),
              blurRadius: 5.0)
              ]
          ),
          child: Icon(Icons.edit,color: Colors.green[400],),
        )
        ),
        new SizedBox(
          height: 6,
        ),
        new GestureDetector(
          onTap: (){
            _addItemToCartDialog(context, id, name, price, category);
           },
        child:new Container(
          
         height: 40,
         width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
             boxShadow: [
          new BoxShadow(
              color: Colors.black54,
              offset: new Offset(2.0, 2.0),
              blurRadius: 5.0)
              ]
          ),
          child: Icon(Icons.add_shopping_cart),
        )
        ),
         new SizedBox(
          height: 6,
        ),
        new GestureDetector(
           onTap: (){
            _deleteItemDialog(context, id);
           },
        child:new Container(
          
         height: 40,
         width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
             boxShadow: [
          new BoxShadow(
              color: Colors.black54,
              offset: new Offset(2.0, 2.0),
              blurRadius: 5.0)
              ]
          ),
          child: Icon(Icons.delete,color: Colors.red[300],),
        )
        ),
        
          ],
        ),
        
      ],
    ),
  );
}


// Edit Item Dialoge Box
Future<String> _editItemDialog(BuildContext context,String id,String name,String price,String category) async {
  return showDialog<String>(
   
    context: context,
    barrierDismissible: false, // dialog is dismissible with a tap on the barrier
    
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 25,
        title: Text('Edit Item'),
        
        content: new Column(
          
          children: <Widget>[
          new Expanded(
                child: new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Item Name',
                  icon: Icon(Icons.bookmark)
                  ),
              onChanged: (value) {
                name = value;
              },
            )),
            new Expanded(
                child: new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Price',
                  icon: Icon(Icons.attach_money)
                  ),
              onChanged: (value) {
                price = value;
              },
            )),
            
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: (){
              item.updateItem(id, name, price,category);
              Navigator.of(context).pop();
            },

          ),
        ],
      );
    },
  );
}


// Delete Item DialogBox
Future<String> _deleteItemDialog(BuildContext context,String id) async {
    String selected; 
  String forgotemail = '';
  return showDialog<String>(
   
    context: context,
    barrierDismissible: false, // dialog is dismissible with a tap on the barrier
    
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 25,
        title: Text('Delete Item',style: TextStyle(fontWeight: FontWeight.bold),),
        
        content: Text("Do You Want To Delete Item?",style: TextStyle(color: Colors.red[500]), ),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: (){
              item.deleteItem(id);
              Navigator.of(context).pop();
            },

          ),
         FlatButton(
            child: Text('No'),
            onPressed: (){
              Navigator.of(context).pop();
            },

          ),
        ],
      );
    },
  );
}
Future<String> _qrItemDialog(BuildContext context,String id) async {
    String selected; 
  String forgotemail = '';
  return showDialog<String>(
   
    context: context,
    barrierDismissible: false, // dialog is dismissible with a tap on the barrier
    
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 25,
        title: Text('Delete Item',style: TextStyle(fontWeight: FontWeight.bold),),
        
        content: Text("Do You Want To Delete Item?",style: TextStyle(color: Colors.red[500]), ),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: (){
              item.deleteItem(id);
              Navigator.of(context).pop();
            },

          ),
         FlatButton(
            child: Text('No'),
            onPressed: (){
              Navigator.of(context).pop();
            },

          ),
        ],
      );
    },
  );
}
Future<String> _addItemToCartDialog(BuildContext context,String id,String name,String price,String category) async {
  int quaintity;
  int oldprice=int.parse(price);
  int newprice;
  return showDialog<String>(
   
    context: context,
    barrierDismissible: false, // dialog is dismissible with a tap on the barrier
    
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 25,
        title: Text('How Many ${name} You Would Like To Buy.'),
        content: new Container(
          height: 80,
          width: 200,
        child:new Column(
          children: <Widget>[
          new Expanded(
                child: new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Item Quantity',
                  icon: Icon(Icons.playlist_add)
                  ),
              onChanged: (value) {
                quaintity =int.parse(value);
                newprice=quaintity*oldprice;
                price=newprice.toString();
              },
              keyboardType: TextInputType.numberWithOptions(),
            )),
          ],
        ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: (){
             cart.addCart(id,name,price,category);
              Navigator.of(context).pop();
            },

          ),
           FlatButton(
            child: Text('Cancel'),
            onPressed: (){
              Navigator.of(context).pop();
            },

          ),
        ],
      );
    },
  );
}