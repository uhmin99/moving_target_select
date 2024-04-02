import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moving_target_select/consts/core_consts.dart';
import 'package:provider/provider.dart';

import '../../consts/ui_consts.dart';
import '../../core/acc_animation.dart';
import '../states/exp_states.dart';
import '../widgets/ball_widget.dart';
import 'finish_screen.dart';

class ExpScreen extends StatefulWidget {
  const ExpScreen({super.key});

  @override
  _ExpScreenState createState() => _ExpScreenState();
}

class _ExpScreenState extends State<ExpScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // Adjust as needed
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: AccelerationCurve(steepness: 2), // Use your custom curve here
    );

    _animation = Tween(begin: 0.0, end: windowSize.width+ballSize).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Focus(
        autofocus: true,
        focusNode: _focusNode,
        onKey: (FocusNode node, RawKeyEvent event) {
          if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.space) {            
            // Check if the ball is within the target zone
            if (_animation.value >= targetZoneStart && _animation.value <= targetZoneStart + targetZoneWidth - ballSize) {
              // Success
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('성공', style: TextStyle(color: Colors.green)),
                    content: Text('Target을 맞추었습니다.\n\nOk를 눌러서 다음으로 진행하세요.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          var successData = [{
                            'name': context.read<UserNameState>().name,
                            'result': 'success',
                          }];
                          toNextExperiment(context, successData);
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              // Failure
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('실패', style: TextStyle(color: Colors.red)),
                    content: Text('Target을 못 맞추었습니다.\n\nOk를 눌러서 다음으로 진행하세요.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          var failedData = [{
                            'name': context.read<UserNameState>().name,
                            'result': 'failed',
                          }];
                          toNextExperiment(context, failedData);
                        },
                      ),
                    ],
                  );
                },
              );
            }

            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: _animation.value,
                top: 100, // Adjust the position as needed
                child: BallWidget(),
              ),
              Positioned(
                left: targetZoneStart, // Align to the right side
                top: 0,
                bottom: 0,
                child: Container(
                  width: targetZoneWidth,
                  color: Colors.red.withOpacity(0.5), // Semi-transparent target zone
                ),
              ),
              Positioned(
                top: 10, // Adjust the position as needed
                left: windowSize.width / 2 - 50,
                child: Column(
                  children: [
                    Text(
                      context.watch<UserNameState>().name,
                      style: const TextStyle(fontSize: 20, color: Colors.grey)
                    ),
                    Text(
                      '${(accExpList.length + deAccExpList.length + uniSpeedExpList.length) - context.read<ExpReserveState>().getLength()}/${accExpList.length + deAccExpList.length + uniSpeedExpList.length}',
                      style: const TextStyle(fontSize: 20, color: Colors.grey)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

void toNextExperiment(BuildContext context, var thisData) {
  context.read<ExpResultState>().append(thisData);

  if (context.read<ExpReserveState>().isEmpty()) {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FinishScreen()),
    );
  } else {
    context.read<ExpReserveState>().removeLast();
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExpScreen()),
    );
  }
}