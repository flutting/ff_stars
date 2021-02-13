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
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 100, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 第一个
            Text("1. 共计5颗星, 只能选整星, 默认给3颗"),
            SizedBox(
              height: 5,
            ),
            FFStars(
              normalStar: Image.asset("assets/未选中蓝星.png"),
              selectedStar: Image.asset("assets/选中蓝星.png"),
              starsChanged: (realStars, choosedStars) {
                print("实际选择: ${choosedStars}, 最终得分: ${realStars}");
              },
              step: 1.0,
              currenStars: 3,
            ),

            /// 第二个
            SizedBox(
              height: 20,
            ),
            Text("2. 共计5颗星, 可以选半星, 默认给3.5颗"),
            SizedBox(
              height: 5,
            ),
            FFStars(
              normalStar: Image.asset("assets/orangeNormal.png"),
              selectedStar: Image.asset("assets/orangeSelected.png"),
              starsChanged: (realStars, choosedStars) {
                print("实际选择: ${choosedStars}, 最终得分: ${realStars}");
              },
              step: 0.5,
              currenStars: 3.5,
            ),

            /// 第三个
            SizedBox(
              height: 20,
            ),
            Text("3. 共计5颗星, 可选任意星, 默认给4.3颗"),
            SizedBox(
              height: 5,
            ),
            FFStars(
              normalStar: Image.asset("assets/未选中圣诞节.png"),
              selectedStar: Image.asset("assets/选中圣诞节.png"),
              starsChanged: (realStars, choosedStars) {
                print("实际选择: ${choosedStars}, 最终得分: ${realStars}");
              },
              step: 0.01,
              currenStars: 4.3,
              //justShow: true,
            ),

            /// 第四个
            SizedBox(
              height: 20,
            ),
            Text("4. 共计10颗星, 只能选整星, 默认给6颗, 最低选2颗"),
            SizedBox(
              height: 5,
            ),
            FFStars(
              normalStar: Image.asset("assets/未选中蓝星.png"),
              selectedStar: Image.asset("assets/选中蓝星.png"),
              starsChanged: (realStars, choosedStars) {
                print("实际选择: ${choosedStars}, 最终得分: ${realStars}");
              },
              step: 1.0,
              currenStars: 6,
              starCount: 10,
              miniStars: 2,
            ),

            /// 第五个
            SizedBox(
              height: 20,
            ),
            Text("5. 共计5颗星, 仅做展示, 不可修改"),
            SizedBox(
              height: 5,
            ),
            FFStars(
              normalStar: Image.asset("assets/orangeNormal.png"),
              selectedStar: Image.asset("assets/orangeSelected.png"),
              currenStars: 4.7,
              justShow: true,
            ),

            /// 第六个
            SizedBox(
              height: 20,
            ),
            Text("6. 共计8颗星, 仅做展示, 不可修改"),
            SizedBox(
              height: 5,
            ),
            FFStars(
              normalStar: Image.asset("assets/未选中圣诞节.png"),
              selectedStar: Image.asset("assets/选中圣诞节.png"),
              currenStars: 7,
              justShow: true,
              starCount: 8,
            ),
          ],
        ),
      ),
    );
  }
}
