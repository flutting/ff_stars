# ff_stars

## Function Introduction
1. Support the full star, half-star arbitrary star.
2. Support Click & Drag and adjust to set the minimum points.
3. Support custom stars pictures, size, spacing, quantity.
4. Support choice uses "Enter Act (default)" or "Since the Four Raidth (Recent Value)" to take the final value.

## Show results
1. Some network environments may not be able to view the renderings.
2. Git picture is slower, download Demo directly.
3. If you encounter "Could not build the application for the simulator", please use "flutter clean".
   <img src="https://github.com/flutting/ff_source/blob/main/ff_stars/ff_stars.gif" width="343" height="617">

### pub
```
// integrated
dependencies:
  ff_stars: ^1.6.0 // Support null safety (continuous maintenance)
  ff_stars: ^0.1.6 // Do not support null safety (follow-up no longer maintenance)

// Introduce
import 'package:ff_stars/ff_stars.dart';
```

## Instructions
```
FFStars(
  normalStar: Image.asset("assets/normalImage.png"),
  selectedStar: Image.asset("assets/selectedImage.png"),
  starsChanged: (realStars, selectedStars) {
    print("real: $selectedStars, final: $realStars");
  },
  step: 0.01,
  defaultStars: 3.5,
  // starCount: 5,
  // starHeight: 40,
  // starWidth: 40,
  // starMargin: 20,
  // justShow: true,
  // rounded: true,
  // followChange: true,
),
```

## GitHub
```
https://github.com/flutting/ff_stars
```