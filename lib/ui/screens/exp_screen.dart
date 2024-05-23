import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:moving_target_select/consts/core_consts.dart';
import 'package:moving_target_select/ui/screens/exp_vm.dart';
import 'package:provider/provider.dart';

import '../../consts/ui_consts.dart';
import '../../entity/exp_entity.dart';
import '../states/exp_states.dart';
import '../widgets/ball_widget.dart';
import 'finish_screen.dart';


class ExpScreen extends StatefulWidget {
  final ExpEntity expEnv;
  final int trialCount;
  final bool isFirst;

  const ExpScreen({super.key, required this.expEnv, required this.trialCount, required this.isFirst});

  @override
  _ExpScreenState createState() => _ExpScreenState();
}

class _ExpScreenState extends State<ExpScreen> with SingleTickerProviderStateMixin {
  late AnimationController _ballController;
  late Animation _animation;
  final FocusNode _focusNode = FocusNode();

  late DateTime _startTime;
  DateTime? _ballAppreanceTime;
  DateTime? _pressTime;
  DateTime? _ballZoneArrivalTime;
  DateTime? _ballZoneLeaveTime;
  
  Color _targetZoneColor = targetZoneBaseColor;
  bool _isBallVisible = true;
  bool _expPaused = false;

  void _startTrialWithDelay() {
    Future.delayed(Duration(milliseconds: widget.expEnv.targetAppearancePeriod.toInt()), () {
      if (_expPaused) {
        return;
      }
      setState(() {
        _isBallVisible = true;
      });
      _ballAppreanceTime = DateTime.now();
      _ballController.forward();
    });
  }

  void startBallMovement(BuildContext context) {
    if(widget.isFirst){
      setState(() {
        _isBallVisible = false;
      });
      Future.delayed(Duration(milliseconds: startBufferTime), () {
        setState(() {
          _isBallVisible = true;
        });
        _ballController.forward();
        _startTime = DateTime.now();
        _ballAppreanceTime = DateTime.now();
      });

    } else {
      _ballController.forward();
      _startTime = DateTime.now();
      _ballAppreanceTime = DateTime.now();
    }
  }

  void toNextExpInTiming(BuildContext context){
    int nextExpTime;
    if(widget.isFirst){
      nextExpTime = widget.expEnv.targetAppearancePeriod.toInt() + startBufferTime;
    } else {
      nextExpTime = widget.expEnv.targetAppearancePeriod.toInt();
    }
    
    Future.delayed(Duration(milliseconds: nextExpTime), () {
      if (_expPaused) {
        return;
      }
      ExpResultEntity expResultData = ExpResultEntity(
        expEntity: widget.expEnv,
        trialNum: widget.trialCount,
        success: true,
        errorType: ErrorType.no_error_success,
        targetAppearanceTime: _ballAppreanceTime,
        buttonPressTime: _pressTime
      );
      context.read<ExpResultState>().append(expResultData);
      moveToNextTrial(context);
    });
  }

  void showSuccess(BuildContext context) {
    // setState(() {
    //   _targetZoneColor = targetZoneSuccessColor;
    // });
  }

  void showFailed(ErrorType errorType) {
    // setState(() {
    //   _targetZoneColor = targetZoneFailColor;
    // });
  }

  void moveToNextTrial(BuildContext context) {
    if (context.read<ExpReserveState>().isEmpty()) {
      // If there are no more experiments, finish the experiment
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FinishScreen()),
      );
      return;

    } else {
      if(widget.trialCount < TRIAL_PER_EXP){
        // Move to the next trial in the same experiment
        int nextTrialCount = widget.trialCount + 1;
        Future.delayed(Duration(milliseconds: freezePerTrialMilli), () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => ExpScreen(expEnv: widget.expEnv, trialCount: nextTrialCount, isFirst: false),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            )
          );
        });
        return;
      } else {
        context.read<ExpReserveState>().removeFirst();  // Pop after finishing the current experiment
        if (context.read<ExpReserveState>().isEmpty()) {
          // If there are no more experiments, finish the experiment
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FinishScreen()),
          );
          return;
        }
        // Move to the next experiment
        ExpEntity nextExp = context.read<ExpReserveState>().getFirst();
        Future.delayed(Duration(milliseconds: freezePerTrialMilli), () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => ExpScreen(expEnv: nextExp, trialCount: 1, isFirst: false),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            )
          );
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _focusNode.requestFocus();
    int durationForSpeed = getBallSpeedDuration(widget.expEnv);
    _ballController = AnimationController(
      duration: Duration(milliseconds: durationForSpeed), // Adjust as needed
      vsync: this,
    );

    final CurvedAnimation curvedAnimation = CurvedAnimation(parent: _ballController, curve: getCurveType(widget.expEnv));

    double ballStartingPoint = getStartingPoint(widget.expEnv);
    double ballEndingPoint = zonePositionX;
    _animation = Tween(begin: ballStartingPoint, end: ballEndingPoint).animate(curvedAnimation)
      ..addListener(() {
        // print(_animation.value);
        if(_ballZoneArrivalTime == null && _animation.value >= zonePositionX){
          _ballZoneArrivalTime = DateTime.now();
          // print('Zone Arrived!');
        }
        if(_ballZoneLeaveTime == null && _animation.value >= zonePositionX + getZoneWidth(widget.expEnv)){
          _ballZoneLeaveTime = DateTime.now();
          // print('Zone Left!');
        }
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _ballController.stop();
          setState(() {
            _isBallVisible = false;
          });
          showFailed(ErrorType.no_press);
          // DateTime endTime = DateTime.now();
          // ExpResultEntity failedData = ExpResultEntity(
          //   expEntity: widget.expEnv,
          //   trialNum: widget.trialCount,
          //   success: false,
          //   timingAccuracy: endTime.difference(_startTime).inMilliseconds.toDouble(),
          //   errorType: ErrorType.no_press,
          //   targetAppearanceTime: _ballAppreanceTime,
          //   zoneArrivalTime: _ballZoneArrivalTime,
          //   zoneLeaveTime: _ballZoneLeaveTime,
          //   buttonPressTime: _pressTime
          // );
          // context.read<ExpResultState>().append(failedData);
          // moveToNextTrial(context);
        } else if (status == AnimationStatus.dismissed) {
          _ballController.forward();
        }
      });

    startBallMovement(context);
    toNextExpInTiming(context);
  }

  @override
  Widget build(BuildContext context) {
    double _zoneWidth = getZoneWidth(widget.expEnv);

    return Scaffold(
      backgroundColor: expBackgroundColor,
      body: Focus(
        autofocus: true,
        focusNode: _focusNode,
        onKey: (FocusNode node, RawKeyEvent event) {
          if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.space) {
            // setTime for the press
            if(_pressTime==null) _pressTime = DateTime.now();
            DateTime endTime = DateTime.now();
            _ballController.stop();

            // Check if the ball is within the target zone
            // if (_animation.value + ballSize/2 >= zonePositionX && _animation.value + ballSize/2 <= zonePositionX + _zoneWidth) {
              // showSuccess(context);
              // ExpResultEntity successData = ExpResultEntity(
              //   expEntity: widget.expEnv,
              //   trialNum: widget.trialCount,
              //   success: true,
              //   timingAccuracy: endTime.difference(_startTime).inMilliseconds.toDouble(),
              //   errorType: ErrorType.no_error_success,
              //   targetAppearanceTime: _ballAppreanceTime,
              //   zoneArrivalTime: _ballZoneArrivalTime,
              //   zoneLeaveTime: _ballZoneLeaveTime,
              //   buttonPressTime: _pressTime
              // );
              // context.read<ExpResultState>().append(successData);
              // moveToNextTrial(context);
            // } else {
              // ErrorType failType;
              // if (_animation.value < zonePositionX) {
              //   failType = ErrorType.early;
              // } else {
              //   failType = ErrorType.late;
              // }
              // showFailed(failType);
              // ExpResultEntity failedData = ExpResultEntity(
              //   expEntity: widget.expEnv,
              //   trialNum: widget.trialCount,
              //   success: false,
              //   timingAccuracy: endTime.difference(_startTime).inMilliseconds.toDouble(),
              //   errorType: failType,
              //   targetAppearanceTime: _ballAppreanceTime,
              //   zoneArrivalTime: _ballZoneArrivalTime,
              //   zoneLeaveTime: _ballZoneLeaveTime,
              //   buttonPressTime: _pressTime
              // );
              // context.read<ExpResultState>().append(failedData);
              // moveToNextTrial(context);
            // }
            return KeyEventResult.handled;

          } else if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.escape) {
            if(_animation.isCompleted) return KeyEventResult.handled;

            // If the user presses the escape key and animation is not complete, pause the experiment
            _ballController.stop();
            _expPaused = true;

            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('일시정지'),
                  content: Text('"Resume"을 눌러서 실험을 계속하세요.'),
                  actions: [
                    TextButton(
                      child: const Text('Resume'),
                      onPressed: () {
                        _expPaused = false;
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) => ExpScreen(expEnv: widget.expEnv, trialCount: widget.trialCount, isFirst: false,),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          )
                        );
                      },
                    ),
                  ],
                );
              },
            );

            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                left: _animation.value,
                top: ballPositionY,
                child: Visibility(
                  visible: _isBallVisible,
                  child: const BallWidget(),
                )
              ),
              Positioned(
                left: zonePositionX,
                top: 0,
                bottom: 0,
                child: Container(
                  width: _zoneWidth,
                  color: _targetZoneColor,
                ),
              ),
              Positioned(
                top: 10, // Adjust the position as needed
                left: 100,
                child: Column(
                  children: [
                    // Text(
                    //   context.watch<UserInfoState>().name,
                    //   style: exp_top_indicator_style
                    // ),
                    Text(
                      'Round : ${(accExpList.length + deAccExpList.length + uniSpeedExpList.length)-context.read<ExpReserveState>().getLength() + 1} / ${accExpList.length + deAccExpList.length + uniSpeedExpList.length}',
                      style: exp_top_indicator_style,
                    ),
                    Text(
                      'Trial : ${widget.trialCount}/${TRIAL_PER_EXP}',
                      style: exp_top_indicator_style
                    ),
                    Text(
                      'Type : ${expTypeToString(widget.expEnv.expType)}, Appear : ${widget.expEnv.targetAppearancePeriod} ms, Stay : ${widget.expEnv.zoneStayTime} ms, Arrival : ${widget.expEnv.zoneArrivalTime} ms',
                      style: exp_top_indicator_style
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