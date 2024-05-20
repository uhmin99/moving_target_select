import 'package:flutter/material.dart';

class AcceleratingCurve extends Curve {
  final double a;

  AcceleratingCurve(this.a);

  @override
  double transform(double t) {
    return 0.5 * a * t * t; // Normalized for t in [0, 1]
  }
}

