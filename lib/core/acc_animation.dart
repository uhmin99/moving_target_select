import 'dart:math';
import 'package:flutter/material.dart';

class AccelerationCurve extends Curve {
  final double steepness; // Add a steepness parameter

  // Constructor
  AccelerationCurve({this.steepness = 1});

  @override
  double transform(double t) {
    // Use the steepness parameter to control the acceleration
    // Higher values of steepness result in faster acceleration
    return pow(t, steepness).toDouble();
  }
}
