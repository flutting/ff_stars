import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:example/home_page.dart';

//连接逍遥模拟器: adb connect 127.0.0.1:21503

void main() {
  runApp(MyApp());
  /// 安卓状态栏优化
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        platform: TargetPlatform.iOS, //页面跳转统一使用iOS风格
        splashColor: Colors.transparent, //点击时的高亮效果为透明(去除)
        highlightColor: Colors.transparent, //长按时的高亮效果为透明(去除)
      ),
      home: HomePage(),
    );
  }
}
