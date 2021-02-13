# ffstars

## 功能简介
1. 支持整星, 半星 任意星.
2. 支持点击&拖动调整, 可设置最低分.
3. 支持自定义星星图片, 大小, 间距, 数量.

## 效果截图
<img src="https://github.com/flutting/ZZResources/blob/master/ZZResources/flutter/flutter_stars.png" width="300" height="520">

### 普通引用
下载demo, 将ff_stars.dart引入到项目中即可使用.
```
import 'package:你存放的路径/ff_stars.dart';
```

### pub集成(正在开通)
```
import 'package:ff_stars/ff_stars.dart';
```

## 使用方法

```
FFStars(
  normalStar: Image.asset("assets/你的未选中图.png"),
  selectedStar: Image.asset("assets/你的选中图.png"),
  starsChanged: (realStars, choosedStars) {
    print("实际选择: ${choosedStars}, 最终得分: ${realStars}");
  },
  step: 0.01,/// 用于设置半星(0.5), 整星(1.0), 任意星(0.01), 可在0.01 - 1.0之间自定义, 默认值为0.01
  currenStars: 4.3,/// 默认有几颗星星, 默认值为0
  // starCount: 5,/// 一共有几颗星, 默认值5
  // starHeight: 40,/// 星星的高度, 默认30
  // starWidth: 40,/// 星星的宽度,默认30
  // starMargin: 20,/// 星星间的间距, 默认10
  //justShow: true,/// 是否仅做展示, 默认false
),
```