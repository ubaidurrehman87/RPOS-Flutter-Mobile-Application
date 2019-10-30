import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

Future <void> updateuser(String id)async{
DatabaseReference ref=FirebaseDatabase.instance.reference().child('id');
final adduser=ref.child('id');

}