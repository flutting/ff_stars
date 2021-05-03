# ffstars

## 功能简介
1. 支持整星, 半星 任意星.
2. 支持点击&拖动调整, 可设置最低分.
3. 支持自定义星星图片, 大小, 间距, 数量.
4. 支持选择使用"进一法(默认)"或"四舍五入法(取最近值)"取最终值.

## 效果展示
1. 部分网络环境可能无法查看效果图.
2. git图片加载较慢, 可下载demo直接运行.
3. 如遇到Could not build the application for the simulator.请先使用flutter clean清空缓存.
<img src="https://github.com/flutting/ff_source/blob/main/ff_stars/ff_stars.gif" width="343" height="617">

### pub
```
// 集成
dependencies:
  ff_stars: ^0.1.2

// 引入
import 'package:ff_stars/ff_stars.dart';
```

## 使用方法
```
FFStars(
  normalStar: Image.asset("assets/未选中.png"),
  selectedStar: Image.asset("assets/选中.png"),
  starsChanged: (realStars, choosedStars) {
    print("实际选择: ${choosedStars}, 最终得分: ${realStars}");
  },
  step: 0.01,/// 用于设置半星(0.5), 整星(1.0), 任意星(0.01), 可在0.01 - 1.0之间自定义, 默认值为0.01
  currenStars: 4.3,/// 默认有几颗星星, 默认值为0
  // starCount: 5,/// 一共有几颗星, 默认值5
  // starHeight: 40,/// 星星的高度, 默认30
  // starWidth: 40,/// 星星的宽度,默认30
  // starMargin: 20,/// 星星间的间距, 默认10
  // justShow: true,/// 是否仅做展示, 默认false
  // rounded: true,/// 四舍五入-取最近值, 默认false(进一法)
),
```

## 主页-GitHub
```
https://github.com/flutting/ff_stars
```