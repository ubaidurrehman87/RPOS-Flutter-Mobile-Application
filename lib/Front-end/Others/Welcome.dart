import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import '../home.dart';
import '../../main.dart';
class Launching extends StatefulWidget {
  Launching({Key key}) : super(key: key);

  @override
  LaunchingState createState() => new LaunchingState();
}

class LaunchingState extends State<Launching> {
  List<Slide> slides = new List();

  @override
  void initState() {
    
    super.initState();
    
    slides.add(
      new Slide(
        // title: "Welcome ",
        // description: "It's a smart RPOS system for Smart People.",
        pathImage: "assets/image/Home.png",
        backgroundColor: Color(0xfff5a623),
      ),
    );
   
  }

  void onDonePress() {
    // TODO: go to next screen
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
  }

  // void onSkipPress() {
  //   // TODO: go to next screen
  //    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
  // }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      
    );
  }
}