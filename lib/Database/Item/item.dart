import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../Front-end/home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../Front-end/Item/List_Item.dart' as list;
import 'package:firebase_auth/firebase_auth.dart';

// add Item
Future <void>additem(String id,String name,String price,String category,BuildContext context)async{
  //database
  String nodename="-L"+id;
  try{
  final DatabaseReference database=FirebaseDatabase.instance.reference().child("Item");
  database.child(nodename).set({
    'itemID' : id,
    'itemName' : name,
    'itemPrice': price,
    'itemCategory':category
  });
  _addItem(context);
  }catch(e){
    _failedtoAddItem(context);
  }
}
 //storage

// Get Item

 
Future<String> getImage(String id)async{
    StorageReference ref=FirebaseStorage.instance.ref().child(id);
    
    var downloadimage= await ref.getDownloadURL();
    String url=downloadimage.toString();
    print('Image URL:$url ');
    return url;
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
// Future<FirebaseUser> currentUser() async {
//   final Map<dynamic, dynamic> data =
//       await channel.invokeMethod("currentUser");
//   final FirebaseUser currentUser =
//       data == null ? null : new FirebaseUser._(data);
//   return currentUser;
// }
// void deleteUser(String id) async {
//     await _userRef.child(user.id).remove().then((_) {
//       print('Transaction  committed.');
//     });
//   }
Future <void> deleteItem(String id)async{
  String nodename="-L"+id;
  try{
    FirebaseDatabase.instance.reference().child("Item").child(nodename).remove().then((id){
      print('Transaction Completed');
    });
    print('Remove Success fully'+id);
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
       
        title: Text('Item Added'),
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
