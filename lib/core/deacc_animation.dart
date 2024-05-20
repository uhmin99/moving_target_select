import 'package:flutter/material.dart';

class DeceleratingCurve extends Curve {
  final double a;

  DeceleratingCurve(this.a);

  @override
  double transform(double t) {
    return 1 - 0.5 * a * t * t; // Normalized for t in [0, 1]
  }
}


// class DeceleratingCurve extends Curve {
//   final double v0; // Initial velocity
//   final double a; // Acceleration, should be negative for deceleration
//   final double duration; // Duration over which the deceleration happens

//   DeceleratingCurve(this.v0, this.a, this.duration);

//   @override
//   double transform(double t) {
//     // Calculate actual time based on normalized time t
//     double actualTime = t * duration;
//     // Calculate the position at this time
//     double position = v0 * actualTime + 0.5 * a * actualTime * actualTime;
//     // Normalize the position based on the total change expected over the full duration
//     double totalChange = v0 * duration + 0.5 * a * duration * duration;
//     // Normalize to return a value between 0 and 1
//     return position / totalChange;
//   }
// }