import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import '../home.dart';
class MySplashScreen extends StatefulWidget {
  MySplashScreen({Key key}) : super(key: key);

  @override
  MySplashScreenState createState() => new MySplashScreenState();
}

class MySplashScreenState extends State<MySplashScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();
    
    slides.add(
      new Slide(
        title: "Welcome ",
        description: "It's a smart RPOS system for Smart People.",
        pathImage: "assets/image/6.jpg",
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      new Slide(
        title: "How To Use",
        description: "More Detail",
        pathImage: "assets/image/4.jpg",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "RULES",
        description:
            "More Detail",
        pathImage: "assets/image/5.jpg",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  void onDonePress() {
    // TODO: go to next screen
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }

  void onSkipPress() {
    // TODO: go to next screen
     Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      onSkipPress: this.onSkipPress,
    );
  }
}