import 'Add_item.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'class_data.dart';
import '../../Database/Item/cart.dart' as item;

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<myCart> alldata = [];
  int total=0;
  int price;
  String finaltotal;
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
        
        price=int.parse(value[key]['itemPrice']);
        total+=price;
        alldata.add(d);

      }
      // print(alldata[1].id);
      print("Total: ${total}");
      finaltotal=total.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: new AppBar(
        backgroundColor:Colors.transparent,
        titleSpacing: 60,
          elevation: 0.0,
          title: Text('Total : ${finaltotal}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.purple),),
          ),
    //  appBar: new AppBar(
    //     backgroundColor:Colors.blueAccent,
    //       elevation: 0.0,
    //       
          
    //       title: Text(finaltotal,style: TextStyle(fontWeight: FontWeight.bold),),
    //       iconTheme: new IconThemeData(color: Color(0xFF18D191))),
     body: Container(
             child: alldata.length == 0
                ? Center(
                  child: Image.network('https://cdn.dribbble.com/users/844846/screenshots/2981974/empty_cart_800x600_dribbble.png')
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
                    
                  ),
                  
                  
                  ),
         floatingActionButton: FloatingActionButton.extended(
          icon: Icon(
            Icons.cloud_done,
          ),
          label: Text('Transaction'),
          onPressed: () {
          _transactionItemDialog(context);
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

// Edit Item Dialoge Box
Future<String> _transactionItemDialog(BuildContext context) async {
    String selected; 
  String forgotemail = '';
  return showDialog<String>(
   
    context: context,
    barrierDismissible: false, // dialog is dismissible with a tap on the barrier
    
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 25,
        title: Text('Transaction Process',style: TextStyle(fontWeight: FontWeight.bold),),
        
        content: Text("Do You Want To Proceed to Payment?",style: TextStyle(color: Colors.red[500]), ),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: (){
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