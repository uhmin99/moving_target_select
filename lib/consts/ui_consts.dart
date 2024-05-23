import 'dart:ui';
import 'package:flutter/material.dart';

const Size windowSize = Size(1100, 800);

const double ballSize = 30.0;
const double ballPositionY = 100.0;

const double zonePositionX = 750.0;

const Color expBackgroundColor = Color(0xFF000000);
const Color ballColor = Color.fromARGB(255, 50, 188, 213);
const Color targetZoneBaseColor = Color.fromARGB(100, 152, 213, 50);
const Color targetZoneSuccessColor = Color.fromARGB(255, 38, 0, 255);
const Color targetZoneFailColor = Color.fromARGB(255, 255, 0, 0);
const TextStyle exp_top_indicator_style = TextStyle(fontSize: 20, color: Colors.white);