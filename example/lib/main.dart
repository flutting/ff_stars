import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ff_stars/ff_stars.dart';

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: demoList(),
        ),
      ),
    );
  }

  List<Widget> demoList() {
    return [
      /// 第一个
      Text("1. 共计5颗星, 只能选整星, 默认给3颗"),
      SizedBox(height: afw(5),),
      FFStars(
        normalStar: Image.asset("assets/blueNormal.png"),
        selectedStar: Image.asset("assets/blueSelected.png"),
        starsChanged: (realStars, selectedStars) {
          print("实际选择: $selectedStars, 最终得分: $realStars");
        },
        step: 1.0,
        currentStars: 3,
      ),

      /// 第二个
      getTitleWidget("2. 共计5颗星, 可以选半星, 默认给3.5颗"),
      FFStars(
        normalStar: Image.asset("assets/orangeNormal.png"),
        selectedStar: Image.asset("assets/orangeSelected.png"),
        starsChanged: (realStars, selectedStars) {
          print("实际选择: $selectedStars, 最终得分: $realStars");
        },
        step: 0.5,
        currentStars: 3.5,
      ),

      /// 第三个
      getTitleWidget("3. 共计5颗星, 可选任意星, 默认给4.3颗"),
      FFStars(
        normalStar: Image.asset("assets/christmasNormal.png"),
        selectedStar: Image.asset("assets/christmasSelected.png"),
        starsChanged: (realStars, selectedStars) {
          print("实际选择: $selectedStars, 最终得分: $realStars");
        },
        step: 0.01,
        currentStars: 4.3,
        // starCount: 5,
        // starHeight: 40,
        // starWidth: 40,
        // starMargin: 20,
        //justShow: true,
      ),

      /// 第四个
      getTitleWidget("4. 共计8颗星, 最低选2颗"),
      FFStars(
        normalStar: Image.asset("assets/blueNormal.png"),
        selectedStar: Image.asset("assets/blueSelected.png"),
        starsChanged: (realStars, selectedStars) {
          print("实际选择: $selectedStars, 最终得分: $realStars");
        },
        step: 1.0,
        currentStars: 6,
        starCount: 8,
        miniStars: 2,
      ),

      /// 第五个
      getTitleWidget("5. 共计5颗星, 不可修改"),
      FFStars(
        normalStar: Image.asset("assets/orangeNormal.png"),
        selectedStar: Image.asset("assets/orangeSelected.png"),
        currentStars: 4.7,
        justShow: true,
      ),

      /// 第六个
      getTitleWidget("6. 四舍五入, 变化实时回调(其余为结束回调)"),
      FFStars(
        normalStar: Image.asset("assets/christmasNormal.png"),
        selectedStar: Image.asset("assets/christmasSelected.png"),
        starsChanged: (realStars, selectedStars) {
          print("实际选择: $selectedStars, 最终得分: $realStars");
        },
        currentStars: 7,
        starCount: 8,
        step: 1,
        rounded: true,/// 四舍五入-取最近值
        needFollowStar: true,
      ),
    ];

  }

  double afw(x) {
    var screenWidth = MediaQuery.of(context).size.width;
    return x / 375.0 * screenWidth;
  }

  Widget getTitleWidget(String title) {
    return Column(
      children: <Widget>[
        SizedBox(height: afw(20),),
        Text(title),
        SizedBox(height: afw(5),),
      ],
    );
  }

}

//连接逍遥模拟器: adb connect 127.0.0.1:21503
//检查: flutter packages pub publish --dry-run
//发布命令: flutter packages pub publish --server=https://pub.dartlang.org
//报错code65解决: flutter packages pub global activate devtools