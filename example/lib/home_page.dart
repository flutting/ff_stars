import 'package:flutter/material.dart';

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
      body: Center(child: Text("home"),)
    );
  }

  /// 跳转到指定的demo页面
  void showDemoPage(int index) {

  }

}
