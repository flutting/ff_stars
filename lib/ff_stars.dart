library ff_stars;

import 'dart:math';
import 'package:flutter/material.dart';

typedef FFStarsChanged = void Function(double realStars, double choosedStars);

class FFStars extends StatefulWidget {
  FFStars({
    @required this.normalStar,
    @required this.selectedStar,
    this.starCount = 5,
    this.currenStars = 0.0,
    this.step = 0.01,
    this.starWidth = 30.0,
    this.starHeight = 30.0,
    this.starMargin = 10.0,
    this.miniStars = 0.0,
    this.justShow = false,
    this.starsChanged,
  })  : assert(normalStar != null),
        assert(selectedStar != null);

  /// 选中的星星
  Widget normalStar;

  /// 选中(高亮)的星星
  Widget selectedStar;

  /// 星星数量
  int starCount;

  /// 当前/需要显示的星星数量(支持小数)
  double currenStars;

  /// 分阶, 范围0.0-1.0, 0.0表示任意星, 1.0表示整星星, 0.5表示半星, 范围内自定义.
  double step;

  /// 星星的宽度
  double starWidth;

  /// 星星的高度
  double starHeight;

  /// 两个星星中间的间距
  double starMargin;

  /// 最低分, 字面意思
  double miniStars;

  /// 仅做展示,  如果是true则用户不可修改星星内容
  bool justShow;

  FFStarsChanged starsChanged;

  @override
  _FFStarsState createState() => _FFStarsState();
}

class _FFStarsState extends State<FFStars> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.setupRealStars(widget.currenStars, false, false);
  }

  double _width = 0;

  @override
  Widget build(BuildContext context) {
    // print("最外层的build方法被执行了!");
    return Stack(
      children: [
        GestureDetector(
          onTapDown: (details) {
            if (widget.justShow) {
              return;
            }
            this.calculateChoosedStars(details.localPosition.dx);
          },
          onPanUpdate: (details) {
            if (widget.justShow) {
              return;
            }
            this.calculateChoosedStars(details.localPosition.dx);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: getStars(widget.starCount, false),
          ),
        ),
        IgnorePointer(
          child: ClipRect(
            clipper: FFStarsClipper(this._width),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: getStars(widget.starCount, true),
            ),
          ),
        ),
      ],
    );
  }

  /// 计算实际选择了多少分
  void calculateChoosedStars(double width) {
    /// 1.找到属于哪一颗星星
    var starIndex = (width / (widget.starWidth + widget.starMargin)).floor();

    /// 2.获取点击位置在星星的具体x坐标
    var locationX = min(width - starIndex * (widget.starWidth + widget.starMargin), widget.starWidth);

    /// 3.计算具体选中的分值.
    var choosedStars = starIndex + locationX / widget.starWidth;

    /// print("实际选择的分值为: " + choosedStars.toString());

    /// 4.计算实际得分
    this.setupRealStars(choosedStars, true, true);
  }

  /// 设置最终的实际得分
  void setupRealStars(double choosedStars, bool useStep, bool reload) {
    /// 1.最高分为星星个数, 最低分为自定义最低分(默认0);
    var realStars = min(widget.starCount, choosedStars);
    realStars = max(widget.miniStars, realStars);
    var i = realStars.floor();

    /// 2.根据分阶获取实际应该显示的分值, 用户选择的时候需要根据分阶, 开发者可以任意设置
    if (useStep == true) {
      var decimalNumber = (realStars - i);
      int floor = (decimalNumber / widget.step).floor();
      double remainder = (decimalNumber % widget.step);
      realStars = i + floor * widget.step + ((remainder > widget.step * 0.5) ? widget.step : 0);
    }
    realStars = (realStars * 100).floor() / 100;

    /// 3.计算实际要显示的宽度(星星)
    var width = (widget.starWidth + widget.starMargin) * i + (realStars - i) * widget.starWidth;
    this._width = width;

    /// 4.更新星星展示效果并回调
    if (reload == true) {
      setState(() {});
      if (widget.starsChanged == null) {
        return;
      }
      widget.starsChanged(realStars, choosedStars);
    }
  }

  /// 获取要显示的所有星星
  List<Widget> getStars(int count, bool selected) {
    return List.generate(max(count * 2 - 1, 0), (index) {
      if (index % 2 == 0) {
        return Container(
          // color: selected ? Colors.red : Colors.black12.withOpacity(0.1),
          width: widget.starWidth,
          height: widget.starHeight,
          child: selected ? widget.selectedStar : widget.normalStar,
        );
      }

      return Container(
        width: 10,
        height: widget.starHeight,
        color: Colors.transparent,
      );
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
