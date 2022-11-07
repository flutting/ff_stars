library ff_stars;

import 'dart:math';
import 'package:flutter/material.dart';

typedef FFStarsChanged = void Function(double realStars, double selectedStars);

class FFStars extends StatefulWidget {
  FFStars({
    required this.normalStar,
    required this.selectedStar,
    this.starCount = 5,
    this.defaultStars = 0.0,
    this.step = 0.01,
    this.rounded = false,
    this.starWidth = 30.0,
    this.starHeight = 30.0,
    this.starMargin = 10.0,
    this.miniStars = 0.0,
    this.justShow = false,
    this.starsChanged,
    this.followChange = false,
  });

  /// 未选中(默认)的星星.
  final Widget normalStar;

  /// 选中(高亮)的星星.
  final Widget selectedStar;

  /// 星星数量.
  final int starCount;

  /// 默认需要显示的星星数量(支持小数).
  final double defaultStars;

  /// 分阶, 范围0.01-1.0, 0.01表示任意星, 1.0表示整星星, 0.5表示半星, 范围内自定义.
  final double step;

  /// 星星的宽度.
  final double starWidth;

  /// 星星的高度.
  final double starHeight;

  /// 两个星星中间的间距.
  final double starMargin;

  /// 最低分, 字面意思.
  final double miniStars;

  /// 仅做展示, 如果是true则用户不可修改星星内容.
  final bool justShow;

  /// 数值发生变化的回调.
  final FFStarsChanged? starsChanged;

  /// 是否需要实时回调, 若开启, 拖动时会回调多次, 否则仅在用户操作结束后回调.
  final bool followChange;

  /// 四舍五入
  /// 默认false: 举例: step=1, 实际选择2.4则结果为: 3. step=0.5, 实际选择2.2则结果为2.5.("进一法")
  /// 为true时:  举例: step=1, 实际选择2.4则结果为: 2. step=0.5, 实际选择2.2则结果为2.0.("四舍五入-取最近值")
  final bool rounded;

  @override
  _FFStarsState createState() => _FFStarsState();
}

class _FFStarsState extends State<FFStars> {
  late double _miniStars;

  late double _currentStars;

  late double _step;

  @override
  void initState() {
    super.initState();

    /// 限制0.01 <= step <= 1.0
    _step = min(1.0, widget.step);
    _step = max(0.01, widget.step);

    /// 限制最低星不高于最高星
    _miniStars = min(widget.miniStars, widget.starCount * 1.0);

    /// 限制当前星不高于最高星
    _currentStars = min(widget.defaultStars, widget.starCount * 1.0);

    /// 限制当前星不低于最低星
    _currentStars = max(widget.defaultStars, widget.miniStars);

    this.setupRealStars(_currentStars, false, false, false);
  }

  @override
  void didUpdateWidget(FFStars oldWidget) {
    setupRealStars(widget.defaultStars, false, false, false);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Listener(
          onPointerDown: (event) {
            if (widget.justShow) {
              return;
            }
            this.calculateSelectedStars(event.localPosition.dx, false);
          },
          onPointerMove: (event) {
            if (widget.justShow) {
              return;
            }
            this.calculateSelectedStars(event.localPosition.dx, false);
          },
          onPointerUp: (event) {
            if (widget.justShow) {
              return;
            }
            this.calculateSelectedStars(event.localPosition.dx, true);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: getStars(widget.starCount, false),
          ),
        ),
        IgnorePointer(
          child: ClipRect(
            clipper: FFStarsClipper(this.getRealWidth()),
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
  void calculateSelectedStars(double width, bool needCallback) {
    /// 1.找到属于哪一颗星星
    var starIndex = (width / (widget.starWidth + widget.starMargin)).floor();

    /// 2.获取点击位置在星星的具体x坐标
    var locationX = min(
        width - starIndex * (widget.starWidth + widget.starMargin),
        widget.starWidth);

    /// 3.计算具体选中的分值.
    var selectedStars = starIndex + locationX / widget.starWidth;

    /// print("实际选择的分值为: " + selectedStars.toString());

    /// 4.计算实际得分
    this.setupRealStars(selectedStars, true, true, needCallback);
  }

  /// 设置最终的实际得分
  void setupRealStars(
      double selectedStars, bool useStep, bool reload, bool needCallback) {
    /// 1.最高分为星星个数, 最低分为自定义最低分(默认0);
    var realStars = min(widget.starCount, selectedStars);
    realStars = max(_miniStars, realStars);
    var i = realStars.floor();

    /// 2.根据分阶获取实际应该显示的分值, 用户选择的时候需要根据分阶, 开发者可以任意设置
    if (useStep == true) {
      var decimalNumber = (realStars - i);
      int floor = (decimalNumber / _step).floor();
      double remainder = decimalNumber % _step;

      if (widget.rounded == true) {
        /// 取最近值
        realStars =
            i + floor * _step + ((remainder >= _step * 0.5) ? _step : 0);
      } else {
        /// 进一法
        realStars = i + floor * _step + ((remainder > 0.0) ? _step : 0);
      }
    }
    _currentStars = (realStars * 100).floor() / 100;

    /// 3.更新星星展示效果并回调
    if (reload == true) {
      setState(() {});
      if (needCallback == false && widget.followChange == false) {
        return;
      }
      if (widget.starsChanged == null) {
        return;
      }
      widget.starsChanged!(_currentStars, selectedStars);
    }
  }

  /// 获取实际宽度
  double getRealWidth() {
    var i = _currentStars.floor();
    var width = (widget.starWidth + widget.starMargin) * i +
        (_currentStars - i) * widget.starWidth;
    return width;
  }

  /// 获取要显示的所有星星
  List<Widget> getStars(int count, bool selected) {
    return List.generate(max(count * 2 - 1, 0), (index) {
      if (index % 2 == 0) {
        return Container(
          width: widget.starWidth,
          height: widget.starHeight,
          child: selected ? widget.selectedStar : widget.normalStar,
        );
      }

      return Container(
        width: widget.starMargin,
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
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    if (oldClipper is FFStarsClipper) {
      return oldClipper.width != this.width;
    }
    return false;
  }
}
