library ff_stars;

import 'dart:math';
import 'package:flutter/material.dart';

class FFStars extends StatefulWidget {
  /// 星星数量
  int count = 5;

  /// 当前/需要显示的星星数量(支持小数)
  double currentValue = 5.0;

  /// 分阶段, 范围0.0-1.0, 0.0表示任意星, 1.0表示整星星, 0.5表示半星, 范围内自定义.
  double step = 0.01;

  /// 星星的宽度
  double starWidth = 30;

  /// 星星的高度
  double starHeight = 30;

  /// 两个星星中间的间距
  double starMargin = 10;

  /// 最低分, 字面意思
  double miniScore = 0;

  @override
  _FFStarsState createState() => _FFStarsState();
}

class _FFStarsState extends State<FFStars> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  double _width = 0;

  @override
  Widget build(BuildContext context) {
    // print("最外层的build方法被执行了!");
    return Stack(
      children: [
        GestureDetector(
          onTapDown: (details) {
            this.calculateChoosedScore(details.localPosition.dx);
          },
          onPanUpdate: (details) {
            this.calculateChoosedScore(details.localPosition.dx);
            setState(() {});
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: getStars(widget.count, Colors.black12.withOpacity(0.3)),
          ),
        ),
        IgnorePointer(
          child: ClipRect(
            clipper: FFStarsClipper(this._width),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: getStars(widget.count, Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  /// 计算实际选择了多少分
  void calculateChoosedScore(double width) {
    /// 1.找到属于哪一颗星星
    var starIndex = (width / (widget.starWidth + widget.starMargin)).floor();

    /// 2.获取点击位置在星星的具体x坐标
    var locationX = min(width - starIndex * (widget.starWidth + widget.starMargin), widget.starWidth);

    /// 3.计算具体选中的分值.
    var choosedScore = starIndex + locationX / widget.starWidth;
    print("实际选择的分值为: " + choosedScore.toString());

    /// 4.计算实际得分
    this.setupRealScore(choosedScore, true);
  }

  /// 设置最终的实际得分
  void setupRealScore(double choosedValue, bool useStep) {
    /// 1.最高分为星星个数, 最低分为自定义最低分(默认0);
    var realScore = min(widget.count, choosedValue);
    realScore = max(widget.miniScore, realScore);
    var i = realScore.floor();

    if (useStep == true) {/// 用户选择的时候需要根据分阶, 开发者可以任意设置
      /// 2.根据分阶获取实际应该显示的分支
      var decimalNumber = (realScore - i);
      int floor = (decimalNumber / widget.step).floor();
      double remainder = (decimalNumber % widget.step);
      realScore = i + floor * widget.step + ((remainder > widget.step * 0.5) ? widget.step : 0);
    }

    print("最终得分为: " + realScore.toString());

    /// 3.计算实际要显示的宽度(星星)
    var width = (widget.starWidth + widget.starMargin) * i + (realScore - i) * widget.starWidth;
    this._width = width;

    /// 4.更新星星展示效果
    setState(() {});
  }

  /// 获取要显示的所有星星
  List<Widget> getStars(int count, Color color) {
    return List.generate(max(count * 2 - 1, 0), (index) {
      if (index % 2 == 0) {
        return Container(
          color: color,
          width: widget.starWidth,
          height: widget.starHeight,
        );
      }
      /// emmm, 必须给个颜色(透明), 否则不会接受事件, 奇怪的设定
      return Container(width: 10, height: widget.starHeight, color: Colors.transparent,);
    });
  }
}

/// 剪切部分
class FFStarsClipper extends CustomClipper<Rect> {
  FFStarsClipper(this.width);

  double width;

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(covariant FFStarsClipper oldClipper) {
    return oldClipper.width != this.width;
  }
}
