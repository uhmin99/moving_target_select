import 'package:flutter/animation.dart';

class MotionCurve extends Curve {
  final double v0; // Initial velocity
  final double a; // Acceleration
  final double x0; // Initial position
  final double duration; // Total duration of the motion in seconds

  MotionCurve({required this.v0, required this.a, required this.x0, required this.duration});

  @override
  double transform(double t) {
    // Normalize time t to actual time in seconds
    double actualTime = t * duration;
    // Apply the equation x(t) = x0 + v0*t + 0.5*a*t^2
    double position = x0 + v0 * actualTime + 0.5 * a * actualTime * actualTime;
    // Normalize position to range within starting and ending positions
    // Assuming the motion ends at 0 when x(t) = targetX
    double targetX = x0 + v0 * duration + 0.5 * a * duration * duration;
    return (position - x0) / (targetX - x0);
  }
}