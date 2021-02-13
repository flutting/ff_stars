import 'package:flutter/material.dart';
import 'package:ff_stars/ff_stars.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("星星评价"),
      ),
      body: Center(
        child: FFStars(
          normalStar: Image.asset("assets/normal.png"),
          selectedStar: Image.asset("assets/selected.png"),
          //justShow: true,
          // starsChanged: (realStars, choosedStars){
          //   print("实际选择: ${choosedStars}, 最终得分: ${realStars}");
          // },
        ),
      ),
    );
  }
}
