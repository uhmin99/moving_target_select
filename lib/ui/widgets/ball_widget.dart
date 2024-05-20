import 'package:flutter/material.dart';

import '../../consts/ui_consts.dart';

class BallWidget extends StatelessWidget {
  const BallWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ballSize,
      height: ballSize,
      decoration: const BoxDecoration(
        color: ballColor,
        shape: BoxShape.circle,
      ),
    );
  }
}