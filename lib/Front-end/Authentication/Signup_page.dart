import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../stacked_icons.dart';
import '../home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Database/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  final Widget child;

  SignupPage({Key key, this.child}) : super(key: key);

  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController name_control = new TextEditingController();
  TextEditingController email_control = new TextEditingController();
  TextEditingController password_control = new TextEditingController();
  TextEditingController cpassword_control = new TextEditingController();
  TextEditingController shop_control = new TextEditingController();
  bool name_validate = false;
  bool email_validate = false;
  bool password_validate = false;
  bool cpassword_validate = false;
  bool shopname_validate = false;

  bool _validate = false;
  String _username, _email, _password, _confpassword, _shopname;
  final TextEditingController controller = TextEditingController();
  bool _autoValidate = false;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.deepPurple, //or set color with: Color(0xFF0000FF)
    ));
    return new Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: new AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: new IconThemeData(color: Color(0xFF18D191))
              ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            autovalidate: _autoValidate,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new StakedIcons(),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                      child: new Text(
                        "RPOS System",
                        style: new TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.redAccent),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 0.0),
                  child: TextField(
                    decoration: InputDecoration(
                      errorText: name_validate ? 'Enter Name' : null,
                      labelText: "Full Name",
                      fillColor: Colors.black,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      //fillColor: Colors.green
                    ),
                    controller: name_control,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontFamily: "Roboto", color: Colors.black),
                    onChanged: (v) => _username = v,
                  ),
                ),
                new SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 0.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      fillColor: Colors.black,
                      errorText: email_validate ? 'Enter Email' : cpassword_validate
                          ? 'Enter Confirmed Password or Password did not match'
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      //fillColor: Colors.green
                    ),
                    controller: email_control,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontFamily: "Roboto", color: Colors.black),
                    onChanged: (v) => _email = v,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      fillColor: Colors.black,
                      errorText: password_validate ? 'Enter Password' : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      //fillColor: Colors.green
                    ),
                    controller: password_control,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontFamily: "Roboto", color: Colors.black),
                    onChanged: (v) => _password = v,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 0.0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      fillColor: Colors.black,
                      errorText: cpassword_validate
                          ? 'Enter Confirmed Password or Password did not match'
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      //fillColor: Colors.green
                    ),
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontFamily: "Roboto", color: Colors.black),
                    onChanged: (v) => _confpassword = v,
                    controller: cpassword_control,
                  ),
                ),
                new SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 0.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Shop Name",
                      fillColor: Colors.black,
                      errorText: shopname_validate ? 'Enter Shop Name' : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      //fillColor: Colors.green
                    ),
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontFamily: "Roboto", color: Colors.black),
                    onChanged: (v) => _shopname = v,
                    controller: shop_control,
                  ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                        onPressed: () {
                          setState(() {
                            name_control.text.isEmpty
                                ? name_validate = true
                                : name_validate = false;
                            email_control.text.isEmpty
                                ? email_validate = true
                                : email_validate = false;
                            password_control.text.isEmpty
                                ? password_validate = true
                                : password_validate = false;
                            cpassword_control.text.isEmpty
                                ? cpassword_validate = true
                                : cpassword_validate = false;
                            shop_control.text.isEmpty
                                ? shopname_validate = true
                                : shopname_validate = false;
                            if(password_validate==false && cpassword_validate==false){
                              password_control.text!=cpassword_control.text
                              ? cpassword_validate=true
                              : cpassword_validate=false;

                            }
                          });
                          if (name_validate==cpassword_validate && password_validate==shopname_validate  && name_validate == false && shopname_validate==false) {
                           signUp(_username, _email,_password,_shopname,context);
                            print('username: ${_username} \n password: ${_password} \n email: ${_email}');

                          }
                        },
                        color: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: new Text("Signup",
                            style: new TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  saver(String val) {}
}
