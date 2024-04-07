import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moving_target_select/consts/core_consts.dart';
import 'package:provider/provider.dart';

import '../../consts/ui_consts.dart';
import '../../entity/exp_entity.dart';
import '../states/exp_states.dart';
import '../widgets/ball_widget.dart';
import 'finish_screen.dart';

class ExpScreen extends StatefulWidget {
  final ExpEntity expEnv;
  // ExpEntity(, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionClose, initSpeed: InitSpeedSlow);

  const ExpScreen({super.key, required this.expEnv});

  @override
  _ExpScreenState createState() => _ExpScreenState();
}

class _ExpScreenState extends State<ExpScreen> with SingleTickerProviderStateMixin {
  late AnimationController _ballController;
  late Animation _animation;
  FocusNode _focusNode = FocusNode();
  late DateTime _startTime;
  

  @override
  void initState() {
    super.initState();

    _focusNode.requestFocus();
    _ballController = AnimationController(
      duration: const Duration(seconds: 5), // Adjust as needed
      vsync: this,
    );

    final CurvedAnimation curvedAnimation;

    if(widget.expEnv.expType==ExpType.acc){
      Curve curvetype;
      if(widget.expEnv.speed == SpeedType.slow){
        curvetype = Curves.easeInCubic;
      } else {
        curvetype = Curves.easeInExpo;
      }
      curvedAnimation = CurvedAnimation(parent: _ballController, curve: curvetype);
    } else if(widget.expEnv.expType==ExpType.deAcc){
      Curve curvetype;
      if(widget.expEnv.speed == SpeedType.slow){
        curvetype = Curves.easeOutCubic;
      } else {
        curvetype = Curves.easeOutExpo;
      }
      curvedAnimation = CurvedAnimation(parent: _ballController, curve: curvetype);
    } else {
      curvedAnimation = CurvedAnimation(parent: _ballController, curve: Curves.linear);
    }

    _animation = Tween(begin: 0.0, end: windowSize.width+ballSize).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _ballController.stop();
          showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('실패', style: TextStyle(color: Colors.red)),
                    content: const Text('Target을 못 맞추었습니다.\n\nOk를 눌러서 다음으로 진행하세요.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          ExpResultEntity failedData = ExpResultEntity(
                            expEntity: widget.expEnv,
                            success: false,
                            timingAccuracy: TIMING_UNPRESSED,
                            errorType: ErrorType.miss
                          );
                          toNextExperiment(context, failedData);
                        },
                      ),
                    ],
                  );
                },
              );
        } else if (status == AnimationStatus.dismissed) {
          _ballController.forward();
        }
      });

    _startTime = DateTime.now();

    _ballController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Focus(
        autofocus: true,
        focusNode: _focusNode,
        onKey: (FocusNode node, RawKeyEvent event) {
          if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.space) {        
            DateTime endTime = DateTime.now();
            _ballController.stop();
            // Check if the ball is within the target zone
            if (_animation.value >= widget.expEnv.zonePositionX && _animation.value <= widget.expEnv.zonePositionX + widget.expEnv.zoneWidth - ballSize) {
              // Success
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('성공', style: TextStyle(color: Colors.green)),
                    content: const Text('Target을 맞추었습니다.\n\nOk를 눌러서 다음으로 진행하세요.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          ExpResultEntity successData = ExpResultEntity(
                            expEntity: widget.expEnv,
                            success: true,
                            timingAccuracy: endTime.difference(_startTime).inMilliseconds.toDouble(),
                            errorType: ErrorType.no_error_success
                          );
                          toNextExperiment(context, successData);
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              ErrorType failType;
              if (_animation.value < widget.expEnv.zonePositionX) {
                failType = ErrorType.early;
              } else {
                failType = ErrorType.late;
              }
              // Failure
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('실패', style: TextStyle(color: Colors.red)),
                    content: const Text('Target을 못 맞추었습니다.\n\nOk를 눌러서 다음으로 진행하세요.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          ExpResultEntity failedData = ExpResultEntity(
                            expEntity: widget.expEnv,
                            success: false,
                            timingAccuracy: endTime.difference(_startTime).inMilliseconds.toDouble(),
                            errorType: failType
                          );
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
                left: widget.expEnv.zonePositionX, // Align to the right side
                top: 0,
                bottom: 0,
                child: Container(
                  width: widget.expEnv.zoneWidth,
                  color: Colors.red.withOpacity(0.5), // Semi-transparent target zone
                ),
              ),
              Positioned(
                top: 10, // Adjust the position as needed
                left: windowSize.width / 2 - 50,
                child: Column(
                  children: [
                    Text(
                      context.watch<UserInfoState>().name,
                      style: const TextStyle(fontSize: 20, color: Colors.grey)
                    ),
                    Text(expTypeToString(widget.expEnv.expType), style: const TextStyle(fontSize: 20, color: Colors.grey)),
                    Text(
                      '${(accExpList.length + deAccExpList.length + uniSpeedExpList.length) - context.read<ExpReserveState>().getLength() + 1}/${accExpList.length + deAccExpList.length + uniSpeedExpList.length}',
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
    _ballController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

void toNextExperiment(BuildContext context, ExpResultEntity thisData) {
  context.read<ExpResultState>().append(thisData);

  if (context.read<ExpReserveState>().isEmpty()) {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FinishScreen()),
    );
  } else {
    context.read<ExpReserveState>().removeFirst();  // Pop after finishing the current experiment
    if (context.read<ExpReserveState>().isEmpty()) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FinishScreen()),
      );
      return;
    }
    ExpEntity nextExp = context.read<ExpReserveState>().getFirst();
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExpScreen(expEnv: nextExp,)),
    );
  }
}