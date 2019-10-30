import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

Future <void> addUser(String username,String email,String shopname)async{
final DatabaseReference  user_database=FirebaseDatabase.instance.reference().child('User');
user_database.push().set({
  'name': username,
  'email': email,
  'shopname': shopname,
});



}
