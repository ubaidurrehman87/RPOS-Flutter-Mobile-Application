import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../Front-end/home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../Front-end/Item/List_Item.dart' as list;

// add Item
Future <void>addCart(String id,String name,String price,String category)async{
  //database
  String nodename="-L"+id;
  try{
  final DatabaseReference database=FirebaseDatabase.instance.reference().child("cart");
  database.child(nodename).set({
    'itemID' : id,
    'itemName' : name,
    'itemPrice': price,
    'itemCategory':category
  });
  print('Item Added to Cart');
  }catch(e){
   print("Error: ${e}");
  }
}
 //storage

// Get Item

 
Future<void> getImage(String id)async{
    final ref=FirebaseStorage.instance.ref().child(id);
    
    // var downloadimage= await ref.getDownloadURL();
    // String url=downloadimage.toString();
    // print('Image URL:$url ');
    // return url;
    // final ref = FirebaseStorage.instance.ref().child('testimage');
    // no need of the file extension, the name will do fine.
    var url = await ref.getDownloadURL();
    print(url);
}


// Update Item
Future<void> updateItem(String id,String name,String price,String category)async{
try{
  final DatabaseReference database=FirebaseDatabase.instance.reference().child("Item");
  database.child(id).set({
     'itemID' : id,
    'itemName' : name,
    'itemPrice': price,
    'itemCategory':category

  });
    print('Item Updated');
  }catch(e){
   print('Item Did not Added');
  }
}

// Delete Item

Future <void> deleteItem(String id)async{
  try{
    final DatabaseReference database=FirebaseDatabase.instance.reference().child("cart");
    database.child(id).remove();
    print('Remove Success fully');
  }catch(e){
 print("Error ${e}");
  }

}


//Alert Box _Item Added
Future <void> _addItem(BuildContext context){
  return showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.lightGreen[100],
        title: Text('Item Added to CArt'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actions: <Widget>[
          FlatButton(
            child: Text('ok'),
            onPressed: (){
              Navigator.of(context).pop();
            },

          )
        ],
      );
    }

  );
}
Future <void> _failedtoAddItem(BuildContext context){
return showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text('Item is Not Added'),
        content: Text('Please Check Your Internet connection'),
        backgroundColor: Colors.red[100],
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: (){Navigator.of(context).pop();},
          )
        ],
      );
    }
);
}


// Last Node 
void lastNode(){
   final DatabaseReference database=FirebaseDatabase.instance.reference().child("Item");
   String snapShotKeyToDel;
   List <int> number;
     database.orderByChild("itemID").once()
     .then((DataSnapshot snapshot){
         var keys = snapshot.value.keys;
         var value=snapshot.value;
         for(var key in keys ){ 
           int x=(int.parse(value[key]["itemID"]));
          // number.add(x);
          // rnumber.add(x);
           print(x);
         }
        // List ids=keys.toList();
        // print(ids);

      });
      
  // return snapShortKeyToDel;
}
