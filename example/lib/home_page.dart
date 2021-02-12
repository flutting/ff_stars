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
        title: Text("demo列表"),
      ),
      body: Center(
        child: FFStars(),
      ),
    );
  }
}
