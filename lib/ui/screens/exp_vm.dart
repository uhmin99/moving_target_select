import 'package:flutter/material.dart';
import 'package:moving_target_select/core/deacc_animation.dart';

import '../../consts/core_consts.dart';
import '../../consts/ui_consts.dart';
import '../../core/acc_animation.dart';
import '../../core/motion_curve.dart';
import '../../entity/exp_entity.dart';

Curve getCurveType(ExpEntity expEnv) {
  Curve curveType;
  if(expEnv.expType==ExpType.acc){
    // curveType = MotionCurve(v0: initSpeepdAcc, a: accelerationRate, x0: initialPosition, duration: expEnv.zoneArrivalTime / 1000);
    // curveType = AcceleratingCurve(accelerationRate);
    curveType = Curves.easeInCubic;
  } else if(expEnv.expType==ExpType.deAcc){
    // curveType = DeceleratingCurve(initSpeedDeAcc, deccelerationRate, expEnv.zoneArrivalTime / 1000);
    // curveType = DeceleratingCurve(deccelerationRate);
    curveType = Curves.linearToEaseOut;
  } else {
    curveType = Curves.linear;
  }
  return curveType;
}



double getStartingPoint(ExpEntity expEnv) {
  double offsetForShort = 90;
  if(expEnv.zoneArrivalTime == zoneArrivalTime_Short){
    return zonePositionX - 50;
  } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Medium){
    return zonePositionX - 250;
  } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Long){
    return zonePositionX - 600;
  } else {
    return 0;
  }
  double startingPoint;

  if(expEnv.expType==ExpType.acc){
    if(expEnv.zoneArrivalTime == zoneArrivalTime_Short){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        startingPoint = 430;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        startingPoint = 430;
      } else {
        startingPoint = 0;
      }
    

    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Medium){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        startingPoint = 430;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        startingPoint = 435;
      } else {
        startingPoint = 0;
      }
      
    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Long){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        startingPoint = 390;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        startingPoint = 420;
      } else {
        startingPoint = 0;
      }

    } else {
      startingPoint = 0;
    }
  
  } else if(expEnv.expType==ExpType.deAcc){
    if(expEnv.zoneArrivalTime == zoneArrivalTime_Short){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        startingPoint = 370;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        startingPoint = 365;
      } else {
        startingPoint = 0;
      }

    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Medium){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        startingPoint = 290;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        startingPoint = 300;
      } else {
        startingPoint = 0;
      }
      
    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Long){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        startingPoint = 275;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        startingPoint = 275;
      } else {
        startingPoint = 0;
      }

    } else {
      startingPoint = 0;
    }

  } else if(expEnv.expType==ExpType.uniSpeed){
    if(expEnv.zoneArrivalTime == zoneArrivalTime_Short){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        startingPoint = 395;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        startingPoint = 392;
      } else {
        startingPoint = 0;
      }
    

    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Medium){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        startingPoint = 355;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        startingPoint = 355;
      } else {
        startingPoint = 0;
      }
      
    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Long){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        startingPoint = 240;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        startingPoint = 250;
      } else {
        startingPoint = 0;
      }

    } else {
      startingPoint = 0;
    }
  
  } else {
    startingPoint = 0;
  }
  return startingPoint;
}

int getBallSpeedDuration(ExpEntity expEnv) {
  return expEnv.zoneArrivalTime.toInt();
  // bigger the value, slower the ball speed
  int ballSpeedDuration;
  if(expEnv.expType==ExpType.acc){
    if(expEnv.zoneArrivalTime == zoneArrivalTime_Short){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 15 ;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 25;
      } else {
        ballSpeedDuration = 0;
      }
      
    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Medium){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 50;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 55;
      } else {
        ballSpeedDuration = 0;
      }
      
    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Long){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 70;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 65;
      } else {
        ballSpeedDuration = 0;
      }
      
    } else {
      ballSpeedDuration = 0;
    }
    
  } else if(expEnv.expType==ExpType.deAcc){
    if(expEnv.zoneArrivalTime == zoneArrivalTime_Short){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 275;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 275;
      } else {
        ballSpeedDuration = 0;
      }
      
    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Medium){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 370;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 370;
      } else {
        ballSpeedDuration = 0;
      }
      
    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Long){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 400;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 400;
      } else {
        ballSpeedDuration = 0;
      }
      
    } else {
      ballSpeedDuration = 0;
    }
    
  } else if(expEnv.expType==ExpType.uniSpeed){
    if(expEnv.zoneArrivalTime == zoneArrivalTime_Short){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 130;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 130;
      } else {
        ballSpeedDuration = 0;
      }
      
    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Medium){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 130;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 130;
      } else {
        ballSpeedDuration = 0;
      }
      
    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Long){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 70;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        ballSpeedDuration = expEnv.zoneArrivalTime.toInt() + expEnv.zoneStayTime.toInt() + 60;
      } else {
        ballSpeedDuration = 0;
      }
      
    } else {
      ballSpeedDuration = 0;
    }

  } else {
    ballSpeedDuration = 0;
  }

  return ballSpeedDuration;
}


double getZoneWidth(ExpEntity expEnv) {
  return 5;
  double zoneWidth;
  if(expEnv.expType==ExpType.acc){
    if(expEnv.zoneArrivalTime == zoneArrivalTime_Short){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        zoneWidth = 345;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        zoneWidth = 395;
      } else {
        zoneWidth = 0;
      }
    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Medium){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        zoneWidth = 205;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        zoneWidth = 265;
      } else {
        zoneWidth = 0;
      }
    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Long){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        zoneWidth = 110;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        zoneWidth = 183;
      } else {
        zoneWidth = 0;
      }
    } else {
      zoneWidth = 0;
    }

  } else if(expEnv.expType==ExpType.deAcc){
    if(expEnv.zoneArrivalTime == zoneArrivalTime_Short){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        zoneWidth = 80;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        zoneWidth = 230;
      } else {
        zoneWidth = 0;
      }
    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Medium){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        zoneWidth = 80;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        zoneWidth = 120;
      } else {
        zoneWidth = 0;
      }
    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Long){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        zoneWidth = 65;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        zoneWidth = 85;
      } else {
        zoneWidth = 0;
      }
    } else {
      zoneWidth = 0;
    }

  } else if(expEnv.expType==ExpType.uniSpeed){
    if(expEnv.zoneArrivalTime == zoneArrivalTime_Short){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        zoneWidth = 160;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        zoneWidth = 210;
      } else {
        zoneWidth = 0;
      }
    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Medium){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        zoneWidth = 115;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        zoneWidth = 155;
      } else {
        zoneWidth = 0;
      }
    } else if(expEnv.zoneArrivalTime == zoneArrivalTime_Long){
      if(expEnv.zoneStayTime == zoneStayTime_Short){
        zoneWidth = 60;
      } else if(expEnv.zoneStayTime == zoneStayTime_Long){
        zoneWidth = 120;
      } else {
        zoneWidth = 0;
      }
    } else {
      zoneWidth = 0;
    }
  } else {
    zoneWidth = 0;
  }
  
  return zoneWidth;
}