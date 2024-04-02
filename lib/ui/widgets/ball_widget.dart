import 'package:flutter/material.dart';

import '../../consts/ui_consts.dart';

class BallWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ballSize,
      height: ballSize,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
    );
  }
}