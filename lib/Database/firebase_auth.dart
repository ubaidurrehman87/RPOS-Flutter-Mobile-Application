import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Database/user.dart';
import '../main.dart';
import '../Front-end/home.dart';
import '../Front-end/Others/slider.dart';
Future <void> signUp(String user_name,String user_email, String user_password,String shop_name,BuildContext context) async {
  FirebaseUser user;
  try {
     user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user_email,
      password: user_password,
    );
  } catch (e) {
    _userAlreadyregister(context);
    print(e.message);
  }
    try {
    await user.sendEmailVerification();
    addUser(user_name,user_email,shop_name);
    _verifyEmail(context);
    return user.uid;
  }
  catch (e) {
    print("An Error Occured during Sending Email");
    print(e.message);
  }
}

Future<void> signin(String email,String password,BuildContext context) async{
      FirebaseUser user;
        try {
           user=await FirebaseAuth.instance.signInWithEmailAndPassword(
             email:email,
             password: password
             );
          
        } catch (e) {
          print("User is not registered");
          _incorrectPassword(context);
          print(e.message);
      }
      if(user.isEmailVerified){
        print('user verified');
        _onLoading(context);
        return user.uid;
      }
      else{
         _verificationAlert(context);
        print('User is not Verified');
        return null;
      }
}
Future <void> forgotpasword (String user_email,BuildContext context)async{
  FirebaseUser user;
    try{
     await FirebaseAuth.instance.sendPasswordResetEmail(email: user_email);
     
    }catch(e){
      print("Error ${e}");
      print("Email: "+user_email);
    }
}

Future<void> _verificationAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Email is Not Verified'),
        content: const Text('Please Verify Your Email'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future <void> _incorrectPassword(BuildContext context) async{
  return showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
         title: Text('Incorrect password or user not regitered'),
        content: const Text('Please check password or create New Account'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  );
}
Future <void> _verifyEmail(BuildContext context)async{
    return showDialog <void>(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
           title: Text('Verify Email'),
        content: const Text('Verification Email is Send to Your Email Address'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
            },
          ),
        ],
        );
      }

    );
}

Future <void> _userAlreadyregister(BuildContext context) async{
  return showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
         title: Text('Already have an Account'),
        content: const Text('The email address is already in use by another account.'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  );
}
Future<void> _emailnotExist(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Email does not Exist'),
        content: const Text('Please check whether you enter a correct email or not'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
void _onLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    child: new Dialog(
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          new CircularProgressIndicator(),
          new Text("Loading"),
        ],
      ),
    ),
  );
  new Future.delayed(new Duration(seconds: 3), () {
    Navigator.of(context).pop(); //pop dialog
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MySplashScreen()));
  });
}